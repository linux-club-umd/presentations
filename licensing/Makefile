PANDOC_OPTS += --slide-level 2
PANDOC_OPTS += --bibliography references.yaml --citeproc

.PHONY: all
all: slides.pdf slides.html

slides.pdf: slides.md references.yaml
	pandoc slides.md -t beamer -o slides.pdf $(PANDOC_OPTS) --standalone

slides.html: slides.md references.yaml
	pandoc slides.md -t revealjs -o slides.html $(PANDOC_OPTS) --standalone --embed-resources
