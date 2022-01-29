# Enable bash completion for the AWS CLI.
aws_completer=/usr/local/bin/aws_completer
[[ -x $aws_completer ]] && complete -C $aws_completer aws
