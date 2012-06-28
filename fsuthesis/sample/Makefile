SRC = thesis.tex \
	chapter1.tex \
	chapter2.tex \
	chapter3.tex \
	chapter4.tex \
	appendix1.tex 

all: thesis.pdf

# The first run...
thesis.aux: $(SRC)
	pdflatex thesis

thesis.bbl: $(SRC) myrefs.bib thesis.aux
	bibtex thesis

# The final run...
thesis.pdf: $(SRC) thesis.bbl
	pdflatex thesis
	pdflatex thesis

thesis.dvi: $(SRC) myrefs.bib
	latex thesis
	bibtex thesis
	latex thesis
	latex thesis

thesis.ps: thesis.dvi
	dvips -o thesis.ps thesis.dvi

clean:
	-@rm thesis.{aux,toc,dvi,lof,lot,log,lom,bbl,blg,out}

veryclean: clean
	-@rm thesis.{ps,pdf} *~

distclean: clean
	-@rm thesis.ps *~
