#' @title C3
#' @description The `c3` package is a wrapper, or \href{http://www.htmlwidgets.org/}{htmlwidget}, for the \href{http://c3js.org/}{c3} javascript charting library by \href{https://github.com/masayuki0812}{Masayuki Tanaka}.
#' @param labels character or list with otpions:
#'  \itemize{
#'  \item{format}{: list format functions for each parameter label (see \href{http://c3js.org/reference.html#data-labels}{c3 data-labels})}
#' }
#' @param hide booleen or character vector of parameters to hide
#' @param onclick character js function, wrap character or character vector in JS()
#' @param onmouseover character js function, wrap character or character vector in JS()
#' @param onmouseout character js function, wrap character or character vector in JS()
#' @param axes list, use to assign plot elements to secondary y axis
#' @importFrom utils modifyList
#' @importFrom dplyr mutate select n group_by_
#' @importFrom data.table dcast setDT
#' @importFrom stats formula
#' @importFrom lazyeval interp
#' @family c3
#' @export
#'
#' @examples
#'\dontrun{
#' data <- data.frame(a = c(1,2,3,2), b = c(2,3,1,5))
#'
#' data %>%
#'   c3(onclick = htmlwidgets::JS("function(d, element){console.log(d)}"))
#'
#' data %>%
#'   c3(axes = list(a = 'y',
#'                  b = 'y2')) %>%
#'   y2Axis()
#'
#' data.frame(sugar = 20, fat = 45, salt = 10) %>%
#'   c3(onclick = htmlwidgets::JS("function(d, element){dp = d}")) %>%
#'   c3_pie()
#'   }
#'
c3 <- function(data, x = NULL, y = NULL, group = NULL, message = NULL, width = NULL, height = NULL, ...) {

  # create data object
  data.object <- list(
    #x = x,
    xFormat = NULL,
    xLocaltime = NULL,
    xSort = NULL,
    names = NULL,
    classes = NULL,
    axes = NULL,
    type = NULL,
    types = NULL,
    labels = NULL,
    order = NULL,
    regions = NULL, # may need to pull this out into separate function
    colors = NULL, # pullcolor and colors into separate function
    color = NULL,
    hide = NULL,
    empty = NULL,
    onclick = NULL,
    onmouseover = NULL,
    onmouseout = NULL
  )

  data.object <- modifyList(data.object, list(...))

  #options carried through, used to store info about data for later validation
  opts = list(x = x,
              y = y,
              types = lapply(data, class))

  # check for and replace '.' in column names
  names(data) <- gsub('\\.', '_', names(data))

  # if x and y not defined drop non-numeric columns
  if (is.null(x) & is.null(y)) {

    # deal with single column data.frames but ensure column is numeric
    if (ncol(data) == 1) {
        stopifnot(class(data[[1]]) == 'numeric')
    } else {
        data <- data[, grep('numeric', sapply(data, class))]
    }
  # if there is an x value but no y a data type needs to be defined
  } else if (!is.null(x) & is.null(y)) {

    data <- data[, c(grep(x, colnames(data)),
                     grep('numeric|integer', sapply(data, class)))]

    # define x axis type
    dtype <- switch(class(data[,x]),
                   'Date' = 'timeseries',
                   'character' = 'category',
                   'numeric' = 'indexed')

    #opts$xType = dtype

    # create axis
    axis <- list(x = list(label = x,
                         type = dtype))
    data.object$x <- x

  } else if (!is.null(x) & !is.null(y) & is.null(group)) {

    # preference is to have x and y defined
    # remove columns not in xy
    data <- data[, c(x,y)]

    # define x axis type
    dtype <- switch(class(data[,x]),
                   'Date' = 'timeseries',
                   'character' = 'category',
                   'numeric' = 'indexed')

    #opts$xType = dtype

    # create axis
    axis <- list(x = list(label = x,
                         type = dtype),
                y = list(label = y))

    data.object$x <- x

    xs <- list()
    xs[[y]] <- x

  } else if (!is.null(group)) {

    # if group defined must have x and y
    stopifnot(!is.null(x) & !is.null(y))

    #this option is currently only for grouped scatter plots

    # remove columns not in x,y,group
    data <- data[, c(x, y, group)]

    groups <- as.character(unique(data[,group]))

    flt_group <- interp(~(!is.na(var)), var = as.name(group))

    tmp.df <- group_by_(data, interp(~var, var = as.name(group))) %>%
      mutate(id = 1:n())

    # need to change columns to group, group_x in xs and in data dataframe
    data <- data.table::dcast(setDT(tmp.df), formula(sprintf('id ~ %s', group)), value.var = c(y,x)) %>%
      as.data.frame() %>%
      select(-id)

    xs <- list()

    # need to change columns to group, group_x in xs and in data dataframe
    for (g in groups) {
      xs[[g]] <- paste(g, 'x', sep = '_')

      colnames(data) <- sub(paste(y, g, sep = '_'), g, colnames(data))
      colnames(data) <- sub(paste(x, g, sep = '_'), paste(g, 'x', sep='_'), colnames(data))

    }

    axis <- list(x = list(label = x),
                y = list(label = y))


  } else {

    print('error')
    break

  }

  # append data to data.object
  data.object$json <- jsonlite::toJSON(data, dataframe = 'rows')
  data.object$keys <- jsonlite::toJSON(list(value = colnames(data)))

  data.object <- Filter(Negate(function(x) is.null(unlist(x))), data.object)



  if ('xs' %in% ls()) {data.object$xs <- xs}

  x <- list(
    data = data.object,
    opts = opts
  )

  if ('axis' %in% ls()) {x$axis <- axis}

  # create widget
  htmlwidgets::createWidget(
    name = 'c3',
    x,
    width = width,
    height = height,
    package = 'c3',
    sizingPolicy = htmlwidgets::sizingPolicy(
      #viewer.padding = 0,
      #viewer.paneHeight = 500,
      browser.fill = TRUE,
      viewer.fill = TRUE,
      knitr.defaultWidth = 800,
      knitr.defaultHeight = 400
    )
  )
}

#' Shiny bindings for c3
#'
#' Output and render functions for using c3 within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a c3
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name c3-shiny
#'
#' @export
c3Output <- function(outputId, width = '100%', height = '100%'){
  htmlwidgets::shinyWidgetOutput(outputId, 'c3', width, height, package = 'c3')
}

#' @rdname c3-shiny
#' @export
renderC3 <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, c3Output, env, quoted = TRUE)
}

