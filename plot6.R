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
#Find which SCC codes correspond to Non-Road and On-Road (Eliminate Dust Paved Road)
# This includes Non-Road on the assumption that Non-Road means off-road

VehicleCodes <- SCC[grep("-Road", SCC$EI.Sector),]["SCC"]


#
#pull out(subset) just the vehicle codes
JustVehicles <- NEI [NEI$SCC %in% VehicleCodes$SCC,]

#pull out (subset) just Baltimore City and Los Angeles
JustVehicles <- subset (JustVehicles,fips == "24510"|fips =="06037")

#Replace fips code with actual name to improve legibility of plot
JustVehicles [JustVehicles=="24510"] <- "Baltimore"
JustVehicles [JustVehicles=="06037"] <- "Los Angeles"

#
# Calculate the total vehicle emissions by year
YearTotal <- aggregate (Emissions ~ fips + year, data = JustVehicles, sum)

#open the graphics device
png (file = "Ex_Data_Project2/plot6.png", height = 480, width = 640, bg=NA)

#
#Rename fips column to County to improve Legibility of Legend
#
colnames(YearTotal)[1] <- "County"

#create a line plot to show trend
g<- ggplot (YearTotal, aes(x=year, y=Emissions))
g + geom_point(size = 3,shape= 8, color="red") + geom_line (aes(color = County)) +
        scale_x_continuous(breaks = seq(1999, 2008, 3))  +
        labs(title= "Comparison of Motor Vehicle Emissions for Baltimore & Los Angeles from 1999-2008") +
        labs(y="Annual Emissions (Tons)")

#Turn off the graphics device
dev.off ()
