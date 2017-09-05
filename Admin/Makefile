PARENT_DIR = ../../Admin

%.html: $(PARENT_DIR)/%.Rmd $(PARENT_DIR)/schedule.Rmd $(PARENT_DIR)/schedule.csv
	Rscript -e "rmarkdown::render(\"$<\")"
	mv $(PARENT_DIR)/$*.html .


