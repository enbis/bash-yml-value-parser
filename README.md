# bash-yml-value-parser

bash function to parse config.yml flat file. Useful implementation to extract the config value for a Makefile solution.
 
`make test PARAM=<parameter>` where `parameter` is the field of the config file you want to obtain

### Errors handling

- ./function.sh: Permission denied -> `chmod +x function.sh` provide execute permission