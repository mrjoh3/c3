## ----setup, warning=FALSE, message=FALSE, echo=FALSE---------------------

library(dplyr)


## ----install, eval=FALSE-------------------------------------------------
#  
#  devtools::install_github("mrjoh3/c3")
#  

## ----data, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

library(c3)

data = data.frame(a = abs(rnorm(20) * 10),
                  b = abs(rnorm(20) * 10),
                  date = seq(as.Date("2014-01-01"), by = "month", length.out = 20))

c3(data)


## ----pipe, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>% c3() 


## ----spline, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>%
  c3() %>%
  c3_line('spline')
                

## ----step, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>%
  c3(x = 'date') %>%
  c3_line('area-step')


## ----bar, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data[1:10, ] %>%
  c3() %>%
  c3_bar(stacked = TRUE, 
         rotate = TRUE)
                


## ----mixed, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data$c = abs(rnorm(20) *10)
data$d = abs(rnorm(20) *10)

data %>%
  c3() %>%
  c3_mixedGeom(type = 'bar', 
               stacked = c('b','d'),
               types = list(a='area',
                            c='spline')
               )


## ----y2, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>% 
  select(date, a, b) %>%
  c3(x = 'date',
     axes = list(a = 'y',
                 b = 'y2')) %>% 
  c3_mixedGeom(types = list(a='line',
                            b='area')) %>% 
  y2Axis()


## ----scatter, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

iris %>%
  c3(x = 'Sepal_Length', 
     y = 'Sepal_Width', 
     group = 'Species') %>% 
  c3_scatter()
                

## ----pie, warning=FALSE, message=FALSE, fig.align='center', fig.width=4, fig.height=3----

data.frame(sugar = 20,
           fat = 45,
           salt = 10) %>% 
  c3() %>% 
  c3_pie()
                

## ----donut, warning=FALSE, message=FALSE, fig.align='center', fig.width=4, fig.height=3----

data.frame(red = 82, green = 33, blue = 93) %>% 
  c3(colors = list(red = 'red',
                   green = 'green',
                   blue = 'blue')) %>% 
  c3_donut(title = '#d053ee')
                

## ----gauge, warning=FALSE, message=FALSE, fig.align='center', fig.width=6, fig.height=3----

data.frame(data = 80) %>% 
  c3() %>% 
  c3_gauge()
                

## ----grid, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>%
  c3() %>%
  grid('y') %>%
  grid('x', 
       show = F, 
       lines = data.frame(value = c(3, 10), 
                          text= c('Line 1','Line 2')))
                

## ----region, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>%
  c3() %>%
  region(data.frame(axis = 'x',
                    start = 5,
                    end = 6))
                

## ----subchart, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>%
  c3(x = 'date') %>%
  subchart()
                

## ----brewer, warning=FALSE, message=FALSE, fig.align='center', fig.width=4, fig.height=3----

data.frame(sugar = 20, 
           fat = 45, 
           salt = 10, 
           vegetables = 60) %>% 
  c3() %>% 
  c3_pie() %>%
  RColorBrewer()


## ----viridis, warning=FALSE, message=FALSE, fig.align='center', fig.width=4, fig.height=3----

data.frame(sugar = 20, 
           fat = 45, 
           salt = 10, 
           vegetables = 60) %>% 
  c3() %>% 
  c3_pie() %>%
  c3_viridis()
                

## ----point, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

data %>%
  c3(x = 'date') %>%
  point_options(r = 6, 
                expand.r = 2)


## ----onclick, eval=FALSE-------------------------------------------------
#  
#  data %>%
#      c3(onclick = htmlwidgets::JS('function(d, element){console.log(d)}'))
#  

## ----tooltip, warning=FALSE, message=FALSE, fig.align='center', fig.width=8, fig.height=3----

library(htmlwidgets)

data %>%
  c3() %>%
  tooltip(format = list(title = JS("function (x) { return 'Data ' + x; }"),
                        name = JS('function (name, ratio, id, index) { return name; }'),
                        value = JS('function (value, ratio, id, index) { return ratio; }')))



