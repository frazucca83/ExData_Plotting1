# Script to make the plots 

# NOTE it uses dplyr
library(dplyr)

#Read the data
a <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",stringsAsFactors = FALSE )

# filter, add a POSIXct column for the date/time and convert to numeric  

a <- a %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        mutate(DateGMT = as.POSIXct( strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))) %>%
        mutate_at(vars(matches("Global|Sub_")),funs(as.numeric))

# saving the plot to png

png(filename = "plot3.png")
with(a, plot(DateGMT,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "" ))
with(a, lines(DateGMT,Sub_metering_2, col = "red"))
with(a, lines(DateGMT,Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = rep(1,3), col = c("black", "red", "blue"))
dev.off()