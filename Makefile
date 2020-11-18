style:
	Rscript -e "styler::style_dir()"

app:
	Rscript -e "shiny::runApp()"