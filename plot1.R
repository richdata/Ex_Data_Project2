#
#
#  Read the data
#
#
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

#
# Calculate the total emissions by year

YearTotal <- aggregate (Emissions ~year, data =NEI, sum)


#open the graphics device
png (file = "Ex_Data_Project2/plot1.png",width = 480, height = 480, bg=NA)

#create a line plot to show trend
#turn off axes because base plot uses different years than the data
plot (YearTotal$year, YearTotal$Emissions, type="l", axes = FALSE,
      xlab="",ylab="Annual Emissions (Tons)", 
      main="Total US PM2.5 emissions from 1999 to 2008")

#add characters showing the data points on graph
points(YearTotal$year, YearTotal$Emissions, pch = 8, col = "red")

#draw the axes
axis(side = 1, at = seq(1999, 2008, by = 3))
axis(side=2)
#add the box around the plot to make it look pretty normal
box () 


#Turn off the graphics device
dev.off ()
