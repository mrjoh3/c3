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


## grid.R
test_that('grids can be added', {

  grd <- grid(cp,'y')

  expect_true(grd$x$grid$y$show)

  expect_is(grd, "c3")
  expect_is(grd, "htmlwidget")

})


## legend.R
test_that('legends can be removed', {

  lgd <- legend(cp, hide = TRUE)

  expect_true(lgd$x$legend$hide)

  expect_is(lgd, "c3")
  expect_is(lgd, "htmlwidget")

})


test_that('legends attribute can be modified', {

  lgd <- legend(cp, position = 'right')

  expect_equal(lgd$x$legend$position, 'right')
  expect_false(lgd$x$legend$hide)

  expect_is(lgd, "c3")
  expect_is(lgd, "htmlwidget")

})



## region.R

test_that('regions can be added', {

  reg <- region(cp, data.frame(axis = 'x',
                               start = 5,
                               end = 12))

  expect_equal(reg$x$regions$start, 5)
  expect_equal(reg$x$regions$axis, factor('x'))

  expect_is(reg, "c3")
  expect_is(reg, "htmlwidget")

})


## subchart.R

test_that('subcharts can be added', {

  sbc <- subchart(cp)

  expect_true(sbc$x$subchart$show)
  expect_equal(sbc$x$subchart$size$height, 20)

  expect_is(sbc, "c3")
  expect_is(sbc, "htmlwidget")

})

test_that('subcharts attributes can be set', {

  sbc <- subchart(cp, height = 50)

  expect_true(sbc$x$subchart$show)
  expect_equal(sbc$x$subchart$size$height, 50)

  expect_is(sbc, "c3")
  expect_is(sbc, "htmlwidget")

})


## tooltip.R

test_that('tooltips can be switched off', {

  tt <- tooltip(cp, show = FALSE)

  expect_false(tt$x$tooltip$show)

  expect_is(tt, "c3")
  expect_is(tt, "htmlwidget")

})


test_that('tooltips attributes can be set', {

  tt <- tooltip(cp, grouped = FALSE)

  expect_false(tt$x$tooltip$grouped)

  expect_is(tt, "c3")
  expect_is(tt, "htmlwidget")

})

