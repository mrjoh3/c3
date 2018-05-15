


#' Modify plot elements that relate to tooltips.
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
#'  \item{title}{: character js function, wrap character or character vector in JS()}
#'  \item{name}{: character js function, wrap character or character vector in JS()}
#'  \item{value}{: character js function, wrap character or character vector in JS()}
#' }
#' @param position character js function, wrap character or character vector in JS()
#' @param contents character js function, wrap character or character vector in JS()
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
