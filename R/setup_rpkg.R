#' Setup configuration for shiny page views, likes and followers
#'
#' Utilize the rpkg.net API to store and retrieve page views, likes and followers
#'
#' @param viewsID Optional. The container ID to display views
#' @param likesID Optional. The button ID to display likes
#' @param followID Optional. The button ID to display followers
#' @param session Optional. Current session to track
#' @param inputId The input slot that will be used to access the value.
#' @param icon.follow Optional. shiny::icon() to activate follow
#' @param icon.unfollow Optional. shiny::icon() to de-activate follow
#' @param icon.like Optional. shiny::icon() to activate likes
#' @param icon.unlike Optional. shiny::icon() to de-activate likes
#' @param text.follow Optional. text to activate follow
#' @param text.unfollow Optional. text to de-activate follow
#' @param text.like Optional. text to activate likes
#' @param text.unlike Optional. text to de-activate likes
#' @param icon Optional. A shiny::icon() to appear on the button.
#' @param width Optional. The width of the button input, e.g. '500px', or '100\%'
#' @param suffix suffix to add to likes or followers count
#' @param ... Optional. Named attributes to be applied to the likes or follows button or views box.
#' @rdname rpkgapi
#' @examples
#' \donttest{
#' library(shiny)
#' library(shinyStorePlus)
#'
#' if (interactive()) {
#'
#' # replace UI with more elements
#' ui <- fluidPage(
#'   initStore("rpkg",rpkg.api.key =
#'   "c20c5eead7714c119dd3f20bd249a388e72db2aa0f9305d0380b683a37c5296a")
#' )
#'
#' # this example is focused on the server
#' server <- function(input, output, session) {
#'   setupRPKG(
#'     session = session,
#'     viewsID = "viewsshow",
#'     likesID = "liket",
#'     followID = "followt",
#'     icon.follow = shiny::icon("user-plus"),
#'     icon.unfollow = shiny::icon("user-minus"),
#'     icon.like = shiny::icon("thumbs-up"),
#'     icon.unlike = shiny::icon("thumbs-down"),
#'     text.follow = "Follow us!",
#'     text.unfollow = "Unfollow us!",
#'     text.like = "Like us!",
#'     text.unlike = "Unlike us!"
#'  )
#' }
#'
#'
#' shinyApp(ui = ui, server = server)
#' }
#' }
#'
#' @description
#' To unlock this functionality, you'll need to obtain a FREE API key from https://api.rpkg.net \cr
#' However, before requesting your API key, it's recommended to do an initial deployment of your app.
#' This is because the API key generation process requires you to provide the link to your Shiny app.
#'
#' @export
setupRPKG <-
  function(viewsID = NULL,
           likesID = NULL,
           followID = NULL,
           session = getDefaultReactiveDomain(),
           icon.follow = shiny::icon("user"),
           icon.unfollow = shiny::icon("user",class = "fa-solid"),
           icon.like = shiny::icon("heart"),
           icon.unlike = shiny::icon("heart",class = "fa-solid"),
           text.follow = "",
           text.unfollow = "",
           text.like = "",
           text.unlike = ""
           ) {
  envir <- parent.frame()
  input <- envir$input
  output <- envir$output
  # input$totalviewstracker # retrieve views value
  shiny::observeEvent(input$feedliketracker,{
    if(input$feedliketracker$liked == TRUE)
      shiny::updateActionButton(session,likesID, label = text.unlike, icon = icon.unlike)
    if(input$feedliketracker$liked == FALSE)
      shiny::updateActionButton(session,likesID, label = text.like, icon = icon.like)
  })

  shiny::observeEvent(input$feedfollowtracker,{
    if(input$feedfollowtracker$followed == TRUE)
      shiny::updateActionButton(session,followID, label=text.unfollow, icon = icon.unfollow)
    if(input$feedfollowtracker$followed == FALSE)
      shiny::updateActionButton(session,followID, label=text.follow, icon = icon.follow)
  })

  session$sendCustomMessage(
    "triggerViewsLikesFollows",
    list(
      views = viewsID,
      likes = likesID,
      follows = followID
    )
  )
}



#' @rdname rpkgapi
#' @export
viewsBox<- function(inputId,...){
  shiny::tags$span(
    id = inputId,
    class = "shinyspviewsbox shiny-bound-input",
    style = "display:inline-block",
    ...
  )
}

#' @rdname rpkgapi
#' @export
lfButton <- function(inputId,
                     width = NULL,
                     suffix = "",
                     ...) {
  shiny::tags$span(
    shiny::actionButton(
    inputId =  inputId, label = "", icon = shiny::icon("circle-dot",class = "fa-solid"), width = width, class="shinysplfbtn", style="pading:3px; border-radius:5px", ...
  ),
  shiny::tags$b(
  shiny::tags$span(id = paste0(inputId,"-totalv2"), class="shinysplfbtn-totl", style="display:inline-block; padding:0 5px;"),
  shiny::tags$span(id = paste0(inputId,"-totalv3"), class="shinysplfbtn-totl2", suffix)
  )
  )
}





