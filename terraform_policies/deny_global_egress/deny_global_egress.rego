package validate_input_tf

import rego.v1


deny_global_egress contains msg if {
	input.resource[_].aws_security_group
	eg := input.resource[_].aws_security_group.allow_tls.egress[_]
	denied_cidr := "0.0.0.0/0"
	global := eg.cidr_blocks[_]
	not contains(global, denied_cidr)
	msg:= "Security group does not allow egress from all addresses"
}
