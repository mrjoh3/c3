




#' Modify plot elements that relate to the x-axis.
#'
#' This is an S3 method.
#' @family xAxis
#' @export
xAxis <- function(x, ...){
  UseMethod('xAxis')
}


#' Title
#'
#' @param c3
#' @param ...
#'
#' @param label can be character or list with options (see \href{http://c3js.org/reference.html#axis-x-label}{c3 axis-x-label}):
#' \itemize{
#'  \item{text}{: character}
#'  \item{position}{: boolean default NULL}
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


#' Modify plot elements that relate to the y-axis.
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

#' Modify plot elements that relate to the second y-axis.
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

#' Title
#'
#' @param c3
#' @param axis character 'x' or 'y' axis
#' @param centered
#' @param format
#' @param culling
#' @param count
#' @param fit
#' @param values
#' @param rotate
#' @param outer
#' @param multiline
#' @param ...
#'
#' @return c3
#' @export
#'
#' @examples
tickAxis <- function(c3, axis,  ...) {

  stopifnot(!missing(axis),
            axis %in% c('x', 'y'))

  tick = list(
    centered = TRUE,
    format = NULL,
    culling = NULL,
    count = NULL,
    fit = TRUE,
    values = NULL,
    rotate = 0,
    outer = TRUE,
    multiline = FALSE
  )

  tick <- Filter(Negate(function(x) is.null(unlist(x))), tick)

  tick <- modifyList(tick, list(...))

  c3$x$axis[[axis]]$tick <- tick

  return(c3)
}


#' Title
#'
#' @param c3
#' @param ...
#'
#' @return c3
#' @export
#'
#' @examples
c3_RcolorBrewer <- function(c3, pal='Spectral', ...) {

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


#' Title
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

c3_selection <- function(c3, ...) {

  selection <- list(
    enabled = FALSE,
    grouped = FALSE,
    multiple = FALSE,
    draggable = FALSE,
    isselectable = NULL # takes a function to define selectable
  )

  selection <- modifyList(selection, list(...))

  c3$x$data$selection <- selection

}


