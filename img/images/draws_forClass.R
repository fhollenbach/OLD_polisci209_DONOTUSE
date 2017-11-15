library(ggplot2)


#### what is the expected value
sums <- rep(NA, 1000)
iter <- seq(1,1000,1)
for(i in 1:1000){
  #### the number between c() are what is in the box, change that to change the content of the box
  ### 10 here are the number of draws, you can change those too
  samp <- sample( c(0,1), 10, replace = TRUE)
  sums[i] <- sum(samp)
}

draws <- data.frame(sums,iter)
names(draws)


ggplot(data = draws, aes(x = sums)) + geom_histogram() ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis




######## simulating survey sampling 
## 0 is Dem
## 1 is Rep

population <- c(rep(0, 700000), rep(1, 400000))
table(population)
Population_percent = (length(subset(population, population == 0))/length(population))*100

Draws <- 1000
survey_sample1 <- sample(population, Draws, replace = FALSE)
table(survey_sample1)

expected_value1 <- length(subset(survey_sample1, survey_sample1 == 0))/length(survey_sample1)
expected_value1
SE1 <- sqrt(Draws)*sqrt(expected_value1 * (1- expected_value1))
SE1 <- SE1*100/Draws


### 95% CI: 
expected_value1*100 - 2*SE1
expected_value1*100 + 2*SE1
#### TRUE
### 70%, so not within CI!!!!!

### let's do this a lot

iter <- seq(1,10000,1)
In95CI <- rep(NA, 10000)

for(i in 1:10000){
  survey_sample <- sample(population, Draws, replace = FALSE)
  expected_value <- length(subset(survey_sample, survey_sample == 0))/length(survey_sample)
  expected_value
  SE <- sqrt(Draws)*sqrt(expected_value * (1- expected_value))
  SE <- SE*100/Draws
  lower <- expected_value*100 - 2*SE
  upper <- expected_value*100 + 2*SE
  
  In95CI[i] <- (lower <= Population_percent & upper >= Population_percent)
  
}
sum(In95CI)

### or in per cent:
sum(In95CI)/1000








#### what is the expected value

population <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00,0,0,0,0,0,0,400)
mean(population)

averages <- rep(NA, 10000)
iter <- seq(1,10000,1)
for(i in 1:10000){
  #### the number between c() are what is in the box, change that to change the content of the box
  ### 10 here are the number of draws, you can change those too
  samp <- sample( population, 1000, replace = TRUE)
  averages[i] <- mean(samp)
}

draws <- data.frame(averages,iter)
names(draws)


ggplot(data = draws, aes(x = averages)) + geom_histogram() ###aes is the aesthetic argument, here we tell ggplot we want logged GDP on the x-axis

