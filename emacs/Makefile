.PHONY: all
all: init.el

init.el: init.org
	emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "init.org" "init.el")'
