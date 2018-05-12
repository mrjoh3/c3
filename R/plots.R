
#' @title Bar Plot
#'
#' @param c3
#' @param statcked boolean
#' @param rotated boolean
#' @param bar_width numeric
#' @param zerobased boolean
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
c3_bar <- function(c3, stacked = FALSE, rotated = FALSE, bar_width = 0.6, zerobased = TRUE) {

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
    group <- fromJSON(c3$x$data$keys)
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$data$groups <- toJSON(group)
  }


  return(c3)

}



#' @title Line Plot
#'
#' @param c3
#' @param type character type of line plot. Must be one of:
#' \itemize{
#'  \item{line}
#'  \item{spline}
#'  \item{step}
#'  \item{area}
#'  \item{area-step}
#' }
#' @param stacked boolean
#' @param connectNull boolean connect null (missing) data points
#' @param step_type character, one of:
#' \itemize{
#'  \item{step}
#'  \item{step-after}
#'  \item{step-before}
#' }
#'
#' @return c3
#' @export
#'
#' @examples
#' \dontrun{
#' data.frame(a=c(1,2,3,2),b=c(2,3,1,5)) %>%
#'   c3() %>%
#'   c3_line('spline')
#'   }
#'
c3_line <- function(c3, type, stacked = FALSE, connectNull = FALSE, step_type = NULL) {

  stopifnot(type %in% c('line', 'spline', 'step', 'area', 'area-step'))
  c3$x$data$type <- type

  if (stacked) {
    group <- fromJSON(c3$x$data$keys)
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$data$groups <- toJSON(group)
  }

  line = list()
  if (connectNull) {line$connectNull = TRUE}
  if (!is.null(step_type)) {line$step$type = step_type}

  if (length(line) > 0) {
    c3$x$line <- line
  }

  return(c3)

}



#' @title Mixed Geometry Plots
#'
#' @param c3
#' @param type
#' @param types list containing key value pairs of column header and plot type
#' @param stacked character vector of column headers to stack
#'
#' @return c3
#' @export
#'
#' @examples
#' \dontrun{
#' data <- data.frame(a = abs(rnorm(20) *10),
#'                    b = abs(rnorm(20) *10)
#'                    c = abs(rnorm(20) *10),
#'                    d = abs(rnorm(20) *10))
#' data %>%
#'   c3() %>%
#'   c3_mixedGeom(type = 'bar',
#'                stacked = c('b','d'),
#'                types = list(a='area',
#'                             c='spline'))
#' }
#'
c3_mixedGeom <- function(c3, types, type = 'line', stacked = NULL) {

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



#' @title Scatter Plots
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



#' @title Pie Charts
#'
#' @param c3
#' @param expand boolean expand segment on hover
#' @param show boolean show labels
#' @param threshold numeric proportion of segment to hide label
#' @param format character label js function, wrap character or character vector in JS()
#'ric
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
c3_pie <- function(c3, expand = TRUE, ...) {

  c3$x$data$type <- 'pie'

  label = modifyList(
    list(
      show = TRUE,
      threshold = NULL,
      format = NULL
    ),
    list(...), keep.null = FALSE
  )

  pie = list(
      expand = expand
    )

  if (length(label) > 0) {
    pie$label <- label
  }

  c3$x$pie <- pie

  return(c3)

}


#' @title Donut Charts
#'
#' @param c3
#' @param expand boolean expand segment on hover
#' @param title character
#' @param width integer pixels width of donut
#' @param show boolean show labels
#' @param threshold numeric proportion of segment to hide label
#' @param format character label js function, wrap character or character vector in JS()
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
c3_donut <- function(c3, expand = TRUE, title = NULL, width = NULL, ...) {

  c3$x$data$type <- 'donut'

  label = modifyList(
    list(
      show = TRUE,
      threshold = NULL,
      format = NULL
    ),
    list(...), keep.null = FALSE
  )

  donut = list(
      expand = expand,
      width = width
    )

  if (!is.null(title)) {
    donut$title <- title
  }

  if (length(label) > 0) {
    donut$label <- label
  }

  # remove nulls
  donut <- Filter(Negate(function(x) is.null(unlist(x))), donut)

  c3$x$donut <- donut

  return(c3)

}


#' @title Gauge Charts
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


