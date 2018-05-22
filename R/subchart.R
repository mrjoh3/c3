



#' @rdname subchart.c3
#' @family subchart
#' @export
subchart <- function(c3,
                     height = 20,
                     onbrush = NULL){
  UseMethod('subchart')
}

#' @title Add Subchart
#' @description Subcharts are defined in multiple axis by passing a single `data.frame`. Subcharts are listed as an
#' experimental feature in the \href{http://c3js.org/reference.html#subchart-onbrush}{C3 documentation}).
#' @param c3 c3 htmlwidget object
#' @param height integer pixels
#' @param onbrush character js function, wrap character or character vector in JS()
#'
#' @importFrom htmlwidgets JS
#' @family c3
#' @family subchart
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = abs(rnorm(20) * 10),
#'            b = abs(rnorm(20) * 10),
#'            date = seq(as.Date("2014-01-01"), by = "month", length.out = 20)) %>%
#'      c3(x = 'date') %>%
#'      subchart(height = 20, onbrush = 'function (domain) { console.log(domain) }')
#'
subchart.c3 <- function(c3,
                        height = 20,
                        onbrush = NULL){

  subchart <- list(
    show = TRUE,
    size = list(
      height = height
    )
  )

  if (!is.null(onbrush)) {
    if (class(onbrush) != "JS_EVAL") {onbrush <- JS(onbrush)}
    subchart$onbrush <- onbrush
  }

  c3$x$subchart <- subchart

  return(c3)

  }
