#' Load the example for the package
#'
#' Example of a shiny application with secure in-browser storage of inputs when changed
#'
#' @param name the name of example to view. choices include storeInputs or browserLinkToInput or shinyWidgetsExamples
#'
#' @note Changes made to the input or putputs will be saved and returned when the page is refresh within the same browser over different sessions. More examples are located at https://github.com/oobianom/aagarw30_shinyapps_to-shinyStorePlus
#' @return An example of inputs persistently stored when changed and the page refreshed
#' @examples
#' \donttest{
#' if (interactive()) {
#'   seeexample()
#'   seeexample("browserLinkToInput")
#' }
#' }
#'
#' @export

seeexample <- function(name = c("storeInputs","browserLinkToInput","shinyWidgetsExamples")) {
  name <- match.arg(name) #get the example to view
  ssp <- "shinyStorePlus" #set the name of the package
  ex.dir <- file.path(find.package(package = ssp), "example",name) #path to the example
  message(paste0("The source files for this example is located at ", ex.dir))
  if (interactive()) {
    shiny::runApp(ex.dir)
  }
}
