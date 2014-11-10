#
#install and load the ggplot2 package

install.packages ("ggplot2")
library (ggplot2)
library (grid)  #needed for theme panel margin units

#
#
#  Read the data
## CODE ASSUMES the data files are in a sub-directory ("Data") below the working directory.
#
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

#
# Calculate the total emissions by year
OnlyBaltimore <- subset (NEI,fips == "24510")
OnlyBaltimore <- aggregate (Emissions ~ type + year, data =OnlyBaltimore, sum)


#open the graphics device
png (file = "Ex_Data_Project2/plot3.png", height = 480, width = 640, bg=NA)

#create a line plot to show trend
g<- ggplot (OnlyBaltimore, aes(x=year, y=Emissions))
g + geom_point(size = 3,shape= 8, color="red") + geom_line () + facet_grid (. ~ type) +
        scale_x_continuous(breaks = seq(1999, 2008, 3))  +
        geom_smooth(method = "lm", se=FALSE) + theme(panel.margin = unit(1, "lines"))



#Turn off the graphics device
dev.off ()
