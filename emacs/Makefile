.PHONY: all
all: init.el slides.pdf

init.el: slides.org
	emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "slides.org" "init.el")'

slides.pdf: slides.org
	emacs --batch --eval "(require 'org)" slides.org --eval '(org-beamer-export-to-pdf)'

.PHONY: test
test: init.el
	./test.sh
