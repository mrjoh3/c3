d <- data.frame(a = abs(rnorm(20) * 10),
               b = abs(rnorm(20) * 10),
               date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

d$c = abs(rnorm(20) *10)
d$d = abs(rnorm(20) *10)

c <- c3(d)
c_l <- c3_line(c, 'spline')
# c_m <- c3_mixedGeom(c,
#                     type = 'bar',
#                     stacked = c('b','d'),
#                     types = list(a='area',
#                                  c='spline')
# )

test_that("a simple plot works", {
  expect_is(c, "c3")
  expect_is(c, "htmlwidget")
})

test_that("C3 line options can be set", {
  expect_equal(c_l$x$data$type, 'spline')

  expect_is(c_l, "c3")
  expect_is(c_l, "htmlwidget")
})


# test_that("C3 mixed geometry options can be set", {
#   # expect_equal(c_m$x$data$type, 'bar')
#   # expect_equal(c_m$x$data$types, list(a='area',
#   #                                     c='spline'))
#
#   expect_is(c_m, "c3")
#   expect_is(c_m, "htmlwidget")
# })
