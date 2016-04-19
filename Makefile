SHELL=/bin/bash
MAKEFLAGS += --no-print-directory

all: 
	@make neko

cpp:
	@make bcpp
	@make rcpp

bcpp:
	openfl build linux -debug

rcpp:
	cd bin/linux64/cpp/bin; find . -type f | xargs file | grep 'ELF.*executable' | awk -F: '{print $1}' | while read line; do; eval $line; done; cd -

neko:
	@make bneko
	@make rneko

bneko:
	openfl build neko -debug --connect 4000

rneko:
	cd bin/linux64/neko/bin && ./Fe || true

html5:
	@make bhtml5
	@make rhtml5

bhtml5:
	openfl build html5 -debug --connect 4000

rhtml5:
	python2 -m SimpleHTTPServer &
	google-chrome-beta --new-window 'localhost:8000/bin/html5/bin/index.html'
