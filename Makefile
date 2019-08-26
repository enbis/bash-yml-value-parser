PARAM?=username

test:
	@./function.sh _get_config_value $(FILE) $(PARAM)