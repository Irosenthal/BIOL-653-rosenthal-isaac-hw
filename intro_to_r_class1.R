# calculator
2 + 2

# order of operations
(3 + 3) * 4^4

# scientific notation
0.0003
3 * 10^(-4)
3e-4

# mathematical functions
log(2) # natural log
log10(2) #base10 log

exp(0.5) # e^(1/2)

# comparison
# operators

# equal to
2==2
2==3
2!=2
2!=3

# greater/less than
2 < 3
2 > 3
2 < 2
2 <= 2
2 <= 3

# syntax
# functions do something
# functions take arguemnts
# function(arg1, arg2, arg3)
mean(x, trim = 0, na.rm = FALSE)  # x is list of values, trim trims outliers, 0 is default,don't NEED to write it but helps remember, na.rm means do you want me to remove NAs (no data) before calculating mean?

#-----------------------------------------------------
####Let's meet gapminder!####

install.packages('gapminder') #just installs it, don't have to do again

library(gapminder) #doesn't necessarily give a message, if it doesn't throw an error it worked

gapminder
str()  # shows structure of data or object
str(gapminder) # 1704 rows, 6 variables

head(gapminder) # prints 1st 6 rows
tail(gapminder) # prints last 6 rows
View(gapminder) # makes a table
dim(gapminder) # gives rows and columns of dataset

#Let's look at a single vector

gapminder$lifeExp # you can index columns of a data.frame using $
life <- gapminder$lifeExp # assigns it, makes it easier to use
head(life)
length(life)
dim(life) # returns NULL because it is not a dataframe
str(life)
is.data.frame(life) # see? not a data.frame
is.vector(life) # it is now a vector!

####Indexing####

life[1] # prints 1st value
life[2] # prints 2nd value
life[3] # etc 
head(life) # check, they match up

life[1:2] # this displays a particular range of data
life[1:10]
life[1694:1704]

life[c(1, 2)] # lets you buiuld a vector with partular values
life[c(1, 2, 3, 100, 700)]

####Back to gapfinder data.frame####
gapminder[1, 1]
names(gapminder) # shows column names
gapminder[1, 'country'] # you can call out columns by name, not just number, makes it easer to read when going back over code
gapminder[1, c('country', 'year')] # shows matrix of 1st value of 1st 2 columns
gapminder[1, ] #if you don't specify columns, it prints all
gapminder[1:10, ]
gapminder[, c('country', 'year')]

####Excercises####

#1
gapminder[100, ]

#2
gapminder[40:50, c('country', 'continent', 'lifeExp')]

#3
life[c(1:2, 10, (1704 - 5):1704)] # prints 1st, 2nd, 10th, and last 6 values of life
life[c(1:2, 10, (length(life)-5):length(life))] # same thing
life[c(1:2, 10, (1704 - 5):1704)] == life[c(1:2, 10, (length(life)-5):length(life))] #check if they are the same

####intro to ggplot####

plot(gapminder$pop ~ gapminder$year) # plots pop by year

# ggplot comes from grammar of graphics
# data must be as data.frame 
# tidy data - every variable has it's own discrete column, nothing dependant on another column
# aesthetic (aes):  tells ggplot where to put points and lines - mapping variables to visual properties-position, colour, line type, size 
# geoms: actual visialization of data, ie geombar, geomline, geomhistogram, etc
# scale: map values, color, size, shape. shows up as legends and axis
# stat: statistical transformations, summaries of data
# facet: separates data into different panels

install.packages('ggplot2')
library(ggplot2)

ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_point() # use gapminder data, year on x, lifeexp on y, make a scatterplot

#####adding some color!####

ggplot(data = gapminder, aes(x = year, y = lifeExp, color = continent)) + geom_point() # add color to continent
 #### layering ####

ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) + geom_line() # lines coded by country, color by continent

p <- ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) # saves this plot to variable p
p + geom_point()

# many layers are built in (defaults)
# color modifies layers
# titles are 

p + geom_point(aes(color = continent)) # add color a different way

ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country, color = continent)) +
    geom_point()+
    geom_line()

ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country)) + # this puts color in a different layer
  geom_point()+
  geom_line(aes(color = continent))

ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country)) + # this changes the order of the layers, putting the points on top
  geom_line(aes(color = continent)) + 
  geom_point()
  

#### Scales ####
# axis and legends
# modifying scales

ggplot(data = gapminder, aes (x = year, y = lifeExp, by = country, color = log(gdpPercap)))+ 
    geom_point()

ggplot(data = gapminder, aes (x = year, y = lifeExp, by = country, color = continent))+ 
  geom_point()    

#### dev ####
dev.new() # make a new window to plot something else
dev.list() # lists all windows
dev.set(4) # sets a new active window
dev.cur() # prints active window

#### scales again ####
# keep track of what your data is (num, factor, etc)

# in class excercise
ggplot(data = gapminder, aes (x = year, y = lifeExp, by = country, 
                              color = log(gdpPercap))) + 
  geom_point()+ 
  scale_color_gradientn(colours = topo.colors(10))




ggplot(data = gapminder, aes (x = year, y = lifeExp, color = log(gdpPercap))) + # facets allow multiple panels per plot
    geom_point() +
    facet_wrap(~ continent)
             
ggplot(data = gapminder, aes (x = year, y = lifeExp, color = log(gdpPercap))) + # jitter spreads data out
    geom_jitter()


ggplot(data = gapminder, aes (x = year, y = lifeExp, color = log(gdpPercap))) + # alpha addjusts point transparency
    geom_point(alpha = 0.3)

ggplot(data = gapminder, aes (x = year, y = lifeExp, color = log(gdpPercap))) + # geom_text labels points
    geom_point() +
    geom_text(aes(label = year))

ggplot(data = gapminder, aes (x = year, y = lifeExp, color = log(gdpPercap))) + 
    geom_point() +
    geom_text(aes(label = country))



#### dplyr ####


# split-apply-combine

# load todays libraries

library(dplyr)
library(gapminder)
library(ggplot2)

# filter and select
filter(gapminder, country == 'Canada')

# Doesn't work because there is no column b the name of Canada
select(gapminder, Canada)

(gapminder[, 'country'])+
select(gapminder, country) # selects columns by name

head(select(gapminder, starts_with('C')))

#### pipe ####
group_by(gapminder, continent) %>%
    summarise(mean_life = mean(lifeExp))    # collapses data

# calculate GDP

head(mutate(gapminder, gdp = gdpPercap * pop))    # does something to every row of data, eg add 1. makes new column and shows all original
    
head(transmute(gapminder, gdp = gdpPercap * pop))    #   makes new column, only shows new one

head(arrange(gapminder, lifeExp))

head(arrange(gapminder, desc(lifeExp))) # switches to descending

tbl_df(gapminder)
gapminder <- tbl_df(gapminder) # changes class of gapminder, gives it a different view. will only print 10 rows by default

##### in class excersizes ##### 

#1
#For each continent, which country had the smallest population in 1952, 1972, and 2002?
filter(gapminder, year == 1952 | year == 1972 | year == 2002) %>%
    g

flter(gapminder, year == c(1952, 1972, 2002)) %>% # this one is dangerous
    arrange(desc(year))

# here is the real answer
# if you have a list of values you want to compare to, use %in%, not a bunch of = signs
by continent
subset 1952, 1972, 2002
minimum population

gapminder <- tbl_df(gapminder)

gapminder %>%
    filter(year %in% c(1952, 1972, 2002)) %>%
    group_by(continent, year) %>%
    slice(which.min(pop))%>%
    select(country, year, pop)
    

# 2
ggplot(data = gapminder, aes(x = year, y = pop, by = country, color = continent)) + geom_line()


#3 mean gdpPercap
gapminder %>%
    group_by(country) %>%
    summarise(mean(gdpPercap))

    
#4 mean gdp
gapminder %>%
    mutate(gdp = gdpPercap * pop) %>%
    group_by(country) %>%
    summarise(mean(gdp))
   

#  total population of each  continent over time

total_pop_df <-
    gapminder %>%
    group_by(continent, year) %>%
    summarize(total_pop = sum(pop))

ggplot(data = total_pop_df, aes(x = year, y = total_pop, color = continent))+
    geom_point()



# 1) how many countries are there on each continent
count countries in each continent, aka rows

gapminder %>%
    count(continent)


# 2) what countries have the best and worst life expectancies in each continent

gapminder %>%
    group_by(country) %>%
    summarise(continent, which.min(lifeExp), which.max(lifeExp))

gapminder %>%
    group_by(country) %>%
    slice(max(lifeExp, min(lifeExp)))

# 3) which country experiences the sharpest 5 year drop in life expectancy
# lead
# lag
# have continent country, year, lifeExp
#      Asia      China    1995   78
#      Asia      China    2000   83

# group by country so everything going forward is by country
# then arrange by year to make sure it's in order to calculate differences every 5 years, doesn't change which data you're working with
# from there, there are several options
# slice subsets out rows we want

gapminder %>%
    group_by(country) %>%
    arrange(year) %>%
    mutate(diff = lifeExp-lead(lifeExp)) %>%
    group_by(continent) %>%  #  this allows us to pull out an outlier if we had faceted by continent
    slice(which.min(diff))

  
    



#### subsetting, vectors, and indices ####
meow <-c(1, 2, 3, 4, 10, 11, 12)
meow[c(5, 7)]  # or the following if you don't know the length
meow[c(5, length(meow))]

# function review
function(arg1, arg2, arg3, ...)
mean(x, trim = 0, na.rm = FALSE)

# vectors
Dim       Homogeneous (only 1 type of object, ie all numbers, etc)         Heterogeneous
1d                       Atomic Vector                                         List
2d                          Matrix                                          data.frame
nd                           Array



# Atomic vectors
# there are 4 types: logical, ingteger, double (numeric) (have decimals), Character

# lets make some vectors!

# creating a double vector
dbl_vec <-c(1.2, 1.3, 1.4, 2.5)
str(dbl_vec)
typeof(dbl_vec)

# creating an integer vector (numeric, but discrete)
int_vec <- c(1, 2, 3, 4)# this just produces a double vector
typeof(int_vec)

int_vec <- c(1L, 2L, 3L, 4L)
typeof(int_vec)

# creating a logical vector
log_vec <- c(TRUE, FALSE, TRUE)
typeof(log_vec)
log_vec
sum(log_vec)


# creating a character vector
chr_vec <- c("a", "b", "c")
chr_vec
typeof(chr_vec)



# Coercion
z <- read.csv(text = "value\n12\n1\n.\n9")
str(z)

typeof(z)
typeof(z[[1]])

as.double(z[[1]])  # changes vector type

as.character(z[[1]])
as.double(as.character(z[[1]])) #this is how you have to make it actual numbers. warning is because . is not a number

# or be clever:
z <- read.csv(text = "value\n12\n1\n.\n9",  # adding stringsaAsFactors lets you skip a few steps
              stringsAsFactors = FALSE)

typeof(z[[1]])
as.double(z[[1]])


#  2 dimensional structures
# matrix

a <- matrix(1:6, ncol = 3, nrow = 2)
a
str(a)
a[, 3]

length(a)
dim(a)
nrow(a)
ncol(a)


x <- c('a', 'b', 'c', 'd', 'e', 'f')

a <- matrix(x, ncol = 3, nrow = 2)
a
x <- c(x, 1, 2, 3)
x


# Data.frames
library(gapminder)
str(gapminder)


rows 10:20
cols country, lifeExp

gapminder[10:20, c('country', 'lifeExp')]  # need c to tell it how many columns there will be

rows 1, 10, 20, 100

gapminder[c(1:10, 20, 100), ]  # comma with nothing is important, tells it to do all the columns. not specifiying makes it do none and bug out. gapminder is 2 dimensionial 

what are the 3 subsetting operators?
object[] - multiple values
object$ - named values
object [[]] lists (mostly): things inside things. nested objects.

####pepper example####
# subestting nested objects
shaker with pepper packet inside, want to get individual pepper grains
# start from inside out
shaker
pepper packet
grains

pp1 <- c('g1', 'g2', 'g3')
pp1

pp2 <- pp1
pp3 <- pp2

shaker <- list(pp1, pp2, pp3)
shaker

shaker[[1]]  # get first element in the list
shaker[[1]][2] # don't need to double bracket 2nd one, unless it's another list
shaker[1][2] # doesnt work - just makes it a shorter list, this is why you need the double brackets first. R doesnt know how to read the 2nd value without knowing its nested. double brackets lets you inside

we want to retrieve pp1

shaker[[1]] # this makes it from a list to a vector
shaker [[1]][3] # pulls an element from the vector





##### for loops ####

#  Iteration

foo <- c(7, 10, 11, 52, 55, 83, 10, 9)
foo[1] # would be 7, foo[8] would be 9

#### for loops ####
animals <- c("cats", "dogs", "ponies", "koi", "chickens", "moose")
for (animal in animals){ 
    len <- nchar(animal)
    print(len)
}

for (i in 1:6){
    len <- nchar(animals[i])
    print(len)
}

excersize: calculate the square of the values from 1 -10

for (i in 1:10){
  sq <- i^2
   print(sq)
}

sq <- vector(length = 10)
for (i in 1:10){
    sq[i] <- i^2
}
print(sq)

calculate the cumulative sum of the values from 1 - 10

c_sum <- 0
for (i in 1:10){
    browser()  #  this is a debugging tool
    c_sum <- c_sum + i
   
}    
print(c_sum)    
