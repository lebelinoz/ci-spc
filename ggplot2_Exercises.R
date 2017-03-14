################################
## Exercises for ggplot2 book ##
################################

library(tidyverse)
data(mpg)
data(diamonds)
data(economics)


# how to know which data packages are included in ggplot2?
data()

# five ways to analyze mpg data
head(mpg)
tail(mpg, 10)
str(mpg)
colnames(mpg)
rownames(mpg)
summary(mpg)

# convert data to "litres for 100 km"


# Section 2.3
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
ggplot(mpg, aes(cty,hwy)) + geom_point()
ggplot(mpg, aes(model, manufacturer)) + geom_point()
ggplot(mpg, aes(manufacturer, model)) + geom_point()

ggplot(mpg, aes(cty,hwy)) + geom_point()
ggplot(diamonds, aes(carat, price)) + geom_point()
ggplot(economics, aes(date, unemploy)) + geom_line()
ggplot(mpg, aes(cty)) + geom_histogram()

# Section 2.4 Aesthetics (colour, shape, size)
ggplot(mpg, aes(displ, hwy, colour = class)) + geom_point()
ggplot(mpg, aes(displ, hwy, shape = drv)) + geom_point()
ggplot(mpg, aes(displ, hwy, size = cyl)) + geom_point()

ggplot(mpg, aes(displ, hwy, colour = class, shape = drv, size = cyl)) + geom_point()

ggplot(mpg, aes(displ, cty, colour = class)) + geom_point()

# Section 2.5 Facetting
ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap( ~ class)

# Exercise 2.5.1.1
ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap( ~ hwy)
ggplot(mpg, aes(displ, class)) + geom_point() + facet_wrap( ~ hwy)

# Exercise 2.5.1.2+
ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap( ~ cyl)
ggplot(mpg, aes(displ, cty)) + geom_point() + facet_wrap( ~ cyl)
ggplot(mpg, aes(displ, cty)) + geom_point() + facet_wrap( ~ cyl, nrow = 1)
ggplot(mpg, aes(displ, cty)) + geom_point() + facet_wrap( ~ cyl, ncol = 1)
ggplot(mpg, aes(displ, cty)) + geom_point() + facet_wrap( ~ cyl, nrow = 1, scales = "free")


# Section 3.4:  annotation
data(economics)
data(presidential)
summary(economics)
summary(presidential)

ggplot(economics, aes(date, unemploy)) + geom_line()
presidential <- subset(presidential, start > economics$date[1])

x = ggplot(economics) 
x = x + geom_rect(aes(xmin = start, xmax = end, fill = party), ymin = -Inf, ymax = Inf, alpha = 0.2, data = presidential) 
x = x + geom_vline(aes(xintercept = as.numeric(start)), data = presidential, colour = "grey50", alpha = 0.5)
x = x + geom_text(aes(x =  start, y = 2500, label = name), data = presidential, size = 3, vjust = 0, hjust = 0, nudge_x = 50)
x = x + geom_line(aes(date, unemploy))
x = x + scale_fill_manual(values = c("blue", "red"))
x

## "R for Data Science" Chapter 1
# Facets (p. 15)
x = ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))
x + facet_wrap(~class, nrow = 2)
x + facet_grid(drv ~ cyl)
ggplot(data = mpg) + geom_point(mapping = aes(x = year, y = hwy)) + facet_wrap(~displ)
x + facet_grid(. ~ cyl)
x + facet_wrap(~ cyl)
x + facet_grid(drv ~ cyl)
x + facet_grid(drv ~ .)
x + facet_grid(. ~ cyl)


# Geoms (p. 16)
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
ggplot(data = mpg) +  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv)) + geom_point(mapping = aes(x = displ, y = hwy, color = drv))

ggplot(data = mpg) +  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) +  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)
ggplot(data = mpg) +  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +  geom_smooth() + geom_point()
x = ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) + geom_point(aes(color=class))
x + geom_smooth(data = filter(mpg, class == "suv"), se = FALSE, color = "red")

# Exercise 6 on p. 21:  recreate these six graphs
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth(se=FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth(aes(group=drv), se=FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + geom_point() + geom_smooth(se=FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth(se=FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth(aes(linetype = drv), se=FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) 

# Statistical Transformations (p. 22)
data(diamonds)
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) + stat_summary(mapping = aes(x = cut, y = depth), fun.ymin = min, fun.ymax = max, fun.y = median)
