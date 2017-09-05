PARENT_DIR = ../../Admin

%.html: $(PARENT_DIR)/%.Rmd
	Rscript -e "rmarkdown::render(\"$<\")"
	mv $(PARENT_DIR)/$*.html .

schedule.html: $(PARENT_DIR)/schedule.Rmd $(PARENT_DIR)/schedule.csv
	Rscript -e "rmarkdown::render(\"$<\")"
	mv $(PARENT_DIR)/schedule.html .

