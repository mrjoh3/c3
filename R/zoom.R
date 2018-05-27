



#' @rdname zoom.c3
#' @family zoom
#' @export
zoom <- function(c3,
                 enabled = TRUE,
                 rescale = NULL,
                 extent = NULL,
                 onzoom = NULL,
                 onzoomstart = NULL,
                 onzoomend = NULL,
                 ...){
  UseMethod('zoom')
}

#' @title Add C3 Zoom
#' @description Enable chart Zoom.
#'
#' @param c3 c3 htmlwidget object
#' @param enabled boolean default is TRUE
#' @param rescale boolean rescale axis when zooming
#' @param extent numeric vector
#' @param onzoom character js function, wrap character or character vector in JS()
#' @param onzoomstart character js function, wrap character or character vector in JS()
#' @param onzoomend character js function, wrap character or character vector in JS()
#' @param ... additional options passed to the zoom object
#'
#' @family c3
#' @family zoom
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = abs(rnorm(20) * 10),
#'            b = abs(rnorm(20) * 10)) %>%
#'      c3() %>%
#'      zoom()
#'
zoom.c3 <- function(c3,
                    enabled = TRUE,
                    rescale = NULL,
                    extent = NULL,
                    onzoom = NULL,
                    onzoomstart = NULL,
                    onzoomend = NULL,
                    ...){

  #stopifnot()

  zoom <- modifyList(
    list(
      enabled = enabled,
      rescale = rescale,
      extent = extent,
      onzoom = onzoom,
      onzoomstart = onzoomstart,
      onzoomend = onzoomend
    ), list(...), keep.null = FALSE
  )

  c3$x$zoom <- zoom

  return(c3)

  }
