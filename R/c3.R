#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
c3 <- function(data, x = NULL, message = NULL, width = NULL, height = NULL) {

  # if x not defined drop non-numeric columns
  if (is.null(x)) {data <- data[, grep('numeric', sapply(data, class))]}

  # forward options using x
  x = list(
    data = list(
      json = jsonlite::toJSON(data, dataframe = 'rows'),
      keys = list(value = colnames(data))
    ),
    x = x
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

