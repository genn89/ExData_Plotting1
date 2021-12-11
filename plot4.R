#load data
household <- read.table("household_power_consumption.txt",sep = ";", header=T)

#check on type of variables
str(household)

#convert Data and time
household$Date=as.Date(household$Date, format="%d/%m/%Y")

#define subset
df=filter(household, Date >= "2007-02-01", Date <= "2007-02-02")

#convert time
df <- mutate(df, Time = as.POSIXlt(paste(Date, format(as.POSIXlt(Time, format = "%H:%M:%S"), '%T'))))

#convert variables in numeric
df=df%>%
  mutate_if(is.character,as.numeric)

y=df$Global_active_power
y1=df$Sub_metering_1
y2=df$Sub_metering_2
y3=df$Sub_metering_3
y4=df$Voltage
y5=df$Global_reactive_power
x=df$Time

png(file="plot4.png",width=480, height=480, units = "px")
par(mfrow=c(2,2))
plot(x,y, type = "l", xlab = "", ylab = "Global Activer Power")
plot(x,y4, type = "l", xlab = "datetime", ylab = "Voltage")
plot(x,y1, type = "l", ylab="Energy sub metering")
lines(x,y2, col="red")
lines(x,y3, col="blue")
legend("topright",lty = 1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(x,y5, type = "l", xlab = "datetime", ylab ="Global_reactive_power")
dev.off()
