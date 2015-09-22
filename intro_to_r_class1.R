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
