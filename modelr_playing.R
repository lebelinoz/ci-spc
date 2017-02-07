library(tidyverse)
library(modelr)
options(na.action = na.warn)

data(sim1)
ggplot(sim1, aes(x, y)) + geom_point()

models = tibble(a1 = runif(250, -20, 40), a2 = runif(250, -5, 5))
#models = merge(data.frame(a1 = seq(-20, 40, length = 15)), data.frame(a2 = seq(-5, 5, length = 15)), all = TRUE)

ggplot(sim1, aes(x, y)) + geom_point() + geom_abline(aes(intercept = a1, slope = a2), data = models, alpha = 1 / 4)
