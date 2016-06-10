




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
#' ##' \itemize{
##'  \item{text}{: character}
##'  \item{position}{: boolean default NULL}
##' }
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
