### correlation and scatter plots
### Rcode from class 10/18/2017
### Pols 209 - Fall 2017


###load our favorite library
### think of loaning a book 
library(tidyverse)
## we have to do it everytime we start R anew and want to use the program


#### again, make sure we have the correct path specified to our data file
gamson <- read.csv("~/Documents/GitHub/polisci209_fall2017/img/images/data/gamson.csv")
### remember this looks different on windows
### for example: read_csv("C:\\Users\\fhollenbach\\Desktop\\class209\\gamson.csv")


### let's take a look at the data
glimpse(gamson)
#### seat share is the share of seats each party holds in a parliament
#### portfolio share is the share of cabinet seats a party has in government
#### Gamson's law says that a party's seat share in parliament should (almost) perfectly predict the share of seats in the cabinet (coalition government)
#### if that is the case, what should the correlation be?

ggplot(data = gamson, aes(x = seat_share, y = portfolio_share)) +  geom_point() 
ggsave("~/Dropbox/TAMU/Teaching/Fall2017/slides/week6/gamson1.pdf")

### wow that looks like a very strong correlation
### Gamson's law
### can we calculate the correlation in R by hand?

deviation_squared <- (gamson$seat_share - mean(gamson$seat_share))^2
summed_deviation2 <- sum(deviation_squared)
avg_deviation2 <- summed_deviation2/length(gamson$seat_share)
sd_seatshare <- sqrt(avg_deviation2)
sd(gamson$seat_share)

##all in one
sd_portfolio <- sqrt(sum((gamson$portfolio_share - mean(gamson$portfolio_share))^2)/length(gamson$portfolio_share))

seatshare_su <- (gamson$seat_share - mean(gamson$seat_share))/sd_seatshare
portfolio_su <- (gamson$portfolio_share - mean(gamson$portfolio_share))/sd_portfolio
sum(seatshare_su*portfolio_su)/length(gamson$portfolio_share)
### wow, that's almost 1!!!!



##### some fun data from cfb 2016-17
cfb <- read.csv("~/Documents/GitHub/polisci209_fall2017/img/images/data/CollegeFB.csv")
glimpse(cfb)

### create some new variables in our dataset, based on the variables already included in the data
cfb$yards_carry <- cfb$Yards/cfb$Attempts
cfb$TDs_carry <- cfb$TDs/cfb$Attempts
### simple scatter plot
ggplot(cfb, aes(x = Attempts, y = Yards)) + geom_point()
### note that ggplot tells us about missing values

#### how about we add the point of averages?
ggplot(cfb, aes(x = Attempts, y = Yards)) + geom_point() + geom_point(aes(x = mean(cfb$Attempts, na.rm = T), y = mean(cfb$Yards, na.rm = T)), color = "blue")



### but scatter plots can only show us two variables, one on the y-axis, one on the x-axis
### Can we use color to see a third? Yes

ggplot(cfb, aes(x = Attempts, y = Yards, color = TDs)) + geom_point()

### we can use the size of points to see a fourth
ggplot(cfb, aes(x = Attempts, y = Yards, color = TDs, size = TDs_carry)) + geom_point()
### though really this is not recommended, might be better off making multiple plots than clutter one plot with too much information

######## correlation
#### remember all the hard work we had to do to get the correlation?
#### well, R also has a function for that
### remember to call on the variables in the data set, i.e. dataframe.name$variable.name
cor(gamson$seat_share, gamson$portfolio_share)


##### if you have missing data, the correlation returns NA
cor(cfb$Yards, cfb$Attempts)

help(cor)
### we need to tell R what to do about the missing values
### unfortunately na.rm = T doesn't work here
### we can tell R only to use those where both variables are not missing
cor(cfb$Yards, cfb$Attempts, use = "pairwise.complete.obs")

### let's do it by hand
std_yards = (cfb$Yards - mean(cfb$Yards, na.rm = T))/sd(cfb$Yards, na.rm = T)
std_Attempts = (cfb$Attempts - mean(cfb$Attempts, na.rm = T))/sd(cfb$Attempts, na.rm = T)
### not quite the same, because we treat the NA's a bit different
mean(std_yards*std_Attempts, na.rm = T)
### but very close
####
#### R again also uses (N-1) instead of N
cor(cfb$Yards, cfb$Attempts, use = "pairwise.complete.obs")


##### this data set has a lot of variables that are interesting
health <- read.csv("~/Documents/GitHub/polisci209_fall2017/img/images/data/health.csv")
glimpse(health)
### some data on health care and political opinions
#### let's use the select function to grab all the numeric variables and put them in a new dataframe called numeric vars
#### now we can calculate the pairwise correlation for all of them
numeric_vars <- select(health, percent_favorable_aca, percent_supporting_expansion, obama_share_12, ideology, percent_uninsured, infant_mortality_rate, cancer_incidence, heart_disease_death_rate, life_expectancy)
glimpse(numeric_vars)
cors <- cor(numeric_vars, use = "pairwise.complete.obs")

#### the package ggcorplot makes nice plots that show the pairwise correlation by color
library(ggcorrplot) ### you might have to install it with install.packages("ggcorrplot") before using it the first time
ggcorrplot(cors)



##########################################################################################################################################################################
####################################################################
####################################################################
################################## now that we can do correlations, let's look at regression in R######################################################################################################

### say we want to predict coalition cabinet seats with the party's seat share in parliament
### remember the correlation was very high
correlation <- cor(gamson$seat_share, gamson$portfolio_share)

#### how do we find the slope of regression line?
(sd(gamson$portfolio_share)/sd(gamson$seat_share))*correlation


### turns out R has a function to run a regression
### surprising, I know
model1 <- lm(portfolio_share ~ seat_share, data = gamson)
### the function is the lm() function, which stands for linear model
### first argument in the function is the formulat which you write as y ~ x or "dependent variable name" ~ "independent variable name". The second argument names the data set in which R is going to look for the variables.


### we store the result in a new object, here I call it model1
### R stores the result as a list, this is similar to a dataframe but not organized as a matrix
### instead a list is more similar to a list you might write on a piece of paper, with different boxes
### all the boxes can have a different number of items in them (remember in the dataframe they are all the same length)


### the list let's us look into the different boxes by calling on them
### first let's look at the coefficients of the regression
### this is really all we are interested for today
coef(model1)
### there are two coefficients here! What are they?

#### so far we have ignored the intercept but it is also important
### we can also add the regression line to our plots with the function geom_smooth
ggplot(gamson, aes(x = seat_share, y = portfolio_share)) +  geom_point() + geom_point(aes(x = mean(gamson$seat_share), y = mean(gamson$portfolio_share)), color = "red") + geom_smooth(method = "lm", se = FALSE, color = "blue")

### remember you can use ggsave to save the plot
### make sure you set the correct path to where you want to save it
ggsave("~/Dropbox/TAMU/Teaching/Fall2017/slides/week6/gamson2.pdf")



##### since there are so many points, we could make them a bit more transparent
#### we can do that with the alpha factor between 0 and 1
ggplot(gamson, aes(x = seat_share, y = portfolio_share)) +  geom_point(alpha = 0.3) + geom_point(aes(x = mean(gamson$seat_share), y = mean(gamson$portfolio_share)), color = "red") + geom_smooth(method = "lm", se = FALSE, color = "red")







#### last: the rmse
### unfortunately R does not give us a function to get the rmse directly
### It does give us all the errors from the regression though
### the command box residuals in the model fit object has that 
residuals(model1)
### these are all the errors/residuals for each point in our dataset
errors <- residuals(model1)
s <- errors^2
m <- sum(s)/length(errors)
r <- sqrt(m)
print(r) # r.m.s. error
## [1] 0.06880963
# all at once
sqrt(sum(residuals(model1)^2)/length(errors)) # r.m.s. error


#### we can add the residuals from the model to our dataframe and then plot them
gamson$error <- residuals(model1)
ggplot(gamson, aes(x = seat_share, y = error)) +  geom_point(alpha = 0.3) + geom_smooth(method = "lm", se = FALSE, color = "red")





pres <- read.csv("~/Documents/GitHub/polisci209_fall2017/img/images/data/Presdata.csv")
glimpse(pres)


mod <- lm(inc1 ~  Z, data = pres)
coef(mod)
data2016 <- subset(pres, Year == 2016)

#### prediction 
prediction <- predict(mod, newdata = data2016 )
