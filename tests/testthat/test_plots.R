

context('plots')


d <- data.frame(a = abs(rnorm(20) * 10),
                b = abs(rnorm(20) * 10),
                date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

d$c <- abs(rnorm(20) *10)
d$d <- abs(rnorm(20) *10)

cp <- c3(d)



context('c3_bar()')

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


context('c3_line()')

test_that("C3 line options can be set", {

  cl <- c3_line(cp, 'spline')
  cs <- c3_line(cp, 'step', stacked = TRUE, step_type = 'step')
  grp <- fromJSON(cs$x$data$groups)$value # indicates stacking

  expect_error(c3_line(cp)) #line type not being defined

  expect_equal(cl$x$data$type, 'spline')
  expect_equal(cs$x$data$type, 'step')
  expect_equal(grp, c("a","b","c","d"))

  expect_is(cl, "c3")
  expect_is(cl, "htmlwidget")

})

test_that('Null values can be connected', {

  d <- data.frame(a = c(1,2,3,2), b = c(2,NA,1,5))
  p <- c3(d)

  cp <- c3_line(p, 'line', connectNull = TRUE)

  expect_true(cp$x$line$connectNull)

})

context('c3_mixedgeometry()')

test_that("C3 mixed geometry options can be set", {

  typs <- list(a='area',
               c='spline')
  stk <- c('b','d')
  mg <- c3_mixedGeom(cp, types = typs, stacked = stk)
  grp <- fromJSON(mg$x$data$groups) # indicates stacking

  expect_equal(mg$x$data$type, 'line') # default value
  expect_equal(mg$x$data$types$a, 'area')
  expect_equal(mg$x$data$types$c, 'spline')
  expect_equal(grp, stk)

  expect_is(mg, "c3")
  expect_is(mg, "htmlwidget")

})


context('c3_scatter()')

test_that('scatter plots work', {

  sp <- c3(iris,
           x = 'Sepal_Length',
           y = 'Sepal_Width',
           group = 'Species')

  sc <- c3_scatter(sp)

  expect_is(sc, "c3")
  expect_is(sc, "htmlwidget")


})



context('c3_pie()')

test_that('Pie charts work', {

  pd <- c3(data.frame(red=20,green=45,blue=10))

  pid <- c3_pie(pd)

  expect_equal(pid$x$data$type, 'pie')

  expect_is(pid, "c3")
  expect_is(pid, "htmlwidget")

})


context('c3_donut()')

test_that('Donut charts work', {

  d <- c3(data.frame(red=20,green=45,blue=10))

  dc <- c3_donut(d, title = "test")

  expect_equal(dc$x$data$type, 'donut')
  expect_equal(dc$x$donut$title, 'test')

  expect_is(dc, "c3")
  expect_is(dc, "htmlwidget")

})



context('c3_guage()')

test_that('Guage charts work', {

  d <- c3(data.frame(data = 10))
  c <- c3_gauge(d, title = "test")

  expect_equal(c$x$data$type, 'gauge')

  expect_is(c, "c3")
  expect_is(c, "htmlwidget")

})

