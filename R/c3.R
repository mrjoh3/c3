#' <Add Title>
#'
#' <Add Description>
#'
#' @param labels character or list with otpions:
#'  \itemize{
#'  \item{format}{: list format functions for each parameter label (see \href{http://c3js.org/reference.html#data-labels}{c3 data-labels})}
#' }
#' @param hide booleen or character vector of parameters to hide
#' @import htmlwidgets
#' @family c3
#' @export
c3 <- function(data, x = NULL, y = NULL, group = NULL, message = NULL, width = NULL, height = NULL) {

  require(dplyr)
  require(data.table)

  # if group defined must have x and y
  #stopifnot()

  #options carried through
  opts = list(x = x,
              y = y)

  # check for and replace '.' in column names
  names(data) <- gsub('\\.', '_', names(data))

  # if x and y not defined drop non-numeric columns
  if (is.null(x) & is.null(y)) {
    data <- data[, grep('numeric', sapply(data, class))]
  } else if (!is.null(group)) {
    #this option is currently only for grouped scatter plots

    # remove columns not in x,y,group
    data <- data[, c(x, y, group)]

    groups <- as.character(unique(data[,group]))

    tmp.df <- group_by(data, Species) %>%
      mutate(id = 1:n())

    # need to change columns to group, group_x in xs and in data dataframe
    data <- dcast(setDT(tmp.df), id ~ Species, value.var = c(y,x)) %>%
      as.data.frame() %>%
      select(-id)

    xs = list()

    # need to change columns to group, group_x in xs and in data dataframe
    for (g in groups) {
      xs[[g]] = paste(g, 'x', sep = '_')

      colnames(data) <- sub(paste(y, g, sep = '_'), g, colnames(data))
      colnames(data) <- sub(paste(x, g, sep = '_'), paste(g, 'x', sep='_'), colnames(data))

    }


  } else {
    # preference is to have x and y defined
    # remove columns not in xy
    data <- data[, c(x,y)]
    xs = list()
    xs[[y]] = x
  }

  # create data object
  data = list(
    json = jsonlite::toJSON(data, dataframe = 'rows'),
    keys = list(value = colnames(data)),
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

  data <- Filter(Negate(function(x) is.null(unlist(x))), data)

  if ('xs' %in% ls()) {data$xs <- xs}

  axis = list(x = list(label = x),
              y = list(label = y))

  x = list(
    data = data,
    x = x,
    axis = axis,
    opts = opts
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'c3',
    x,
    width = width,
    height = height,
    package = 'c3'
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
c3Output <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'c3', width, height, package = 'c3')
}

#' @rdname c3-shiny
#' @export
renderC3 <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, c3Output, env, quoted = TRUE)
}

