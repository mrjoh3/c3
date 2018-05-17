
d <- data.frame(a = abs(rnorm(20) * 10),
                b = abs(rnorm(20) * 10),
                date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

test_that('xaxis options can be set', {

  cp <- c3(d, x = 'date')
  cx <- xAxis(cp, type = 'timeseries')

  expect_is(cx, "c3")
  expect_is(cx, "htmlwidget")

})

test_that('xaxis warnings work', {

  cp <- c3(d, x = 'b')

  # where non-timeseries column is specified
  expect_warning(xAxis(cp, type = 'timeseries'))

})
