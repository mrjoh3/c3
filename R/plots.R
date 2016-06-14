
#' Barplot for C3
#'
#' @param c3
#' @param statcked
#' @param rotated
#' @param bar_width
#' @return c3
#' @export
#'
#' @examples
#'\dontrun{
#' data.frame(a=c(1,2,3,2),b=c(2,3,1,5)) %>%
#'   c3() %>%
#'   c3_bar()
#'   }
#'
c3_bar <- function(c3, stacked=FALSE, rotated=FALSE, bar_width = 0.6, zerobased = TRUE) {

  require(jsonlite)

  c3$x$data$type <- 'bar'

  c3$x$axis = list(
    x = list(
      type = 'category' #// this needed to load string x value
    ),
    rotated = rotated
  )

  c3$x$bar = list(
    zerobased = zerobased,
    width = list(
      ratio = bar_width #// this makes bar width 50% of length between ticks
    )
    #// or
    #//width: 100 // this makes bar width 100px
  )

  if (stacked) {
    group <- c3$x$data$keys
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$data$groups <- toJSON(group)
  }


  return(c3)

}



#' Title
#'
#' @param c3
#' @param type
#' @param stacked
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
c3_line <- function(c3, type, stacked, ...) {

  stopifnot(type %in% c('line', 'spline', 'step', 'area', 'area-step'))
  c3$x$data$type <- type

  if (stacked) {
    group <- c3$x$data$keys
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$data$groups <- toJSON(group)
  }

  return(c3)

}



#' Title
#'
#' @param c3
#' @param type
#' @param stacked
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
c3_mixedGeom <- function(c3, type, stacked, ...) {

  stopifnot(type %in% c('line', 'spline', 'step', 'area', 'area-step'))
  c3$x$data$type <- type

  if (stacked) {
    group <- c3$x$data$keys
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$data$groups <- toJSON(group)
  }

  return(c3)

}



#' Title
#'
#' @param c3
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
c3_scatter <- function(c3, ...) {

  # take a two column dataframe x and y, if third charactor/factor column group
  # might need to add data here or add groupby option to c3() later prob best

  stopifnot('xs' %in% names(c3$x$data))

  c3$x$data$type <- 'scatter'

  # currently we are losing proper axis labels
  # c3$x$axis$x$label <- c3$x$data$xs[[1]]
  # c3$x$axis$y$label <- names(c3$x$data$xs)

  return(c3)

}
