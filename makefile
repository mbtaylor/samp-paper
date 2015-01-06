
.SUFFIXES: .tex .pdf .view

PAPER = acsamp
PDFLATEX = pdflatex
FIGURES = topology-a.png \
          topcat-cassis.png vizier-voplot.png ds9-ngc5194-f.png \
          linked-ir.png

build: $(PAPER).pdf

view: $(PAPER).view

clean:
	rm -f $(PAPER).{aux,log,out,spl,pdf,bbl,blg} version.tex

$(PAPER).pdf: $(PAPER).tex bibsamp.bib version.tex $(FIGURES)
	$(PDFLATEX) $(PAPER) \
        && bibtex $(PAPER) \
        && $(PDFLATEX) $(PAPER) \
        && $(PDFLATEX) $(PAPER) \
        && $(PDFLATEX) $(PAPER)

version.tex: $(PAPER).tex bibsamp.bib makefile
	echo Version: \
            `git show -s --format=%h` \
             \(`git show -s --format=%ci | sed 's/:[0-9]* .*//'`\) \
             `git status -s | grep -v '^.. acsamp.pdf *$$' \
                            | grep -q '^[MADRU ][MADRU ]' \
                  && echo - modified` \
             >$@

archive: acsamp_src.zip

acsamp_src.zip:
	jar cfM $@ $(PAPER).tex bibsamp.bib $(FIGURES)

.pdf.view:
	test -f $< && acroread -geometry +50+50 -openInNewWindow $<
	
