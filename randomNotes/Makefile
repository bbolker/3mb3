PARENT_DIR = ../../randomNotes

%.html: $(PARENT_DIR)/%.[rR]md
	Rscript -e "rmarkdown::render(\"$<\",output_format=\"html_document\")"
	mv $(PARENT_DIR)/$*.html .


