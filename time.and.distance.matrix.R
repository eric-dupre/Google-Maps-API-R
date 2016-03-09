#This script introduces the functionality of the Google Maps Distance Matrix API
#see this page for more information on the Google Maps Distance Matrix API and usage limits
# https://developers.google.com/maps/documentation/distance-matrix/usage-limits

#To begin, install the 'ggmap' package and load it into the workspace
#install.packages('ggmap')
library(ggmap)

#For this project, we will take advantage of the mapdist function that gives the 
#distance and time (walking, driving, etc) between two points

#####
#####
#Example

#Driving distance from City Hall to the French Market
mapdist(from='29.952599, -90.076980', to='29.959710, -90.059679', mode='driving', output='simple')

#Driving distance from the French Market back to City Hall
mapdist(from='29.959710, -90.059679', to='29.952599, -90.076980', mode='driving', output='simple')
#note that the times and distances are NOT the same (due to road restrictions)

#Walking distance from City Hall to the French Market
mapdist(from='1300 Perdido St New Orleans', to='425 Ursulines Ave New Orleans', mode='walking', output='simple')
#####
#####


#Now we will apply this function to find the distances between each of our census tract centroids
#set the working directory to wherever you have saved the midpoints csv file
#a vector of geo-coordinates are saved to the object from1
setwd('E:/FINAL_DATA')
points <- read.csv('midpoints_edit.csv', sep=',', header=TRUE)
from1 <- paste(points$Lat, points$Long, sep=", ")

#These three lines initialize the objects that the loop uses
distance <- as.data.frame(x=NA)
time <- as.data.frame(x=NA)
calc <- as.vector(x=NA)

#in this block, we loop through the midpoints to create two matrices
#the first, 'time', will display the time (in minutes) that it would take to go from the two midpoints given current traffic
#the second, 'distance', will display the distance (in miles) between the two locations along the fastest route
#The following block of code would perform all 30,000 calculations. But the free version of the API only allows 2500 daily calculations

for (i in 1:length(from1)) {
  for (j in 1:length(from1)) {
    if (i == j) {
      distance[i,j+1] <- 0
      time[i,j+1] <- 0
    }
    else {
      calc <- mapdist(from1[i],from1[j],mode='driving', output='simple')
      distance[i,j+1] <- calc[5]
      time[i,j+1] <- calc[7]
      distance[i,1] <- as.character(points[i,3])
      colnames(distance)[1] <- 'Miles'
      colnames(distance)[j+1] <- as.character(points[j,3])
      time[i,1] <- as.character(points[i,3])
      colnames(time)[j+1] <- as.character(points[j,3])
      colnames(time)[1] <- 'Minutes'
    }
  }
}


#For a sample of the first 5 midpoints, use the code below:
for (i in 1:5) {
  for (j in 1:5) {
    if (i == j) {
      distance[i,j+1] <- 0
      time[i,j+1] <- 0
    }
    else {
      calc <- mapdist(from1[i],from1[j],mode='driving', output='simple')
      distance[i,j+1] <- calc[5]
      time[i,j+1] <- calc[7]
      distance[i,1] <- as.character(points[i,3])
      colnames(distance)[1] <- 'Miles'
      colnames(distance)[j+1] <- as.character(points[j,3])
      time[i,1] <- as.character(points[i,3])
      colnames(time)[j+1] <- as.character(points[j,3])
      colnames(time)[1] <- 'Minutes'
    }
  }
}




