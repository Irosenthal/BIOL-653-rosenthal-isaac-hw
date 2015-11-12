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

##### for loops excercize ######
 mat <- matrix(1:100, nrow = 10, ncol = 10)
for (i in 1:100){
    print(i)
}


set.seed(1)
x <- round(runif(min = 10, max = 100, n = 15))
# creating a vecotor of random numbers using a set seed, from 10 to 100 containing 15 values


#3a
for (i in x){
    print(paste(i)) # this works and makes sense
}

#3b
x <- round(runif(min = 10, max = 100, n = 15))

counts <- vector(length = length(x))   # this doesn't work and doesn't make sense
for (i in x){
   counts <- paste(i)
}


# paste converts it's arguements into a string



#4

for (i in 1:10){
    sq <- 2^i
    print(sq)   # this was easy
}   

#5

matr <- matrix(1:12, nrow = 12, ncol = 12)
print(matr)    # this is cheating



for (i in 1:12){
matr <- i*i
print(matr)
}   # but this is broken.


#### how to write functions ####

# function(arg1, arg2, arg3)
# mean(x, trim, na.rm)

#write a function to get the difference between max and min values in a set of values
x <- (2:200)
max(x)-min(x)

#functions have name, (typically a verb), arguments (inputs), and body (code)

max_minus_min <-function(x){
    dif <- max(x)-min(x)
    return(dif)
}

max_minus_min(x)

# be aware of defensive programming, don't let your function do silly things

library(gapminder)

max_minus_min(gapminder$lifeExp)

max_minus_min(gapminder$gdp) 

max_minus_min(gapminder$country) #this won't work 

max_minus_min(gapminder[,c('lifeExp', 'gdpPercap', 'pop')]) # this should not give only 1 value, our function is missing something

max_minus_min(c(TRUE, FALSE< TRUE, FALSE, TRUE))  # would we really want this to give us a value? no.

   #we need to add some stuff to the function

max_minus_min <- function(x){
    stopifnot(is.numeric(x))
    dif <- max(x)-min(x)
    return(dif)
}

# write a function that squares a value

square <- function(x){
    stopifnot(is.numeric(x))
    sq <- x^2  
    return(sq)
}

Powerup <- function(x, y){
    stopifnot(is.numeric(x))
    p <- x^y
    return(p)
}
# If you dont store and return it will only print the last answer. if you wanted x^2, x^3, and x^4, it would only show X^4

# do not overwrite existing functions when you name!

square(8)


source("01_load.R") # will run a script from a different file, allows you to keep things neat by keeping functions in a separate script

# write a function that takes a value and you can chose to raise it any power

Powerup <- function(x, y){
    stopifnot(is.numeric(x))
    pow <- x^y
    return(pow)
}

Powerup(10, 3)



#### Tidyr ####

install.packages('tidyr')

library(gapminder)
library(tidyr)
library(dplyr)


# create today's data table

gap <- 
    filter(gapminder, grepl("^N", country)) %>% 
    filter(year %in% c(1952, 1977, 2007)) %>% 
    slice(1:9) %>% 
    select(-continent, -gdpPercap, -pop) %>% 
    mutate(lifeExp = round(lifeExp)) %>% 
    spread(key = year, value = lifeExp)

gap

gap_with_cont <- 
    filter(gapminder, grepl("^N", country)) %>% 
    filter(year %in% c(1952, 1977, 2007)) %>% 
    slice(1:9) %>% 
    select(-gdpPercap, -pop) %>% 
    mutate(lifeExp = round(lifeExp)) %>%
    spread(key = year, value = lifeExp)

gap_with_cont

# timeout, slice example. slice a few specified rows
slice(.data = gapminder, c(1, 2, 50:55, 650))
###


# tidying data

gap

#we need to gather. something like ggplot couldn't plot this by year

# key is the name of the new column we are creating
#value are all the values inside the cells that we are pushing into the column
# last numbers are which columns to use

tidied_gap <- gather(data = gap, key = year, value = lifeExp, 2:4)

tidied_gap


# can also just show which columns to ignore

tidied_gap2 <- gather(data = gap, key = year, value = lifeExp, -country)

# what if we have an extra column, in this case continent

gap_with_cont

tidied_gap_with_cont <-
    gather(data = gap_with_cont, key = year, value = lifeExp, 3:5)



# lets spread the data

tidied_gap

spread_gap <-
    spread(data = tidied_gap, key = year, value = lifeExp)


# excercise

set.seed(1)
counts <- 
    data.frame(site = c(1, 1, 2, 3, 3, 3), taxon = c("A", "B", "A", "A", "B", "C"),
               abundance = round(runif(n = 6, min = 0, max = 20), 0))
counts

counts_wide <-
    spread(data = counts, key = taxon, value = abundance, fill = 0)

counts_wide

counts_long <-
    gather(data = counts_wide, key = taxon, value = abundance, 2:4)
    
counts_long


####separate and unite ####

might have scientific names

"Panthera orica"
"Panthera species 2"
"Mus musculus"

# unite

united_places <-
unite(data = tidied_gap_with_cont, col = location_key, country:continent, sep = '_')

separate (data = united_places, col = location_key, into = c('country', 'continent'), sep = '_')





#### morning excercise ####

mammals <- data.frame(site = c(1,1,2,3,3,3), 
                      taxon = c('Suncus etruscus', 'Sorex cinereus', 
                                'Myotis nigricans', 'Notiosorex crawfordi', 
                                'Scuncus etruscus', 'Myotis nigricans'),
                      density = c(6.2, 5.2, 11.0, 1.2, 9.4, 9.6)
)

mam_wide <- 
    spread(data = mammals, key = taxon, value = density, fill = 0)

mam_long <-
    gather(data = mam_wide, key = taxon, value = density, 2:6)


separate(data = mam_long, col = taxon, into = c('genus', 'species'))


# add a new column
set.seed(100)
mammals$counts <- round(runif(n = 6, min = 0, max = 100))
mammals

select(.data = mammals, site, taxon, density) %>%
    spread (key = taxon, value = density, fill = 0)

select(.data = mammals, site, taxon, counts) %>%
    spread(key = taxon, value = counts, fill = 0)

mammals %>%
    unite(col = density_counts, density, counts, sep = '__') %>%
    spread(key = taxon, value = density_counts, fill = '0__0') %>%
    gather(key = taxon, value = density_counts, -site) %>%
    separate(col = density_counts, into = c('density', 'counts'), sep = '__')



#### whale excersise ####
set.seed(7)
whale_counts <- data.frame(whale = c('Badger', 'Bamboo', 'Humphrey', 'Kumiko', 
                                     'Ester', 'Moby Dick'), 
                           A_2009 = round(runif(n = 6, min = 0, max = 20), 0), 
                           A_2010 = round(runif(n = 6, min = 0, max = 20), 0),
                           A_2011 = round(runif(n = 6, min = 0, max = 20), 0),
                           B_2009 = round(runif(n = 6, min = 0, max = 20), 0),
                           B_2010 = round(runif(n = 6, min = 0, max = 20), 0),
                           B_2011 = round(runif(n = 6, min = 0, max = 20), 0)
)

whale_counts %>%
    gather(key = site_year, value = sightings, 2:7) %>%
    separate(col = site_year, into = c('site', 'year'), sep = '_')
