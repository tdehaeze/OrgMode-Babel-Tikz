# =============================================================
# Some Notes About Makefiles
# =============================================================
# cible: dependance
# 	commandes

# $@ 	Le nom de la cible
# $< 	Le nom de la première dépendance
# $^ 	La liste des dépendances
# $? 	La liste des dépendances plus récentes que la cible
# $* 	Le nom du fichier sans suffixe

# The .PHONY rule keeps make from processing a file named "watch" or "clean".
# =============================================================

# =============================================================
# Define Some Variables
# =============================================================
UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
PDFVIEWER = evince
endif

ifeq ($(UNAME), Darwin)
PDFVIEWER = open
endif

MAINDIRECTORY := $(shell pwd)
# =============================================================


# =============================================================
# Main builders
# =============================================================
all: pdf

# PDF
.PHONY: pdf
ifeq ($(f),)
pdf:
	cd figures/ && \
	for file in *.tex; do \
		latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles $${file} && \
		latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles -c $${file} && \
		pdfcrop "$${file%.tex}.pdf" "$${file%.tex}.pdf" ; \
	done
else
pdf:
	cd figures/ && \
	latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles $(f) && \
	latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles -c $(f) && \
	pdfcrop "$${f}.pdf" "$${f}.pdf" && \
	(${PDFVIEWER} $${f}.pdf &> /dev/null &)
endif

# Clean
.PHONY: clean
ifeq ($(f),)
clean:
	cd figures/ && \
	for file in *.tex; do \
		latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles -c $${file}
	done
else
clean:
	cd figures/ && \
		latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles -c $(f)
endif

# OPEN
.PHONY: open
ifeq ($(f),)
else
open:
	(${PDFVIEWER} figures/$(f).pdf &> /dev/null &)
endif

# WATCH
.PHONY: watch
ifeq ($(f),)
else
watch:
	cd figures/ && \
	latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles -pvc $(f) && \
	latexmk -r $(MAINDIRECTORY)/.latexmkrc_subfiles -c $(f) && \
	pdfcrop "$${f}.pdf" "$${f}.pdf"
endif

# TIKZ
.PHONY: tikz
ifeq ($(f),)
else
tikz:
	cp $(MAINDIRECTORY)/snippets/tikzpicture.tex $(MAINDIRECTORY)/tikz/$(f).tex
endif


