FOLDERS=$$HOME/.*

create: clear

clear:
	@for j in $$HOME/.*; do \
		if [[ `realpath $$j` == `pwd`* ]]; then \
			rm $$j; \
		fi; \
	done; \
