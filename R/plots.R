
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
c3_bar <- function(c3, stacked=FALSE, rotated=FALSE, bar_width = 0.6) {

  c3$x$data$type <- 'bar'

  c3$x$axis = list(
    x = list(
      type = 'category' #// this needed to load string x value
    ),
    rotated = rotated
  )

  c3$x$bar = list(
    width = list(
      ratio = bar_width #// this makes bar width 50% of length between ticks
    )
    #// or
    #//width: 100 // this makes bar width 100px
  )
  if (stacked) {
    group <- c3$x$data$keys
    if (!is.null(c3$x$x)) {
      group <- group[-grep(c3$x$x, group)]
    }
    c3$x$data$groups <- toJSON(group)
  }


  return(c3)

}
