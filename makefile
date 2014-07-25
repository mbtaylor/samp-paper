
.SUFFIXES: .tex .pdf .view

PAPER = acsamp
PDFLATEX = pdflatex

build: $(PAPER).pdf

view: $(PAPER).view

clean:
	rm -f $(PAPER).{aux,log,out,spl,pdf,bbl,blg} version.tex

$(PAPER).pdf: $(PAPER).tex bibsamp.bib version.tex
	$(PDFLATEX) $(PAPER) \
        && bibtex $(PAPER) \
        && $(PDFLATEX) $(PAPER) \
        && $(PDFLATEX) $(PAPER)

version.tex: $(PAPER).tex bibsamp.bib makefile
	echo Version: \
            `git show -s --format=%h` \
             \(`git show -s --format=%ci | sed 's/:[0-9]* .*//'`\) \
             `git status -s | grep -q '^[MADRU ][MADRU ]' \
                  && echo - modified` \
             >$@

.pdf.view:
	test -f $< && acroread -geometry +50+50 -openInNewWindow $<
	
