



#' @rdname region.c3
#' @family region
#' @export
region <- function(c3, regions){
  UseMethod('region')
}

#' @title Modify region elements on both x and y axis
#' @description Regions are defined in multiple axis by passing a single `data.frame`
#' @param c3 c3 htmlwidget object
#' @param regions data.frame with columns listed below. Any columns can be missing but results may be unexpected.
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
#' iris %>%
#'  c3(x = 'Sepal_Length', y = 'Sepal_Width', group = 'Species') %>%
#'  c3_scatter() %>%
#'  region(data.frame(axis = 'x',
#'                    start = 5,
#'                    end = 6))
#'
region.c3 <- function(c3, regions){

  stopifnot(class(regions) == 'data.frame',
            all(colnames(regions) %in% c('axis', 'start', 'end', 'class')))

  c3$x$regions <- regions

  return(c3)

  }
