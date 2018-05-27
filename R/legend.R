

#' @rdname legend.c3
#' @family legend
#' @export
legend <- function(c3,
                   hide = FALSE,
                   position = NULL,
                   inset = NULL,
                   item = NULL,
                   ...){
  UseMethod('legend')
}

#' @title C3 Legend Options
#' @description Modify plot elements that relate to the legend. The c3 legend is on by default, this function allows the
#' legend to be removed, or other legend attributes to be set.
#'
#' @param c3 c3 htmlwidget object
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
#' @param ... additional options passed to the legend object
#'
#' @family c3
#' @family legend
#' @return c3
#' @export
#'
#' @examples
#' iris %>%
#'  c3(x='Sepal_Length', y='Sepal_Width', group = 'Species') %>%
#'  c3_scatter() %>%
#'  legend(position = 'right')
#'
legend.c3 <- function(c3,
                      hide = FALSE,
                      position = NULL,
                      inset = NULL,
                      item = NULL,
                      ...){

  legend <- list(hide = hide,
               position = position,
               inset = inset,
               item = item
  )

  legend <- modifyList(legend, list(...))

  legend <- Filter(Negate(function(x) is.null(unlist(x))), legend)

  c3$x$legend <- legend

  return(c3)

}
