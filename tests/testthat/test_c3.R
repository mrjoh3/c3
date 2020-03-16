

context('main package')



d <- data.frame(a = abs(rnorm(20) * 10),
               b = abs(rnorm(20) * 10),
               date = seq(as.Date("2014-01-01"), by = "month", length.out = 20),
               stringsAsFactors = TRUE)

d$c <- abs(rnorm(20) *10)
d$d <- abs(rnorm(20) *10)

cp <- c3(d)


test_that("a simple plot works", {
  expect_is(cp, "c3")
  expect_is(cp, "htmlwidget")
})



test_that('data structure is in the expected format', {

  expect_is(cp$x$data$json, 'json')

})

test_that('the data structure can be converted', {

  df <- fromJSON(cp$x$data$json)

  expect_is(df, 'data.frame')
  expect_equal(colnames(df), c('a','b','c','d'))
  expect_equal(nrow(df), 20)

})


context('color palettes')

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


context('grid.R')

test_that('grids can be added', {

  grd <- grid(cp,'y')

  expect_true(grd$x$grid$y$show)

  expect_is(grd, "c3")
  expect_is(grd, "htmlwidget")

})



context('legend.R')

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


context('region.R')

test_that('regions can be added', {

  reg <- region(cp, data.frame(axis = 'x',
                               start = 5,
                               end = 12,
                               stringsAsFactors = TRUE))

  expect_error(region(cp, data.frame(axis = 'x',
                               start = 5,
                               error = 4,
                               stringsAsFactors = TRUE))
               )

  expect_equal(reg$x$regions$start, 5)
  expect_equal(reg$x$regions$axis, factor('x'))

  expect_is(reg, "c3")
  expect_is(reg, "htmlwidget")

})



context('subchart.R')

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

test_that('subcharts onbrush attributes can be set', {

  b1 <- subchart(cp, onbrush = 'function (domain) { console.log(domain) }')
  b2 <- subchart(cp, onbrush = JS('function (domain) { console.log(domain) }'))

  expect_is(b1$x$subchart$onbrush, "JS_EVAL")
  expect_is(b2$x$subchart$onbrush, "JS_EVAL")

  expect_is(b1, "c3")
  expect_is(b1, "htmlwidget")
  expect_is(b2, "c3")
  expect_is(b2, "htmlwidget")

})

context('tooltip.R')

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


context('zoom.R')

test_that('zoom settings work', {

  zm <- zoom(cp, rescale = TRUE)

  expect_true(zm$x$zoom$enabled)
  expect_true(zm$x$zoom$rescale)

  expect_is(zm, "c3")
  expect_is(zm, "htmlwidget")

})


context('Tibble Compatibility')

test_that('Tibble x axis can be defined', {

  d <- dplyr::as_tibble(d)

  cp <- c3(d, x = 'date')

  expect_is(cp, "c3")
  expect_is(cp, "htmlwidget")

})
