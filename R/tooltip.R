


#' Modify plot elements that relate to the second y-axis.
#'
#' This is an S3 method.
#' @family tooltip
#' @export
tooltip <- function(x, ...){
  UseMethod('tooltip')
}

#' Title
#'
#' @param c3
#' @param show boolean
#' @param grouped boolean
#' @param format list with options:
#' \itemize{
#'  \item{title}{: character js function}
#'  \item{name}{: character js function}
#'  \item{value}{: character js function}
#' }
#' @param position character js function
#' @param contents character js function
#'
#' @family c3
#' @family tooltip
#' @return c3
#' @export
#'
#' @examples
tooltip.c3 <- function(c3, ...){

  tooltip <- list(show = TRUE,
               grouped = TRUE,
               format = NULL,
               position = NULL,
               contents = NULL
  )

  tooltip <- modifyList(tooltip, list(...))

  tooltip <- Filter(Negate(function(x) is.null(unlist(x))), tooltip)

  c3$x$tooltip <- tooltip

  return(c3)

}
