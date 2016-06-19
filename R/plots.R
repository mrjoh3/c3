
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
c3_line <- function(c3, type, stacked = FALSE, ...) {

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
#' @param types list containing key value pairs of column header and plot type
#' @param stacked character vector of column headers to stack
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
c3_mixedGeom <- function(c3, types, type = 'line', stacked = NULL, ...) {

  stopifnot(type %in% c('bar', 'line', 'spline', 'step', 'area', 'area-step'))

  c3$x$data$type <- type
  c3$x$data$types <- types

  if (!is.null(stacked)) {
    group <- stacked
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



#' Title
#'
#' @param c3
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
#'\dontrun{
#' data.frame(red=20,green=45,blue=10) %>%
#'   c3() %>%
#'   c3_pie()
#'   }
#'
c3_pie <- function(c3, ...) {

  c3$x$data$type <- 'pie'

  return(c3)

}


#' Title
#'
#' @param c3
#' @param title chasracter
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
#'\dontrun{
#' data.frame(red=20,green=45,blue=10) %>%
#'   c3() %>%
#'   c3_donut(title = 'Colors')
#'   }
#'
c3_donut <- function(c3, title = NULL, ...) {

  c3$x$data$type <- 'donut'

  if (!is.null(title)) {
    c3$x$donut$title <- title
  }

  return(c3)

}


#' Title
#'
#' @param c3
#' @param label list with options:
#' \itemize{
#'  \item{show}{: boolean}
#'  \item{format}{: function, wrap in JS() }
#' }
#' @param min numeric
#' @param max numeric
#' @param units character appended to numeric value
#' @param width integer pixel width of the arc
#' @param pattern character vector or pallete of colors
#' @param threshold list with options:
#' \itemize{
#'  \item{unit}{: character one of 'percent', 'value'}
#'  \item{max}{: numeric}
#'  \item{values}{: numeric vector of threhold values for color change}
#' }
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
#'\dontrun{
#' data.frame(red=20,green=45,blue=10) %>%
#'   c3() %>%
#'   c3_donut(title = 'Colors')
#'   }
#'
c3_gauge <- function(c3, ...) {

  c3$x$data$type <- 'gauge'

  gauge <- modifyList(
    list(label = NULL,
         min = 0,
         max = 100,
         units = NULL,
         width = NULL
         ), list(...))

  # color and size might move to separate functions
  color <- modifyList(
    list(
      pattern = c('#FF0000', '#F97600', '#F6C600', '#60B044'),
      threshold = list(
        unit = 'value',
        max = 100,
        values = c(30, 60, 90, 100)
      )
    ), list(...))

  size = modifyList(
    list(
      height = NULL
    ), list(...))

  c3$x$gauge <- gauge
  c3$x$color <- color
  c3$x$size <- size

  return(c3)

}


