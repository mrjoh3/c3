




#' @rdname xAxis.c3
#' @family xAxis
#' @export
xAxis <- function(c3,
                  show = TRUE,
                  type = 'indexed',
                  localtime = NULL,
                  categories = NULL,
                  max = NULL,
                  min = NULL,
                  padding = list(),
                  height = NULL,
                  extent = NULL,
                  label = NULL,
                  ...){
  UseMethod('xAxis')
}


#' @title C3 Axis
#' @description Modify plot elements that relate to the axis.
#'
#' @param c3 c3 htmlwidget object
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
#' label position options for horizontal axis are:
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
#' @param inner boolean show axis inside chart (Y and Y2 axis only)
#' @param inverted boolean TRUE will reverse the direction of the axis (Y and Y2 axis only)
#' @param center integer or numeric value for center line (Y and Y2 axis only)
#' @param ... additional options passed to the axis object
#'
#' @family c3
#' @family xAxis
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a=c(1,2,3,2),b=c(2,3,1,5)) %>%
#'   c3(axes = list(a = 'y',
#'                  b = 'y2')) %>%
#'    xAxis(label = list(text = 'testing',
#'                       position = 'inner-center')) %>%
#'    y2Axis()
#'
xAxis.c3 <- function(c3,
                     show = TRUE,
                     type = 'indexed',
                     localtime = NULL,
                     categories = NULL,
                     max = NULL,
                     min = NULL,
                     padding = list(),
                     height = NULL,
                     extent = NULL,
                     label = NULL,
                     ...){

    x <- list(show = show,
             type = type, # 'timeseries' or 'category'
             localtime = localtime,
             categories = categories,
             max = max,
             min = min,
             padding = padding,
             height = height,
             extent = extent,
             label = label
             )

  # culling needs to be done separately as is dependant on type

  x <- modifyList(x, list(...))
  x <- Filter(Negate(function(x) is.null(unlist(x))), x)

  # check data types match
  if (x$type == 'timeseries') {
    if (is.null(c3$x$opts$x)) {
      warning('xaxis column must be set before type')
    } else if (c3$x$opts$types[c3$x$opts$x] != 'Date') {
    warning('Axis type "timeseries" does not match data types')
    message(paste(sapply(names(c3$x$opts$types), function(x) {
      paste0(as.character(x), ": ",
             c3$x$opts$types[[x]])}),
      collapse = '\n'))
    }
  }

  c3$x$axis$x <- x
  return(c3)
}


#' @rdname xAxis.c3
#' @family yAxis
#' @export
yAxis <- function(c3,
                  show = TRUE,
                  inner = NULL,
                  max = NULL,
                  min = NULL,
                  padding = NULL,
                  inverted = NULL,
                  center = NULL,
                  label = NULL,
                  ...){
  UseMethod('yAxis')
}

#' @rdname xAxis.c3
#' @family yAxis
#' @export
yAxis.c3 <- function(c3,
                     show = TRUE,
                     inner = NULL,
                     max = NULL,
                     min = NULL,
                     padding = NULL,
                     inverted = NULL,
                     center = NULL,
                     label = NULL,
                     ...){

  y <- list(show = show,
            inner = inner, # show inside axis
            max = max,
            min = min,
            padding = padding,
            inverted = inverted,
            center = center,
            label = label
  )

  y <- modifyList(y, list(...))

  y <- Filter(Negate(function(x) is.null(unlist(x))), y)

  c3$x$axis$y <- y
  return(c3)
}

#' @rdname xAxis.c3
#' @family y2Axis
#' @export
y2Axis <- function(c3,
                   show = TRUE,
                   inner = NULL,
                   max = NULL,
                   min = NULL,
                   padding = NULL,
                   inverted = NULL,
                   center = NULL,
                   label = NULL,
                   ...){
  UseMethod('y2Axis')
}

#' @rdname xAxis.c3
#' @family yAxis
#' @export
y2Axis.c3 <- function(c3,
                      show = TRUE,
                      inner = NULL,
                      max = NULL,
                      min = NULL,
                      padding = NULL,
                      inverted = NULL,
                      center = NULL,
                      label = NULL,
                      ...){

  y2 <- list(show = show,
             inner = inner, # show inside axis
             max = max,
             min = min,
             padding = padding,
             inverted = inverted,
             center = center,
             label = label
  )

  y2 <- modifyList(y2, list(...))

  y2 <- Filter(Negate(function(x) is.null(unlist(x))), y2)

  c3$x$axis$y2 <- y2
  return(c3)
}

#' @title Axis Tick Options
#' @description Modify axis tick formatting options
#'
#' @param c3 c3 htmlwidget object
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
#' @param ... additional options passed to axis tick object
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = c(1,2,3,2), b = c(2,4,1,5)) %>%
#'   c3() %>%
#'   tickAxis('y', values = c(1,3))
#'
tickAxis <- function(c3,
                     axis,
                     centered = TRUE,
                     format = NULL,
                     culling = NULL,
                     count = NULL,
                     fit = TRUE,
                     values = NULL,
                     rotate = 0,
                     outer = TRUE,
                     ...) {

  stopifnot(!missing(axis),
            axis %in% c('x', 'y', 'y2'))

  tick <- list(
    centered = centered,
    format = format, # y2 y
    culling = culling,
    count = count, # y2 y
    fit = fit,
    values = values, # y2 y
    rotate = rotate,
    outer = outer # y2 y
  )

  tick <- modifyList(tick, list(...))

  if (axis %in% c('y', 'y2')) {
    tick <- tick[c('format', 'count', 'values', 'outer')]
  }

  tick <- Filter(Negate(function(x) is.null(unlist(x))), tick)


  c3$x$axis[[axis]]$tick <- tick

  return(c3)
}

#' @rdname RColorBrewer.c3
#' @family RColorBrewer
#' @export
RColorBrewer <- function(c3, pal='Spectral'){
  UseMethod('RColorBrewer')
}

#' @title RColorBrewer Palette
#' @description Use RColorBrewer palettes
#'
#' @param c3 c3 htmlwidget object
#' @param pal character palette must match `RColorBrewer::brewer.pal.info`
#'
#' @importFrom jsonlite fromJSON
#'
#' @return c3
#' @family c3
#' @family RColorBrewer
#' @export
#'
#' @examples
#' data.frame(a = c(1,2,3,2), b = c(2,4,1,5), c = c(5,3,4,1)) %>%
#'   c3() %>%
#'   RColorBrewer()
#'
RColorBrewer.c3 <- function(c3, pal='Spectral') {

  n <- length(jsonlite::fromJSON(c3$x$data$keys)$value)

  if (!is.null(c3$x$data$type)) {
    if (c3$x$data$type == 'scatter') {
      n <- n / 2
    }
  }

  c3$x$color$pattern <- RColorBrewer::brewer.pal(n, pal)

  return(c3)
  }




#' @title Viridis Palette
#' @description Use Viridis palette options
#'
#' @param c3 c3 htmlwidget object
#' @param pal character palette options
#'
#' @importFrom jsonlite fromJSON
#' @importFrom viridis viridis
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = c(1,2,3,2), b = c(2,4,1,5)) %>%
#'   c3() %>%
#'   c3_viridis()
#'
c3_viridis <- function(c3, pal='D') {

  n <- length(fromJSON(c3$x$data$keys)$value)

  if (!is.null(c3$x$data$type)) {
    if (c3$x$data$type == 'scatter') {
      n <- n / 2
    }
  }

  c3$x$color$pattern <- strtrim(viridis(n, option = pal), 7)

  return(c3)
}

#' @title Colour Palette
#' @description Manually assign colours
#'
#' @param c3 c3 htmlwidget object
#' @param colours character vector of colours
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = c(1,2,3,2), b = c(2,4,1,5)) %>%
#'   c3() %>%
#'   c3_colour(c('red','black'))
#'
c3_colour <- function(c3, colours) {

  c3$x$color$pattern <- colours

  return(c3)
}


#' @title Color Palette
#' @description Manually assign colors
#'
#' @param c3 c3 htmlwidget object
#' @param colors character vector of colors
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = c(1,2,3,2), b = c(2,4,1,5)) %>%
#'   c3() %>%
#'   c3_color(c('red','black'))
#'
c3_color <- function(c3, colors) {

  c3$x$color$pattern <- colors

  return(c3)
}


#' @title Data Select
#'
#' @description Define options for selecting data within the plot area
#' @param c3 c3 htmlwidget object
#' @param enabled boolean
#' @param grouped boolean
#' @param multiple boolean
#' @param draggable boolean
#' @param isselectable character js function, wrap character or character vector in JS()
#' @param ... additional options passed to data selection object
#'
#' @importFrom htmlwidgets JS
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = c(1,2,3,2), b = c(2,3,1,5)) %>%
#'   c3() %>%
#'   c3_selection(enabled = TRUE,
#'                multiple = TRUE)
#'
c3_selection <- function(c3,
                         enabled = FALSE,
                         grouped = FALSE,
                         multiple = FALSE,
                         draggable = FALSE,
                         isselectable = JS('function () { return true; }'),
                         ...) {

  selection <- modifyList(
    list(
      enabled = enabled,
      grouped = grouped,
      multiple = multiple,
      draggable = draggable,
      isselectable = isselectable # takes a function to define selectable
    ),
    list(...)
  )

  if (class(selection$isselectable) != "JS_EVAL") {
    selection$isselectable <- JS(selection$isselectable)
  }

  c3$x$data$selection <- selection

  return(c3)

}



#' @title Chart Size
#'
#' @description Modify the size of the chart within the htmlwidget area. Generally charts size
#' to the div in which they are placed. These options enable finer scale sizing with the div
#' @param c3 c3 htmlwidget object
#' @param left integer padding pixels
#' @param right integer padding pixels
#' @param top integer padding pixels
#' @param bottom integer padding pixels
#' @param width integer pixels
#' @param height integer pixels
#' @param ... additional options passed to the padding and size objects
#'
#' @return c3
#' @export
#'
#' @examples
#' data.frame(a = c(1,2,3,2), b = c(2,4,1,5)) %>%
#'   c3() %>%
#'   c3_chart_size(width = 600, height = 200)
#'
c3_chart_size <- function(c3,
                          left = NULL,
                          right = NULL,
                          top = NULL,
                          bottom = NULL,
                          width = NULL,
                          height = NULL,
                          ...) {

  padding <- modifyList(
    list(
      left = left,
      right = right,
      top = top,
      bottom = bottom),
    list(...)
    )

  size <- modifyList(
    list(width = width,
         height = height),
    list(...)
  )

  c3$x$padding <- padding
  c3$x$size <- size

  return(c3)
}



#' @title Point Options
#'
#' @description Modify point options
#' @param c3 c3 htmlwidget object
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
#' data.frame(a = c(1,2,3,2), b = c(2,4,1,5)) %>%
#'   c3() %>%
#'   point_options(r = 5, expand.r = 2)
#'
point_options <- function(c3,
                          show = TRUE,
                          r = 2.5,
                          expand = TRUE,
                          expand.r = 1.75,
                          select.r = 4) {
    # add option for where r is a vector
    if (length(r) > 1) {

        #stopifnot(length(r) == length(fromJSON(c3$x$data$json)))

        js_func <- 'function(d) {
                      var size = [%s]
                      return (size[d.index]) * %s;
                      }'

        r <- JS(sprintf(js_func, paste(r, collapse = ','), 1)) # need better way to scale size

        point <- list(
            show = show,
            r = r
        )

    } else {
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
    }

    c3$x$point <- point

    return(c3)
}
