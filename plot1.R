# Script to make the plots 

# NOTE it uses dplyr
library(dplyr)

#Read the data
a <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",stringsAsFactors = FALSE, na.strings = "?" )

# filter, add a POSIXct column for the date/time and convert to numeric  

a <- a %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
           mutate(DateGMT = as.POSIXct( strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))) %>%
           mutate_at(vars(matches("Global|Sub_")),funs(as.numeric))
                     
# saving the plot to png

png(filename = "plot1.png")
hist(a$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()