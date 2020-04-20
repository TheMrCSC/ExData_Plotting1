library(dplyr)


#reading data
allData <- read.table(".\\Data\\household_power_consumption.txt", sep = ";"
                      ,header = TRUE)


#cleaning and preparing data
#filtering data for 2 days
reqData <- allData %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        #converting Date field to Date
        mutate(Date = as.Date(strptime(as.character(Date),'%d/%m/%Y'))) %>%
        #Merging and creating Date Time field        
        mutate(DateTime = as.POSIXct(as.character(paste(Date, Time)))) %>%
        #converting Global_active_power to numeric        
        mutate(Global_active_power = as.numeric(as.character(
                Global_active_power))) %>%
        #converting Sub_metering_1 to numeric
        mutate(Sub_metering_1 = as.numeric(as.character(Sub_metering_1))) %>%
        #converting Sub_metering_2 to numeric
        mutate(Sub_metering_2 = as.numeric(as.character(Sub_metering_2))) %>%
        #converting Sub_metering_3 to numeric
        mutate(Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))


#removing extra large dataset
rm(allData)


#opening PNG file
png("plot3.png",width = 480, height = 480, units = "px")


#creating required plot
with(reqData, plot(DateTime, Sub_metering_1, type = "l", 
                   ylab = "Energy sub metering", xlab = "", col = "black"))
lines(reqData$DateTime, reqData$Sub_metering_2, type = "l", col = "red")
lines(reqData$DateTime, reqData$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black","red", "blue"), legend = 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)


#saving and closing PNG file
dev.off()