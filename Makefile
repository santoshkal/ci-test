# Define version files
DOCKERFILE_VERSION_FILE=.github/scripts/dockerfile_version.env
KUBERNETES_VERSION_FILE=.github/scripts/tf_version.env
REPO='santoshkal/ci-test/artifcts' 
# Define commands to extract version
define get_version
grep '^$(1)_VERSION=' $(2) | cut -d '=' -f 2
endef

# Targets to fetch versions
dockerfile_version:
	$(eval VERSION=$(call get_version,DOCKERFILE_POLICIES_VERSION,$(DOCKERFILE_VERSION_FILE)))
	@echo "VERSION=$(VERSION)"
	@echo "::set-output name=new_version::$(VERSION)"

kubernetes_version:
	$(eval VERSION=$(call get_version,TERRAFORM_POLICIES_VERSION,$(KUBERNETES_VERSION_FILE)))
	@echo "VERSION=$(VERSION)"
	@echo "::set-output name=new_version::$(VERSION)"

# Target to push Docker image (example for dockerfile policies)
push_dockerfile_policies: dockerfile_version
	@docker login ghcr.io -u $(GITHUB_ACTOR) -p $(GITHUB_TOKEN)
	@GENVAL_OUTPUT=$(shell genval artifact push --reqinput ./dockerfile_policies \
		--dest oci://ghcr.io/$(GITHUB_REPOSITORY)/dockerfile_policies:$(VERSION) \
		--annotations="authors=$(GITHUB_ACTOR)")
	@echo "${GENVAL_OUTPUT}"
	@echo "DOCKERFILE_POLICIES=oci://ghcr.io/$(GITHUB_REPOSITORY)/dockerfile_policies:$(VERSION)" >> $GITHUB_ENV

# Additional targets can be added for other policies in a similar manner

