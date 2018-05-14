d <- data.frame(a = abs(rnorm(20) * 10),
               b = abs(rnorm(20) * 10),
               date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

d$c = abs(rnorm(20) *10)
d$d = abs(rnorm(20) *10)

cp <- c3(d)
c_l <- c3_line(cp, 'spline')


test_that("a simple plot works", {
  expect_is(cp, "c3")
  expect_is(cp, "htmlwidget")
})

test_that("C3 line options can be set", {
  expect_equal(c_l$x$data$type, 'spline')

  expect_is(c_l, "c3")
  expect_is(c_l, "htmlwidget")
})


# test_that("C3 mixed geometry options can be set", {
#
#   c_m <- c3::c3_mixedGeom(cp,
#                       types = list(a='area',
#                                    c='spline')
#   )
#
#   #expect_equal(c_m$x$data$type, 'bar')
#   #expect_equal(c_m$x$data$types$a, 'area')
#
#   #expect_is(c_m, "c3")
#   #expect_is(c_m, "htmlwidget")
# })

test_that('colors can be set by RColorBrewer', {

  brw <- RColorBrewer(cp, 'Dark2')

  expect_equal(brw$x$color$pattern[1], "#1B9E77")

  expect_is(brw, "c3")
  expect_is(brw, "htmlwidget")

})


test_that('colors can be set by viridis', {

  vir <- c3_viridis(cp)

  expect_equal(vir$x$color$pattern[1], "#440154")

  expect_is(vir, "c3")
  expect_is(vir, "htmlwidget")

})


test_that('colors can be set manually', {

  clr <- c3_colour(cp, c('red','black','orange','green'))

  expect_equal(clr$x$color$pattern[1], "red")

  expect_is(clr, "c3")
  expect_is(clr, "htmlwidget")

})
