
.SUFFIXES: .tex .pdf .view

PAPER = acsamp
PDFLATEX = pdflatex

build: $(PAPER).pdf

view: $(PAPER).view

clean:
	rm -f $(PAPER).{aux,log,out,spl,pdf,bbl,blg}

$(PAPER).pdf: $(PAPER).tex bibsamp.bib
	$(PDFLATEX) $(PAPER) \
        && bibtex $(PAPER) \
        && $(PDFLATEX) $(PAPER) \
        && $(PDFLATEX) $(PAPER)

.pdf.view:
	test -f $< && acroread -geometry +50+50 -openInNewWindow $<
	
