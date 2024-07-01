package dockerfile_validation

import rego.v1

deny_port_22 contains msg if {
	input[i].cmd == "expose"
	port := to_number(input[i].value)
	port != 22
	msg := "Ensure Dockerfile does not expose port"
}
