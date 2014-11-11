#
#
#  Read the data
## CODE ASSUMES the data files are in a sub-directory ("Data") below the working directory.
#
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

#
#Find which SCC codes correspond to Non-Road and On-Road (Eliminate Dust Paved Road)
# This includes Non-Road on the assumption that Non-Road means off-road

VehicleCodes <- SCC[grep("-Road", SCC$EI.Sector),]["SCC"]


#
#pull out(subset) just the vehicle codes
JustVehicles <- NEI [NEI$SCC %in% VehicleCodes$SCC,]

#pull out (subset) just Baltimore City
JustVehicles <- subset (JustVehicles,fips == "24510")

#
# Calculate the total vehicle emissions by year
YearTotal <- aggregate (Emissions ~ year, data = JustVehicles, sum)


#open the graphics device
png (file = "Ex_Data_Project2/plot5.png",width = 480, height = 480, bg=NA)

#create a line plot to show trend
#turn off axes because base plot uses different years than the data
plot (YearTotal$year, YearTotal$Emissions, type="l", axes=FALSE,
      xlab="",ylab="Annual Emissions (Tons)", 
      main="Motor Vehicle Emissions in Baltimore City from 1999–2008")

#add characters showing the data points on graph
points(YearTotal$year, YearTotal$Emissions, pch = 8, col = "red")

#draw the axes
axis(side = 1, at = seq(1999, 2008, by = 3))
axis(side=2)
#add the box around the plot to make it look pretty normal
box () 


#Turn off the graphics device
dev.off ()
