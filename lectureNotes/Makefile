PARENT_DIR = ../../lectureNotes

%.pdf: $(PARENT_DIR)/%.Rmd $(PARENT_DIR)/header.tex $(PARENT_DIR)/footer.tex
	Rscript -e "rmarkdown::render(\"$<\")"
	mv $(PARENT_DIR)/$*.pdf .
