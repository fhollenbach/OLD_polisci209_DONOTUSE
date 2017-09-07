#### hashtags mean everything after it is a comment
#### you should comment a lot


### for example: 
### every script you write should start with author:
## Florian Hollenbach
## and what it is about
### R-script for learning R, pols209 - Fall 2017


### first off, you can do things in the console
### try using R as a calculator
### 7+2, (9*3)+4


### generally you will want to do everything in a script like this, however,
### it is important so that you can save your work
### and so that your work/research is reproducible, i.e. others can see what you did
### for example, when doing homework in R, you should also hand in a printed r-script
### you can run code in the script by highlighting the part of the script you want to run 
### and hitting "command + enter" on a mac and "control + enter" in windows

### you can and should save the script, like any other document on your computer. 
### The script will have be ending with ".R"


### when you write code in a script, you really should comment on everything you do
### that way others can easily read your code and understand what you did and you will have an easier time remembering


### R has build in functions too, i.e. 
sqrt(9)  ## square root
log(1) ### natural log
exp(0) ###e^()
9^(1/2) ##power



### but r doesn't know what to do when you assign numbers to numbers
9=0 

### but r is object oriented, this means we can create objects in R, like functions, and we can save things to variables
#### for ecample, we can assign single numbers (scalars) to variables
### <- means assign
variable1 <- 9
variable2 <- 10

### we can then perform operations or calculations using the variables instead of the numbers

variable1 + variable2
9 + 10
### or:
variable3 <- variable1/variable2
9/10
### we can also combine variables and numbers
variable1+10

### we can overwrite variables by assigning it again
variable1 <- 20

### we can also assign the value of one variable/object to another
variable1 <- variable2


### just calling the variable name will print its value
variable1
print(variable1)
### functions are essentially tiny programs that do one thing
### for example, sqrt() is a function to calculate the square root

### you can theoretically write your own function, but that will not be necessary in this class
### functions perform operations on one or multiple arguments, which are written between the parantheses
### you can access help files or explanations for funtions by calling help(sqrt) or ?sqrt
help(sqrt) 
sqrt(9)
### ??sqrt() will show all the help files containing the term sqrt 

### often functions have more than one argument, for example the log() function takes an argument for the base
log(10,base = 10)
log(10,base = 2)
log(10,base = exp(1))

### often these have default values, i.e. if we don't specify it reverts to the default
log(10)
help(log)


### we can also assign characters to variables
variable1 <- "student"
variable2 <- "professor"
### make sure you close quotation marks when doing so or things will go wrong
### obviously R won't be able to do mathematical calculations on characters
variable1 + variable2

### we also create other type of variables, the one we will most commonly work with are vectors, 
### vectors are just multiple values in one variable, vectors can be of any length
### here are some examples
### these vectors have integers in them, but they are of class/type numeric
vector1 <- c(1,2,3,4,5)
vector2 <- seq(1,5,1) ### seq() is a function that creates a sequence, here from 1 to 5 in steps of 1
### take a look at the helpfile for seq()
class(vector1) ### tells us the type/class of vector


vector1
vector2
#### 

#### vectors can also be vectors of characters
vector1 <- c("student", "professor", "child", "teacher")

gender <- c("male", "female", "male", "male", "female")
opinion <- c(1,5,1,1,5)

#### ### we can also create vectors out of factors, meaning there are different categories
### factors are like integers but with labels
class(vector1) ### tells us the type/class of vector


### let's make this a factor variable
gender <- factor(gender, levels = c("male", "female")) ### using the factor variable, see the helpfile
gender
help(factor)
class(gender)
### some times we have categories that also have an ordering, 
### for example, education levels
education_levels <- c("high school", "college", "kindergarten", "college", "PhD", "high school", "kindergarten")
education_levels <- factor(education_levels, levels = c("kindergarten", "high school", "college", "PhD"), ordered = TRUE)
education_levels



#### the cool thing in R is that it is a "vectorized" language
### this means we can do lot's of operations on vectors (if they are numeric)
### for example: 
vector1 <- c(1,2,3,4,5)
vector2 <- seq(1,6,1)


### when operations with a scalar (one number) are done on a vector, it applies to each element (i.e. each number) in the vector
vector1/5 ### divides every element of the vector by five
vector1 - 4 ### subtracts 4 from each element
sqrt(vector1)

### you can also replace the old vector with the new result
vector1 <- vector1 - 4 ### subtracts 4 from each element
vector1

### we can also divide (or any other operation) a vector by a vector, BUT only if they are the same length
### now each element is divided by the corresponding element in the other vector
vector1/vector2
vector1 + vector2


sqrt(9)
sqrt(vector2)



#### lastly there are logical statements: TRUE or FALSE
### these can be assigned to objects as well
object1 <- TRUE
object1 <-FALSE


### R can also evaluate statements, use "==" to do so
### example 
3 == 4

2-9 == -7
9 < 10
#### aside from numbers and characters, R has some special characters
## NA means the observation is missing or has no value

vector1 <- vector2 <- c("male", "female", NA, "male", "female")

### inf means the value is infinite, and -inf is negative infinity
### Example:
100/0
log(0)


##### you might ask why NA would ever exist, since it could just be a shorter vector...
#### but often we have multiple vectors of variables for different subjects of our study
### for example, let's assume we have a survey of all our class mates (assume there are just 10)
gender <- factor(c("male", "female", "male", "male", "male", "female", "male", "female", "female", "female") , levels = c("male", "female")) ### using the factor variable, see the helpfile
##### one variable for gender
### next variable records age 
age <- c(20, 21, 23, 22, 20, 18, 22, 29, 21, 22)
#### next variable records their opininon on the class on a scaled from 1 - 10 , but person 7 didnt answer the question
opinion <- c(9,8,10,10,9,1,NA,7,8,10)
#### so the missing observation can't be at the end, has to be person 7

##### given that each element of the vector corresponds to one student's answer on a particular question, the order matters
#### instead of keeping the data in vectors, we often have it in data.frames, 
#### data.frames are like a collection of variables, where one row is one observation on many variables and one column is all observations for one variable
#### let's put these variables in a data.frame

survey.data <- data.frame(gender, age, opinion)
### given that our data set is small we can look at it
survey.data

### often, however, we have large data sets and it is nearly impossible to look at every value
head(survey.data)
### function that prints first 6 observation of each variable
### but takes second argument, where you can specify number of observations shown
head(survey.data, n = 2)
tail(survey.data)
#### summarizes each variable
summary(survey.data)



#### as mentioned earlier, there are lots of programs already written for R
### the ones we are currently using are in base R
### you can load other programs by installing and then loading packages
### you only have to install the packages once, but you will have to load them every time 
### you start R and want to use it


### if you have an internet connection on your computer, install.packages() will install the package of your choice 
### example:
install.packages("ggplot2") ### this is a package that makes nice plots

### now once it is installed, you need to load the package prior to using it after you started R
### like so:
library(ggplot2)




