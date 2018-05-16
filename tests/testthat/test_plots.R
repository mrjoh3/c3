
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
