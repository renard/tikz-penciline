
PACKAGE=tikz-penciline
VERSION := $(shell git describe HEAD | cut -d- -f1)
XELATEX=xelatex -interaction nonstopmode -shell-escape -output-directory .

all: doc

doc:
	# Need to be compiled twice.
	$(XELATEX) $(PACKAGE)-doc.tex
	$(XELATEX) $(PACKAGE)-doc.tex

zip:
	# Need to rename README.md to README.
	git archive HEAD --prefix=$(PACKAGE)-$(VERSION)/ --format=tar | tar -x -
	mv $(PACKAGE)-$(VERSION)/README.md $(PACKAGE)-$(VERSION)/README
	rm -f $(PACKAGE)-$(VERSION)/.gitignore
	zip -r $(PACKAGE)-$(VERSION).zip $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)
clean:
	rm -f *.{zip,aux,listing,log,out,pyg,toc}

dist-clean: clean
	rm -rf *.pdf
