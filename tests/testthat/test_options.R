
d <- data.frame(a = abs(rnorm(20) * 10),
                b = abs(rnorm(20) * 10),
                date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

test_that('xaxis options can be set', {

  cp <- c3(d, x = 'date')
  cx <- xAxis(cp, type = 'timeseries', label = list(text = 'testing',
                                                    position = 'inner-center'))

  expect_true(cx$x$axis$x$show)
  expect_equal(cx$x$axis$x$type, 'timeseries')
  expect_equal(cx$x$axis$x$label$text, 'testing')
  expect_equal(cx$x$axis$x$label$position, 'inner-center')

  expect_is(cx, "c3")
  expect_is(cx, "htmlwidget")

})

test_that('xaxis warnings work', {

  cp <- c3(d, x = 'b')

  # where non-timeseries column is specified
  expect_warning(xAxis(cp, type = 'timeseries'))

})


test_that('yaxis can be removed', {

  cp <- c3(d)
  cy <- yAxis(cp, show = FALSE)

  expect_false(cy$x$axis$y$show)

  expect_is(cy, "c3")
  expect_is(cy, "htmlwidget")

})


test_that('yaxis options can be set', {

  cp <- c3(d)
  cy <- yAxis(cp, label = 'Testing', inverted = TRUE, center = TRUE)

  expect_true(cy$x$axis$y$show)
  expect_true(cy$x$axis$y$inverted)
  expect_true(cy$x$axis$y$center)
  expect_equal(cy$x$axis$y$label, 'Testing')

  expect_is(cy, "c3")
  expect_is(cy, "htmlwidget")

})


test_that('second yaxis can be set', {

  cp <- c3(d,
     x = 'date',
     axes = list(a = 'y',
                 b = 'y2'))
  cy <- y2Axis(cp)

  expect_true(cy$x$axis$y2$show)

  expect_is(cy, "c3")
  expect_is(cy, "htmlwidget")

})

## tickAxis()

test_that('axis tick options can be set', {

  cp <- c3(d, x = 'date')

  tkx <- tickAxis(cp, 'x', culling = list(max = 3), centered = FALSE, rotate = 45)
  tky1 <- tickAxis(cp, 'y', values = c(0,10,20))
  tky2 <- tickAxis(cp, 'y', count = 5, outer = FALSE)

  expect_false(tkx$x$axis$x$tick$centered)
  expect_equal(tkx$x$axis$x$tick$rotate, 45)
  expect_equal(tkx$x$axis$x$tick$culling$max, 3)

  expect_equal(tky1$x$axis$y$tick$values, c(0,10,20))

  expect_false(tky2$x$axis$y$tick$outer)
  expect_equal(tky2$x$axis$y$tick$count, 5)

})
