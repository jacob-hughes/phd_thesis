.SUFFIXES: .ltx .ps .pdf .svg

.svg.pdf:
	inkscape --export-pdf=$@ $<

LATEX_FILES = thesis.ltx

DIAGRAMS =

all: thesis.pdf

clean:
	rm -f ${DIAGRAMS}
	rm -f thesis.aux thesis.bbl thesis.blg thesis.dvi thesis.log thesis.pdf thesis.toc thesis.out thesis.snm thesis.nav thesis.vrb texput.log
	rm -f thesis_preamble.fmt thesis_preamble.log

thesis.pdf: bib.bib ${LATEX_FILES} ${DIAGRAMS} thesis_preamble.fmt
	pdflatex thesis.ltx
	bibtex thesis
	pdflatex thesis.ltx
	pdflatex thesis.ltx

thesis_preamble.fmt: thesis_preamble.ltx
	set -e; \
	  tmpltx=`mktemp`; \
	  cat ${@:fmt=ltx} > $${tmpltx}; \
	  grep -v "%&${@:_preamble.fmt=}" ${@:_preamble.fmt=.ltx} >> $${tmpltx}; \
	  pdftex -ini -jobname="${@:.fmt=}" "&pdflatex" mylatexformat.ltx $${tmpltx}; \
	  rm $${tmpltx}

bib.bib: softdevbib/softdev.bib
	softdevbib/bin/prebib softdevbib/softdev.bib > bib.bib

softdevbib/softdev.bib:
	git submodule init
	git submodule update
