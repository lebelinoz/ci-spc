install.packages("nycflights2013")
library(nycflights13)
library(tidyverse)

######################
## Chapter 3 from HW's "R for Data Science" book is an introduction to dplyr.  Here are the exercises
######################
data(flights) # this data.frame is actually a "tibble", which prints nicely.
(jan1 <- filter(flights, month == 1, day == 1)) # assigns and prints
sqrt(2) ^ 2 == 2 # FALSE
near(sqrt(2) ^ 2, 2) # TRUE:  dplyr's near() function determines when two numbers are really, really close.
nov_dec <- filter(flights, month %in% c(11, 12)) # use %in% for inclusion in a set

## Exercises for filter() on p.49-50
filter(flights, arr_delay > 120) # E1a
filter(flights, dest %in% c("IAH", "HOU")) # E1b
filter(flights, carrier %in% c("UA", "AA", "DL")) # E1c
filter(flights, month %in% c(7, 8, 9)) # E1d
filter(flights, arr_delay > 120, dep_delay < 120) # E1e
filter(flights, arr_delay > 60, dep_delay - arr_delay > 30) # E1f
filter(flights, hour < 6 | (hour == 6 & minute == 0)) # E1g

filter(flights, between(month, 7, 9)) # E2

filter(flights, is.na(dep_time)) # E3

# E4
NA ^ 0
NA | TRUE
NA & FALSE
NA * 0


## Exercises for arrange() on p.51
arrange(flights, desc(is.na(dep_time))) # E1
arrange(flights, desc(arr_delay)) # E2
arrange(flights, air_time) # E3a
arrange(flights, air_time, hour) # E3b
arrange(flights, distance) # E4a
arrange(flights, desc(distance)) # E4b

## Exercises for select() on p.54
select(flights, year:day)
select(flights, year:day, year) # E2

# E3
vars = c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, one_of(vars))
select(flights, vars)

# E4
select(flights, contains("TIME"))
select(flights, contains("TIME", ignore.case = FALSE))


## Exercises for mutate() on p.58

# E1
(dep = select(flights, contains("dep_time")))
dep_minutes = mutate(dep, dep_time_minutes = (dep_time %/% 100) * 60 + (dep_time %% 100), sched_dep_time_minutes = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100))

# E2
air_vs_arr_wrong = mutate(flights, calc_air_time = arr_time - dep_time)
View(air_vs_arr_wrong)

air_vs_arr = mutate(flights,
                    dep_time_minutes = (dep_time %/% 100) * 60 + (dep_time %% 100),
                    arr_time_minutes = (arr_time %/% 100) * 60 + (arr_time %% 100),
                    calc_air_time_minutes = arr_time_minutes - dep_time_minutes,
                    calc_air_time = (calc_air_time_minutes %/% 60) * 100 + (calc_air_time_minutes %% 60))
View(air_vs_arr)
View(select(air_vs_arr, air_time, calc_air_time)) # air_time is in hours, and takes into account timezone changes

# E3
View(select(flights, contains("dep_time"), dep_delay)) # dep_delay is in minutes

# E4
arrange(mutate(flights, rank = min_rank(arr_delay)), desc(rank))
? min_rank


## group_by, summarize and the %>% pipes
by_day = group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

flights %>% group_by(dest) %>% summarize(count = n()) %>% filter(count > 20)


######################
## Chapter 10 from HW's ggplot2 book is all about dplyr.  Here are the exercises
######################
data(diamonds) # this is in ggplot2

# Exercises 10.2.3
# E1:
filter(diamonds, x == y)
filter(diamonds, depth > 55 & depth < 70)
filter(diamonds, carat < median(diamonds$carat))
filter(diamonds, price / carat > 10000)
filter(diamonds, cut != "Fair")

# E4:
library(ggplot2movies)
data(movies)
ggplot(movies, aes(budget)) + geom_freqpoly()
ggplot(movies, aes(budget, colour = is.na(budget))) + geom_freqpoly() # ??? Come back to this one...
