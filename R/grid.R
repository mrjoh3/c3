


#' @title C3 Grid
#' @description Modify grid and line elements on both x and y axis. This is an S3 method.
#' @family grid
#' @export
grid <- function(x, ...){
  UseMethod('grid')
}

#' @title C3 Grid
#' @description Modify grid and line elements on both x and y axis
#'
#' @param c3 c3 htmlwidget object
#' @param axis character 'x' or 'y'
#' @param show boolean
#' @param lines dataframe with options:
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
#' \dontrun{
#' iris %>%
#'  c3(x='Sepal_Length', y='Sepal_Width', group = 'Species') %>%
#'  c3_scatter() %>%
#'  grid('y') %>%
#'  grid('x', show=F, lines = data.frame(value=c(5,6),
#'                                       text= c('Line 1','Line 2')))
#' }
#'
grid.c3 <- function(c3, axis, ...){

  stopifnot(!missing(axis))

  grid <- list(show = TRUE,
               lines = NULL, # show inside axis
               ticks = NULL # only for yAxis
  )

  grid <- modifyList(grid, list(...))

  grid <- Filter(Negate(function(x) is.null(unlist(x))), grid)

  c3$x$grid[[axis]] <- grid

  return(c3)

  }
