



#' Modify subchart
#'
#' This is an S3 method.
#' @family subchart
#' @export
subchart <- function(x, ...){
  UseMethod('subchart')
}

#' Add Subchart
#' @description subcharts are defined in multiple axis by passing a single `data.frame`
#' @param c3
#' @param height integer pixels
#' @param onbrush character js function, wrap character or character vector in JS()
#'
#' @family c3
#' @family subchart
#' @return c3
#' @export
#'
#' @examples
#' \dontrun{
#' data.frame(a = abs(rnorm(20) * 10),
#'            b = abs(rnorm(20) * 10),
#'            date = seq(as.Date("2014-01-01"), by = "month", length.out = 20)) %>%
#'      c3(x = 'date') %>%
#'      subchart(height = 20)
#' }
#'
subchart.c3 <- function(c3, height = 20, onbrush = NULL){

  #stopifnot()

  subchart <- list(
    show = TRUE,
    size = list(
      height = height
    )
  )

  if (!is.null(onbrush)) {
    subchart$onbrush <- onbrush
  }

  c3$x$subchart <- subchart

  return(c3)

  }
