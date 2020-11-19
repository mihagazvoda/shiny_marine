# shiny_marine

This is source code for Shiny app for displaying Marine data. You can see it in action [here](https://mihagazvoda.shinyapps.io/marine/).

## Usage

1. Save Marine data inside your project to `./data/ships.csv`. 
2. Run `make app` in your terminal or `shiny::runApp()` in your console to run the app. 
3. To run unit tests, use `make test` in your terminal. 

## Comment

This app was due to a short time frame created as a minimum viable product. I wanted to present most of the skills without spending too much time on any. 

## Possible improvements

* The whole app could be a package. 
* Use [renv](https://rstudio.github.io/renv/) package to improve dependency management.  
* More attractive UI.
* More and better unit tests.
* Add documentation for all functions.
