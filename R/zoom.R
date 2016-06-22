



#' Modify zoom
#'
#' This is an S3 method.
#' @family zoom
#' @export
zoom <- function(x, ...){
  UseMethod('zoom')
}

#' Add Zoom
#' @description Enable chart Zoom
#' @param c3
#' @param enabled boolean
#' @param rescale boolean
#' @param extent numeric vector
#' @param onzoom character js function, wrap character or character vector in JS()
#' @param onzoomstart character js function, wrap character or character vector in JS()
#' @param onzoomend character js function, wrap character or character vector in JS()
#'
#' @family c3
#' @family zoom
#' @return c3
#' @export
#'
#' @examples
#' \dontrun{
#' data.frame(a = abs(rnorm(20) * 10),
#'            b = abs(rnorm(20) * 10),
#'            date = seq(as.Date("2014-01-01"), by = "month", length.out = 20)) %>%
#'      c3(x = 'date') %>%
#'      zoom()
#' }
#'
zoom.c3 <- function(c3, ...){

  #stopifnot()

  zoom <- modifyList(
    list(
      enabled = TRUE,
      rescale = NULL,
      extent = NULL,
      onzoom = NULL,
      onzoomstart = NULL,
      onzoomend = NULL
    ), list(...), keep.null = FALSE
  )

  c3$x$zoom <- zoom

  return(c3)

  }
