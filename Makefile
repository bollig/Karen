all: karen.pdf

# Simple case:  no figures or BibTeX
karen.pdf: karen.tex
	pdflatex karen
	pdflatex karen
	pdflatex karen

# More complicated case:  BibTeX invoked, PostScript figures
bibpost:
	latex karen
	bibtex karen
	latex karen
	latex karen
	dvipdf karen

# If all figures are PDF'd, then we can use pdflatex instead
# (This requires changing the [dvips] driver to [pdftex]
# on the \usepackage{graphics} line in karen.tex.)
bibpdf:
	pdflatex karen
	bibtex karen
	pdflatex karen
	pdflatex karen

distclean:
	-@rm *.{aux,toc,dvi,lof,lot,log,lom,bbl,blg,ps,out} *~
