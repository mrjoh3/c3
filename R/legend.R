

#' Modify plot elements that relate to the second y-axis.
#'
#' This is an S3 method.
#' @family legend
#' @export
legend <- function(x, ...){
  UseMethod('legend')
}

#' Title
#'
#' @param c3
#' @param hide boolean or character of parameters to hide
#' @param position character one of 'bottom', 'right', 'inset'
#' @param inset list with options:
#' \itemize{
#'  \item{anchor}{: character one of 'top-left', 'top-right', 'bottom-left', 'bottom-right'}
#'  \item{x}{: integer pixels}
#'  \item{y}{: integer pixels}
#'  \item{step}{: numeric}
#' }
#' @param item list with options:
#' \itemize{
#'  \item{onclick}{: character js function, wrap character or character vector in JS()}
#'  \item{onmouseover}{: character js function, wrap character or character vector in JS()}
#'  \item{onmouseout}{: character js function, wrap character or character vector in JS()}
#' }
#' @param ...
#'
#' @family c3
#' @family legend
#' @return c3
#' @export
#'
#' @examples
legend.c3 <- function(c3, ...){

  legend <- list(hide = TRUE,
               position = NULL,
               inset = NULL,
               item = NULL
  )

  legend <- modifyList(legend, list(...))

  legend <- Filter(Negate(function(x) is.null(unlist(x))), legend)

  c3$x$legend <- legend

  return(c3)

}
