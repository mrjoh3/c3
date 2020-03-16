

#' @title Check groups for stacked plots
#' @description For plots where stacking is required this function will
#' define the columns to be stacked based on column headers.
#'
#' @param c3 c3 htmlwidget object
#' @param stacked boolean
#'
#' @importFrom jsonlite fromJSON toJSON
#'
#' @return c3 object
#'
check_stacked <- function(c3, stacked) {

  if (stacked) {
    group <- fromJSON(c3$x$data$keys)
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$data$groups <- toJSON(group)
  }

  return(c3)

}


#' @title Bar Plot
#' @description Add bars to a C3 plot
#'
#' @param c3 c3 htmlwidget object
#' @param stacked boolean place bars on top of each other
#' @param rotated boolean use to make x-axis vertical
#' @param bar_width numeric pixel width of bars
#' @param zerobased boolean
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a=c(1,2,3,2),b=c(2,3,1,5)) %>%
#'   c3() %>%
#'   c3_bar(stacked = TRUE)
#'
c3_bar <- function(c3, stacked = FALSE, rotated = FALSE, bar_width = 0.6, zerobased = TRUE) {

  c3$x$data$type <- 'bar'

  c3$x$axis <- list(
    x = list(
      type = 'category' #// this needed to load string x value
    ),
    rotated = rotated
  )

  c3$x$bar <- list(
    zerobased = zerobased,
    width = list(
      ratio = bar_width #// this makes bar width 50% of length between ticks
    )
  )

  c3 <- check_stacked(c3, stacked)

  return(c3)

}



#' @title Line Plot
#' @description Add lines to a C3 plot
#'
#' @param c3 c3 htmlwidget object
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
#' data.frame(a=c(1,2,3,2),b=c(2,3,1,5)) %>%
#'   c3() %>%
#'   c3_line('spline')
#'
c3_line <- function(c3, type, stacked = FALSE, connectNull = FALSE, step_type = NULL) {

  stopifnot(type %in% c('line', 'spline', 'step', 'area', 'area-step'))
  c3$x$data$type <- type

  c3 <- check_stacked(c3, stacked)

  line <- list()

  if (connectNull) {line$connectNull <- TRUE}
  if (!is.null(step_type)) {line$step$type <- step_type}

  if (length(line) > 0) {
    c3$x$line <- line
  }

  return(c3)

}



#' @title Mixed Geometry Plots
#' @description Use multiple geometry types in a single plot
#'
#' @param c3 c3 htmlwidget object
#' @param type character default plot type where not defined
#' @param types list containing key value pairs of column header and plot type
#' @param stacked character vector of column headers to stack
#'
#' @importFrom jsonlite toJSON
#'
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
#'   c3_mixedGeom(type = 'bar',
#'                stacked = c('b','d'),
#'                types = list(a='area',
#'                             c='spline'))
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
#' @description For scatter plots options are defined in the `c3` function. Options are limited to x, y and groups
#'
#' @param c3 c3 htmlwidget object
#'
#' @return c3
#' @export
#'
#' @examples
#'   iris %>%
#'     c3(x = 'Sepal_Length',
#'        y = 'Sepal_Width',
#'        group = 'Species') %>%
#'     c3_scatter()
#'
c3_scatter <- function(c3) {

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
#' @description C3 Pie Charts
#'
#' @param c3 c3 htmlwidget object
#' @param expand boolean expand segment on hover
#' @param show boolean show labels
#' @param threshold numeric proportion of segment to hide label
#' @param format character label js function, wrap character or character vector in JS()
#' @param ... additional values passed to the pie label object
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(red = 20, green = 45, blue = 10) %>%
#'   c3() %>%
#'   c3_pie()
#'
c3_pie <- function(c3,
                   show = TRUE,
                   threshold = NULL,
                   format = NULL,
                   expand = TRUE, ...) {

  c3$x$data$type <- 'pie'

  label <- modifyList(
    list(
      show = show,
      threshold = threshold,
      format = format
    ),
    list(...), keep.null = FALSE
  )

  pie <- list(
      expand = expand
    )

  if (length(label) > 0) {
    pie$label <- label
  }

  c3$x$pie <- pie

  return(c3)

}


#' @title Donut Charts
#' @description Create simple Donut charts
#'
#' @param c3 c3 htmlwidget object
#' @param expand boolean expand segment on hover
#' @param title character
#' @param width integer pixels width of donut
#' @param show boolean show labels
#' @param threshold numeric proportion of segment to hide label
#' @param format character label js function, wrap character or character vector in JS()
#' @param ... additional values passed to the donut label object
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(red=20,green=45,blue=10) %>%
#'   c3() %>%
#'   c3_donut(title = 'Colors')
#'
c3_donut <- function(c3,
                     expand = TRUE,
                     title = NULL,
                     width = NULL,
                     show = TRUE,
                     threshold = NULL,
                     format = NULL, ...) {

  c3$x$data$type <- 'donut'

  label <- modifyList(
    list(
      show = show,
      threshold = threshold,
      format = format
    ),
    list(...), keep.null = FALSE
  )

  donut <- list(
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
#' @description Create simple Gauge Charts
#' @param c3 c3 htmlwidget object
#' @param label list with options:
#' \itemize{
#'  \item{show}{: boolean}
#'  \item{format}{: function, wrap in JS() }
#' }
#' @param min numeric
#' @param max numeric
#' @param units character appended to numeric value
#' @param height integer pixel height of the chart. Proportion of gauge
#' never changes so height scales with width despite this setting.
#' @param width integer pixel width of the arc
#' @param pattern character vector or palette of colors
#' @param threshold list with options:
#' \itemize{
#'  \item{unit}{: character one of 'percent', 'value'}
#'  \item{max}{: numeric}
#'  \item{values}{: numeric vector of threshold values for color change}
#' }
#' @param ... additional values passed to the gauge, color and size objects
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(data=10) %>%
#'   c3() %>%
#'   c3_gauge(title = 'Colors')
#'
c3_gauge <- function(c3,
                     label = NULL,
                     min = 0,
                     max = 100,
                     units = NULL,
                     width = NULL,
                     pattern = c('#FF0000', '#F97600', '#F6C600', '#60B044'),
                     threshold = list(
                       unit = 'value',
                       max = 100,
                       values = c(30, 60, 90, 100)
                     ),
                     height = NULL,
                     ...) {

  c3$x$data$type <- 'gauge'

  gauge <- modifyList(
    list(label = label,
         min = min,
         max = max,
         units = units,
         width = width
         ), list(...))

  # color and size might move to separate functions
  color <- modifyList(
    list(
      pattern = pattern,
      threshold = threshold
    ), list(...))

  size <- modifyList(
    list(
      height = height
    ), list(...))

  c3$x$gauge <- gauge
  c3$x$color <- color
  c3$x$size <- size

  return(c3)

}


