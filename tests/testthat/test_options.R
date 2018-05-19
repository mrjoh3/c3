
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
