### Histograms, Means, and SD
### Florian Hollenbach
### Polisci 209 - Fall 2017



##### first make sure ggplot2 is installed
library(ggplot2)
### if you didn't get an error, you already installed this package
### we will use ggplot to make some nice graphs
### you can always find help for ggplot here: http://ggplot2.tidyverse.org/


### ggplot also comes within a different package suit that we will use, but it is good to know you installed it separately
### let's install tidyverse which allows us to manipulate and play with data

### load tidyverse
library(tidyverse)


### we are now ready to load our data set
income_data <- readr::read_csv("~/Dropbox/TAMU/Teaching/Fall2017/slides/week3/data.csv")
#data <- readr::read_csv("~/Desktop/class209/data.csv")
#readr::read_csv("C:\\Users\\fhollenbach\\Desktop\\class209\\data.csv")
income_data$democracy <- factor(income_data$democracy, levels = c(0,1))

### remeber the head function, glimpse in tiblle does the same
tibble::glimpse(income_data)
head(income_data)

### the object data is a data frame
class(income_data)
### you can access individual columns or variables using the $$$ sign and the name of the column or variable
###. for example
income_data$lGDP

### alternatively, recall that a data frame is just a matrix
### matrices can also be accessed by indexing their columns or rows, the first index is the row, second is the column
income_data[,1] ### accesses the first column, i.e. the GDP variable
income_data[1,] ### accesses the first row for all variables


## the function dim() can tell us the dimensions of a data frame, i.e. rows and columns
dim(income_data)

### ggplot() allows us to draw nice plots
### first step we have to tell ggplot what data to use, this is the first argument
ggplot(data = income_data, aes(x = lGDP)) + geom_histogram() ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis



ggplot(data = income_data, aes(x = lGDP, y = ..density..)) + geom_histogram() ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis
### now y is the density, cause we tell r to do so


#### we can subset data frames and assign the subset to new objects using the subset() function
data2010 <- subset(income_data, Year == 2010 & democracy == 1) ## remember to use == not +
### same plot for 2010
ggplot(data = data2010, aes(x = lGDP, y = ..density..)) + geom_histogram() ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis


#### scatter plot with total taxation as % GDP on the y-axis and logged GDP on x-axis
ggplot(data = data2010, aes(x = lGDP, y = TotalTax)) + geom_point() ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis



#### democracy needs to be a factor variable 
income_data$democracy <- as.factor(income_data$democracy)
#### let's see if democracies and dictatorship are different from each other
ggplot(data = data2010, aes(x = lGDP, y = ..density..)) + geom_histogram() + facet_wrap(~democracy)###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis



#### or we can use color and fill to see the difference between the regimes
ggplot(data = data2010, aes(x = lGDP, y = ..density.., color = democracy)) + geom_histogram() 


ggplot(data = data2010, aes(x = lGDP, y = ..density.., fill = democracy)) + geom_histogram() 



### alpha changes how strong the colors are, lower values make the coloring more transparent
ggplot(data2010, aes(x = lGDP, color = democracy, fill = democracy)) + geom_density(alpha = 0.1)

ggplot(data2010, aes(x = lGDP, color = democracy, fill = democracy)) + geom_density(alpha = 0.5)

ggplot(data2010, aes(x = lGDP, color = democracy, fill = democracy)) + geom_density(alpha = 0.8)

ggplot(income_data, aes(x = lGDP, fill = democracy)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~Year)


mean(income_data$lGDP, na.rm = TRUE)
mean(data2010$lGDP, na.rm =TRUE)



sum(income_data$lGDP, na.rm = TRUE)/length(income_data$lGDP)


median(income_data$lGDP, na.rm = TRUE)

sd(income_data$lGDP, na.rm = TRUE)  #### divides by (N-1)
IQR(income_data$lGDP, na.rm = TRUE)


### simple example of sd, see difference which is caused by r dividing by N-1
x <- c(1,3,4,5,7)
sd(x)
sqrt((sum((x-4)^2))/5)



#### doing sd by hand
sqrt(sum((income_data$lGDP - mean(income_data$lGDP, na.rm = TRUE))^2,na.rm = T)/(length(income_data$lGDP)))

deviation <- income_data$lGDP - mean(income_data$lGDP, na.rm = TRUE)
deviation2 <- deviation^2
sum_square <- sum(deviation2, na.rm =T)
fraction <- sum_square/length(income_data$lGDP)
SD <- sqrt(fraction)

sd(income_data$lGDP, na.rm =T)
####### 
### let's do some means

###you can use the mean function on vectors




#### subsetting the data by two groups. 
library(tidyverse)

grouped_data <- group_by(income_data, Year, democracy)
grouped_data

summarized_data <- summarize(grouped_data, mean_tax = mean(tottax, na.rm= T), sd_tax = sd(tottax, na.rm = T) )


ggplot(data = summarized_data, aes(x = Year, y = mean_tax, color = democracy)) + geom_line()

ggplot(data = summarized_data, aes(x = Year, y = mean_tax, color = democracy)) + geom_line() + 
  labs(x = "Year",
     y = "Average Taxation as % GDP",
     color = "Regime Type",
     title = "Tax Revenue by Regime over time",
     subtitle = "Democracies Tax More",
     caption = "ICRG Tax Data and Boix on Regime") +
  theme_bw()

ggsave("~/Desktop/myplot.pdf")



ggplot(data = data2010, aes(x = lGDP, y = TotalTax)) + geom_point() ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis

data2010 <- subset(data2010, complete.cases(data2010))
ggplot(data = data2010, aes(x = lGDP, y = tottax)) + geom_point() + 
  labs(x = "logged GDP",
       y = "Average Taxation as % GDP",
       title = "Tax Revenue vs logged GDP") + theme_bw() +geom_vline(xintercept = 27.35, col ="red")
ggsave("~/Desktop/myplot.pdf")


ggplot(data = data2010, aes(x = totrev, y = tottax)) + geom_point() + 
  labs(x = "Revenue as % GDP",
       y = "Taxation as % GDP",
       title = "Tax Revenue vs total Revenue") + theme_bw() + geom_point(aes(x = mean(data2010$totrev),y =mean(data2010$tottax)), color = "red")
ggsave("~/Desktop/myplot.pdf")

mean(data2010$totrev)
sd_totrev = sqrt(sum((data2010$totrev - mean(data2010$totrev))^2)/(length(data2010$totrev)))
mean(data2010$totrev)

sd_tottax = sqrt(sum((data2010$tottax - mean(data2010$tottax))^2)/(length(data2010$tottax)))
mean(data2010$tottax)

sd_lGDP = sqrt(sum((data2010$lGDP - mean(data2010$lGDP))^2)/(length(data2010$lGDP)))
mean(data2010$lGDP)


cor(data2010$lGDP, data2010$tottax)
lm(tottax~ lGDP, data = data2010 )

x1 <- rnorm(10000, 0,1)
x2 <- rnorm(10000, 0, 1) + rnorm(10000,0,1)

x <- data.frame(c(x1,x2), c(rep("X", 10000), rep("X w error", 10000)))
names(x) <- c("data", "var")
ggplot(data = x, aes(x = data, color = var)) + geom_density(size = 1) ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis
ggsave("~/Desktop/myplot.pdf")




x1 <- rnorm(10000, 0,1)
x2 <- rnorm(10000, 0, 1) + rnorm(10000,2,1)

x <- data.frame(c(x1,x2), c(rep("X", 10000), rep("X w error", 10000)))
names(x) <- c("data", "var")
ggplot(data = x, aes(x = data, color = var)) + geom_density(size = 1) ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis
ggsave("~/Desktop/myplot.pdf")

