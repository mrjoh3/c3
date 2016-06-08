
#' Barplot for C3
#'
#' @param c3
#'
#' @return c3
#' @export
#'
#' @examples
#'\dontrun{
#' data.frame(a=c(1,2,3,2),b=c(2,3,1,5)) %>%
#'   c3() %>%
#'   c3_bar()
#'   }
c3_bar <- function(c3, stacked=FALSE, rotated=NULL, bar_width = NULL) {

  c3$x$plot_type <- 'bar'

  c3$x$rotated <- rotated
  c3$x$bar_width <- bar_width

  if (stacked) {
    group <- c3$x$keys
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$groups <- group
  }

  return(c3)

}
