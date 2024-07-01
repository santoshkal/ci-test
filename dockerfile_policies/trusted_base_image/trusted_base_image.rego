package dockerfile_validation

import rego.v1

trusted_base_image contains msg if {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "cgr.dev"
    msg :="Ensure Dockerfile uses hardened base image from Chainguard"
}

trusted_base_image contains msg if {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "chainguard"
    msg :="Ensure Dockerfile uses hardened base image from Chainguard"
}
