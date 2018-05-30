#' Pipe operator
#'
#' Imports the pipe operator from magrittr.
#'
#' @export
#' @param lhs a \code{\link{c3}} object
#' @param rhs a pie settings function
#' @rdname pipe
#' @examples
#' data.frame(a=c(1,2,3,2),b=c(2,3,1,5)) %>%
#'   c3()
`%>%` <- magrittr::`%>%`
