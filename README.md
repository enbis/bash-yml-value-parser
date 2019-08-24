# bash-yml-value-parser

bash function to parse yml file. Useful implementation to extract values from config.yml file ( e.g. Makefile solution ).
 
`make test PARAM=<parameter>` where `parameter` is the field of the config file you want to obtain

Nested parameters can be extracted using the notation `.` e.g. `make test PARAM=first.second`.

In case of nested values, don't specify the second level of value will return all the nested object.

### Errors handling

- ./function.sh: Permission denied -> `chmod +x function.sh` provide execute permission