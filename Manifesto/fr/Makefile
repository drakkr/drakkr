# Makefile for Drakkr Manifesto - French version

DOC=Drakkr

VERSION=1.0

LANG=fr

TITLE=Drakkr, la gouvernance ouverte

#List of edocs to be included in Gitit export
PAGES=drakkr-manifesto_$(LANG).md drakkr-framework_$(LANG).md

#List of edocs to be included in other exports
CHAPTERS=drakkr-head_$(LANG).md $(PAGES)

DOCNAME=$(DOC)-$(VERSION)_$(LANG)

doc-pdf:
	mkdir -p dist
	pandoc -N --toc --template=drakkr-template_$(LANG).latex --variable lang=french -o dist/$(DOCNAME).pdf $(CHAPTERS)

doc-odt:
	mkdir -p dist
	pandoc --toc -o dist/$(DOCNAME).odt $(CHAPTERS)

doc-html:
	mkdir -p dist
	pandoc --self-contained -o dist/$(DOCNAME).html $(CHAPTERS)

gitit:
	mkdir -p dist
	cp -R Images dist/.
	#Create summary Gitit page
	echo '---' > dist/$(DOCNAME).page
	echo 'title: $(TITLE)' >> dist/$(DOCNAME).page
	echo '...' >> dist/$(DOCNAME).page
	echo -e '\n' >> dist/$(DOCNAME).page

	$(foreach PAGE, $(PAGES), echo -e "[$(subst # ,,$(shell head -1 $(PAGE)))]($(basename $(PAGE))) \n" >> dist/$(DOCNAME).page ;)

	#Create Gitit pages with titles
	$(foreach PAGE, $(PAGES), echo -e "---\ntitle: $(subst # ,,$(shell head -1 $(PAGE)))\n...\n" > dist/$(basename $(PAGE)).page ; cat $(PAGE) >> dist/$(basename $(PAGE)).page ;)

clean:
	rm -Rf dist/