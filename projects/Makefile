PARENT_DIR = ../../projects

%.html: $(PARENT_DIR)/%.Rmd
	Rscript -e "rmarkdown::render(\"$<\")"

%.pdf: $(PARENT_DIR)/%.tex
	pdflatex $<

%.pdf: $(PARENT_DIR)/%.Rmd $(PARENT_DIR)/header.tex $(PARENT_DIR)/footer.tex
	Rscript -e "rmarkdown::render(\"$<\")"
	mv $(PARENT_DIR)/$*.pdf .

%.pdf: $(PARENT_DIR)/%.Rnw
	Rscript -e "knitr::knit2pdf(\"$<\")"

clean:
	rm -f *.aux *.log *.toc *.bbl *.blg *.out
