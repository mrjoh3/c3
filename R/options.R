




#' Modify plot elements that relate to the x-axis.
#'
#' This is an S3 method.
#' @family xAxis
#' @export
xAxis <- function(x, ...){
  UseMethod('xAxis')
}


#' Modify plot elements that relate to the axis.
#'
#' @param c3
#' @param ...
#' @param show boolean
#' @param type character on of 'indexed', timeseries' or 'category'
#' @param localtime boolean
#' @param categories character vector. Can be used to modify axis labels. Not needed if
#' already defined in data
#' @param max numeric set value of axis range
#' @param min numeric set value of axis range
#' @param padding list with options:
#' \itemize{
#'  \item{left}{: numeric pixels}
#'  \item{right}{: numeric pixels}
#' }
#' @param height integer pixels to set height of axis
#' @param extent vector or character function (wrapped in JS()) that returns a vector of values
#' @param label can be character or list with options (see \href{http://c3js.org/reference.html#axis-x-label}{c3 axis-x-label}):
#' \itemize{
#'  \item{text}{: character}
#'  \item{position}{: character}
#' }
#' label position options for horixontal axis are:
#' \itemize{
#'  \item{inner-right}
#'  \item{inner-center}
#'  \item{inner-left}
#'  \item{outer-right}
#'  \item{outer-center}
#'  \item{outer-left}
#' }
#' label position options for vertical axis are:
#' \itemize{
#'  \item{inner-top}
#'  \item{inner-middle}
#'  \item{inner-bottom}
#'  \item{outer-top}
#'  \item{outer-middle}
#'  \item{outer-bottom}
#' }
#' @family c3
#' @family axis
#' @return c3
#' @export
#'
#' @examples
xAxis.c3 <- function(c3, ...){

    x = list(show = TRUE,
             type = 'indexed', # 'timeseries' or 'category'
             localtime = NULL,
             categories = NULL,
             max = NULL,
             min = NULL,
             padding = list(),
             height = NULL,
             extent = NULL,
             label = NULL
             )

  # culling needs to be done separately as is dependant on type

  x <- modifyList(x, list(...))
  x <- Filter(Negate(function(x) is.null(unlist(x))), x)

  c3$x$axis$x <- x
  return(c3)
}


#' Modify plot elements that relate to the y-axis. S3 Method
#'
#' This is an S3 method.
#' @family axis
#' @export
yAxis <- function(x, ...){
  UseMethod('yAxis')
}

#' @rdname xAxis.c3
#' @export
yAxis.c3 <- function(c3, ...){

  y <- list(show = TRUE,
            #type = 'indexed', # 'timeseries' or 'category'
            #default = c(0, 1000) # used to setup plot space without data (not implimented here)
            inner = NULL, # show inside axis
            max = NULL,
            min = NULL,
            padding = NULL,
            inverted = NULL,
            center = NULL,
            label = NULL
  )

  y <- modifyList(y, list(...))

  y <- Filter(Negate(function(x) is.null(unlist(x))), y)

  c3$x$axis$y <- y
  return(c3)
}

#' Modify plot elements that relate to the second y-axis. S3 Method
#'
#' This is an S3 method.
#' @family axis
#' @export
y2Axis <- function(x, ...){
  UseMethod('yAxis')
}

#' @rdname xAxis.c3
#' @export
y2Axis.c3 <- function(c3, ...){

  y2 <- list(show = TRUE,
            #type = 'indexed', # 'timeseries' or 'category'
            #default = c(0, 1000) # used to setup plot space without data (not implimented here)
            inner = NULL, # show inside axis
            max = NULL,
            min = NULL,
            padding = NULL,
            inverted = NULL,
            center = NULL,
            label = NULL
  )

  y2 <- modifyList(y2, list(...))

  y2 <- Filter(Negate(function(x) is.null(unlist(x))), y2)

  c3$x$axis$y2 <- y2
  return(c3)
}

#' Axis Tick Options
#'
#' @param c3
#' @param axis character 'x', 'y' or 'y2' axis
#' @param centered boolean (x-axis only)
#' @param format character js function, wrap character or character vector in JS()
#' @param culling boolean or list defining number of ticks `list(max = 5)` this
#' option effects tick labels  (x-axis only)
#' @param count integer number of ticks to display. This effects tick lines and labels
#' @param fit boolean position ticks evenly or set to values  (x-axis only)
#' @param values vector. Must match axis format type
#' @param rotate integer degrees to rotate labels  (x-axis only)
#' @param outer boolean show axis outer tick
#' @param ...
#'
#' @return c3
#' @export
#'
#' @examples
tickAxis <- function(c3, axis,  ...) {

  stopifnot(!missing(axis),
            axis %in% c('x', 'y', 'y2'))

  tick = list(
    centered = TRUE,
    format = NULL, # y2 y
    culling = NULL,
    count = NULL, # y2 y
    fit = TRUE,
    values = NULL, # y2 y
    rotate = 0,
    outer = TRUE # y2 y
  )

  tick <- modifyList(tick, list(...))

  if (axis %in% c('y', 'y2')) {
    tick <- tick[c('format', 'count', 'values', 'outer')]
  }

  tick <- Filter(Negate(function(x) is.null(unlist(x))), tick)


  c3$x$axis[[axis]]$tick <- tick

  return(c3)
}

#' RColorBrewer Palette S3 Method
#'
#' This is an S3 method.
#' @family RColorBrewer
#' @export
RColorBrewer <- function(x, ...){
  UseMethod('RColorBrewer')
}

#' RColorBrewer Palette
#'
#' @param c3
#' @param pal character palette must match `RColorBrewer::brewer.pal.info`
#' @param ...
#'
#' @return c3
#' @family c3
#' @family RColorBrewer
#' @export
#'
#' @examples
RColorBrewer.c3 <- function(c3, pal='Spectral', ...) {

  require(RColorBrewer)

  n <- length(c3$x$data$keys$value)

  if (!is.null(c3$x$data$type)) {
    if (c3$x$data$type == 'scatter') {
      n <- n / 2
    }
  }

  #colors <- list() # list of colours per parameter
  #color <- '' #js function

  #c3$x$data$colors <- colors
  c3$x$color$pattern <- brewer.pal(n, pal)

  return(c3)
  }




#' Viridis Paletta
#'
#' @param c3
#' @param pal character palette options
#' @param ...
#'
#' @return c3
#' @export
#'
#' @examples
c3_viridis <- function(c3, pal='D', ...) {

  require(viridis)

  n <- length(c3$x$data$keys$value)

  if (!is.null(c3$x$data$type)) {
    if (c3$x$data$type == 'scatter') {
      n <- n / 2
    }
  }

  #colors <- list() # list of colours per parameter
  #color <- '' #js function

  #c3$x$data$colors <- colors
  c3$x$color$pattern <- strtrim(viridis(n, option = pal), 7)

  return(c3)
}



#' Data Select
#'
#' @description Define options for selecting data within the plot area
#' @param c3
#' @param enabled boolean
#' @param groued boolean
#' @param multiple boolean
#' @param draggable boolean
#' @param isselectable character js function, wrap character or character vector in JS()
#'
#' @return c3
#' @export
#'
#' @examples
c3_selection <- function(c3, ...) {

  selection <- modifyList(
    list(
      enabled = FALSE,
      grouped = FALSE,
      multiple = FALSE,
      draggable = FALSE,
      isselectable = NULL # takes a function to define selectable
    ),
    list(...)
  )

  c3$x$data$selection <- selection

  return(c3)

}



#' Chart Size
#'
#' @description Modify the size of the chart within the htmlwidget area. Generally charts size
#' to the div in which they are placed. These options enable finer scale sizing with the div
#' @param c3
#' @param left integer padding pixels
#' @param right integer padding pixels
#' @param top integer padding pixels
#' @param bottom integer padding pixels
#' @param width integer pixels
#' @param height integer pixels
#'
#' @return c3
#' @export
#'
#' @examples
c3_chart_size <- function(c3, ...) {

  padding <- modifyList(
    list(
      left = NULL,
      right = NULL,
      top = NULL,
      bottom = NULL),
    list(...)
    )

  size <- modifyList(
    list(width = NULL,
         height = NULL),
    list(...)
  )

  c3$x$padding <- padding
  c3$x$size <- size

  return(c3)
}



#' Point Options
#'
#' @description Modify point options
#' @param c3
#' @param show boolean
#' @param r numeric radius of point
#' @param expand boolean
#' @param expand.r numeric multiplier for radius expansion
#' @param select.r numeric multiplier for radius expansion

#'
#' @return c3
#' @export
#'
#' @examples
point_options <- function(c3,
                          show = TRUE,
                          r = 2.5,
                          expand = TRUE,
                          expand.r = 1.75,
                          select.r = 4) {

  point <- list(
    show = show,
    r = r,
    focus = list(
      expand = list(
        enabled = expand,
        r = r * expand.r
      )
    ),
    select = list(
      r = r * select.r
    )
  )

  c3$x$point <- point

  return(c3)
}
