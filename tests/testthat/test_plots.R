
d <- data.frame(a = abs(rnorm(20) * 10),
                b = abs(rnorm(20) * 10),
                date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

d$c = abs(rnorm(20) *10)
d$d = abs(rnorm(20) *10)

cp <- c3(d)


## c3_bar()

test_that("bar plots works", {

  br <- c3_bar(cp)

  expect_equal(br$x$data$type, 'bar')

  expect_is(br, "c3")
  expect_is(br, "htmlwidget")

})

test_that('bar plots settings can be set', {

  br <- c3_bar(cp, stacked = TRUE, rotated = TRUE)
  grp <- fromJSON(br$x$data$groups)$value # indicates stacking

  expect_true(br$x$axis$rotated)
  expect_equal(grp, c("a","b","c","d"))

})


## c3_line()

test_that("C3 line options can be set", {

  c_l <- c3_line(cp, 'spline')

  expect_equal(c_l$x$data$type, 'spline')

  expect_is(c_l, "c3")
  expect_is(c_l, "htmlwidget")
})


## c3_mixedgeometry

test_that("C3 mixed geometry options can be set", {

  typs <- list(a='area',
               c='spline')
  mg <- c3_mixedGeom(cp, types = typs)

  expect_equal(mg$x$data$type, 'line') # default value
  expect_equal(mg$x$data$types$a, 'area')
  expect_equal(mg$x$data$types$c, 'spline')

  expect_is(mg, "c3")
  expect_is(mg, "htmlwidget")

})


## c3_scatter()

test_that('scatter plots work', {

  sp <- c3(iris,
           x = 'Sepal_Length',
           y = 'Sepal_Width',
           group = 'Species')

  sc <- c3_scatter(sp)

  expect_is(sc, "c3")
  expect_is(sc, "htmlwidget")


})
