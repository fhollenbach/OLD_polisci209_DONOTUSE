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
## 1 is Ind
## 2 is Rep

population <- c(rep(0, 500000), rep(1, 200000),  rep(2, 500000))
table(population)

survey_sample <- sample(population, 1000, replace = FALSE)
table(survey_sample)
