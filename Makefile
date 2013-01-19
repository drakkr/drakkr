# Makefile for Drakkr documentation

all: doc-odt doc-pdf doc-html

doc-odt:
	pandoc -o Drakkr-1.0_fr.odt Drakkr-1.0_fr.md

doc-pdf:
	pandoc -N --template=drakkr-template_fr.latex --variable lang=french Drakkr-1.0_fr.md -o Drakkr-1.0_fr.pdf

doc-html:
	pandoc --self-contained -o Drakkr-1.0_fr.html Drakkr-1.0_fr.md
