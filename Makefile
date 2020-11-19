app:
	Rscript -e "shiny::runApp()"
	
test:
	Rscript -e "testthat::test_dir('tests/testthat')"
	
style:
	Rscript -e "styler::style_dir()"