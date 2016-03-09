# Google-Maps-API-R

In this code, I utilize the functionality of the Google Maps API through the ggmap package in R. The data I use are the midpoints of 
New Orleans' 177 census tracts. With these tools and data, I create a distance matrix that gives the driving distance between any 
two midpoints. Additionally, I create a second matrix that yields the real-time driving time between the two points. 

Note that the API only allows for 2500 calculations per day for free, so I have a sample at the end of the program that will only create
the matrices for the first 5 midpoints. Additionally, I include a few demo calculations at the beginning to introduce the user to 
the functionality of the package. Finally, I upload the midpoints file here as a .csv file. 
