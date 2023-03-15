.PHONY: all
all: slides.pdf slides.html

slides.pdf: slides.md
	pandoc slides.md -t beamer -o slides.pdf \
		--standalone \
		--slide-level 2

slides.html: slides.md
	pandoc slides.md -t revealjs -o slides.html \
		--standalone --embed-resources \
		--slide-level 2
