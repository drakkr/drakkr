# Makefile for Drakkr documentation

all: doc-pdf

doc-pdf:
	pandoc -N --template=drakkr-template_fr.latex --variable lang=french -o Drakkr-1.0_fr.pdf drakkr-head_fr.md drakkr-manifesto_fr.md drakkr-framework_fr.md

doc-odt:
	pandoc -o Drakkr-1.0_fr.odt  drakkr-head_fr.md drakkr-manifesto_fr.md drakkr-framework_fr.md

doc-html:
	pandoc --self-contained -o Drakkr-1.0_fr.html  drakkr-head_fr.md drakkr-manifesto_fr.md drakkr-framework_fr.md
