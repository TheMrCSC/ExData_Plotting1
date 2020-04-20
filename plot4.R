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
        mutate(Sub_metering_3 = as.numeric(as.character(Sub_metering_3))) %>%
        #converting Voltage to numeric
        mutate(Voltage = as.numeric(as.character(Voltage))) %>%
        #converting Global_reactive_power to numeric
        mutate(Global_reactive_power = as.numeric(as.character(
                Global_reactive_power)))


#removing extra large dataset
rm(allData)


#opening PNG file
png("plot4.png",width = 480, height = 480, units = "px")


#creating required plot
#setting up 4x4 plot
par(mfcol = c(2,2))


#creating plot in top left corner
with(reqData, plot(DateTime, Global_active_power, type = "l", 
                   ylab = "Global Active Power", xlab = ""))


#creating plot in bottom left corner
with(reqData, plot(DateTime, Sub_metering_1, type = "l", 
                   ylab = "Energy sub metering", xlab = "", col = "black"))
lines(reqData$DateTime, reqData$Sub_metering_2, type = "l", col = "red")
lines(reqData$DateTime, reqData$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black","red", "blue"), legend = 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1
       ,bty = "n")


#creating plot in top right corner
with(reqData, plot(DateTime, Voltage, type = "l", 
                   ylab = "Voltage", xlab = "datetime"))


#creating plot in bottom right corner
with(reqData, plot(DateTime, Global_reactive_power, type = "l", 
                    xlab = "datetime"))


#saving and closing PNG file
dev.off()