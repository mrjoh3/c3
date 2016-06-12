


#' Modify plot elements that relate to the second y-axis.
#'
#' This is an S3 method.
#' @family grid
#' @export
grid <- function(x, ...){
  UseMethod('grid')
}

#' Title
#'
#' @param c3
#' @param axis character 'x' or 'y'
#' @param show boolean
#' @param lines vector of lists each with options:
#' \itemize{
#'  \item{value}{: numeric, character or date depending on axis}
#'  \item{text}{: character (optional)}
#'  \item{class}{: character css class (optional)}
#'  \item{position}{: character one of 'start', 'middle', 'end' (optional)}
#' }
#'
#' @family c3
#' @family grid
#' @return c3
#' @export
#'
#' @examples
grid.c3 <- function(c3, axis, ...){

  grid <- list(show = TRUE,
               lines = NULL, # show inside axis
               ticks = NULL # only for yAxis
  )

  grid <- modifyList(grid, list(...))

  grid <- Filter(Negate(function(x) is.null(unlist(x))), grid)

  c3$x$grid[[axis]] <- grid

  return(c3)

  }
