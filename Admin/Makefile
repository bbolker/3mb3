%.html: ../../Admin/%.Rmd
	Rscript -e "rmarkdown::render(\"$<\")"
	mv ../../Admin/$*.html .
