SHELL=/bin/bash
MAKEFLAGS += --no-print-directory

all: 
	@make neko

cpp:
	@make bcpp
	@make rcpp

bcpp:
	lastOpenflBuild='cpp'
	openfl build linux -debug

rcpp:
	cd bin/linux64/cpp/bin; find . -type f | xargs file | grep 'ELF.*executable' | awk -F: '{print $1}' | while read line; do; eval $line; done; cd -

neko:
	@make bneko
	@make rneko

bneko:
	lastOpenflBuild='neko'
	openfl build neko -debug

rneko:
	cd bin/linux64/neko/bin && ./Fe || true
