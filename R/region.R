



#' Modify region elements on both x and y axis
#'
#' This is an S3 method.
#' @family region
#' @export
region <- function(x, ...){
  UseMethod('region')
}

#' Title
#' @description Regions are defined in multiple axis by passing a single `data.frame`
#' @param c3
#' @param regions data.frame with columns:
#' \itemize{
#'  \item{axis}{: character one of 'x', 'y', 'y2'}
#'  \item{start}{: numeric but must match defined axis type}
#'  \item{end}{: numeric but must match defined axis type}
#'  \item{class}{: character css class}
#' }
#' @family c3
#' @family region
#' @return c3
#' @export
#'
#' @examples
#' \dontrun{
#' iris %>%
#'  c3(x='Sepal_Length', y='Sepal_Width', group = 'Species') %>%
#'  c3_scatter() %>%
#'  region(data.frame(axis = 'x',
#'                    start = 5,
#'                    end = 6))
#' }
#'
region.c3 <- function(c3, regions){

  #stopifnot()

  c3$x$regions <- regions

  return(c3)

  }
