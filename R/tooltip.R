


#' @rdname tooltip.c3
#' @family tooltip
#' @export
tooltip <- function(c3,
                    show = TRUE,
                    grouped = TRUE,
                    format = NULL,
                    position = NULL,
                    contents = NULL,
                    ...){
  UseMethod('tooltip')
}

#' @title C3 Tooltips
#' @description Modify plot elements that relate to tooltips. C3.js documentation contains an \href{http://c3js.org/samples/tooltip_format.html}{extended example}.
#'
#' @param c3 c3 htmlwidget object
#' @param show boolean show or hide tooltips
#' @param grouped boolean
#' @param format list with options:
#' \itemize{
#'  \item{title}{: character js function, wrap character or character vector in JS()}
#'  \item{name}{: character js function, wrap character or character vector in JS()}
#'  \item{value}{: character js function, wrap character or character vector in JS()}
#' }
#' @param position character js function, wrap character or character vector in JS()
#' @param contents character js function, wrap character or character vector in JS()
#' @param ... addition options passed to the tooltip object
#'
#' @family c3
#' @family tooltip
#' @return c3
#' @export
#'
#' @examples
#' data <- data.frame(a = abs(rnorm(20) *10),
#'                    b = abs(rnorm(20) *10),
#'                    c = abs(rnorm(20) *10),
#'                    d = abs(rnorm(20) *10))
#' data %>%
#'   c3() %>%
#'   tooltip(format = list(title = htmlwidgets::JS("function (x) { return 'Data ' + x; }"),
#'                         name = htmlwidgets::JS('function (name, ratio, id, index)',
#'                                                ' { return name; }'),
#'                         value = htmlwidgets::JS('function (value, ratio, id, index)',
#'                                                 ' { return ratio; }')))
#'
tooltip.c3 <- function(c3,
                       show = TRUE,
                       grouped = TRUE,
                       format = NULL,
                       position = NULL,
                       contents = NULL,
                       ...){

  tooltip <- list(show = show,
                   grouped = grouped,
                   format = format,
                   position = position,
                   contents = contents
      )

  tooltip <- modifyList(tooltip, list(...))

  tooltip <- Filter(Negate(function(x) is.null(unlist(x))), tooltip)

  c3$x$tooltip <- tooltip

  return(c3)

}
