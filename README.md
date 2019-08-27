# bash-yml-value-parser

bash function to parse yml file. Useful implementation to extract values from config.yml file ( e.g. Makefile solution ). This solution is able to manage one nested level.
 
`make test FILE=<file.yml> PARAM=<parameter>` where `parameter` is the field of the file you want achieve

Nested parameters can be extracted using the notation `.` e.g. `PARAM=first.second`.

In case of nested values, if the second level is not specified, will be returned all the nested object.

### Errors handling

- ./function.sh: Permission denied -> `chmod +x function.sh` provide execute permission