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

y1=df$Sub_metering_1
y2=df$Sub_metering_2
y3=df$Sub_metering_3
x=df$Time

png(file="plot3.png",width=480, height=480, units = "px")
plot(x,y1, type = "l", ylab="Energy sub metering", ylim = c(0,30))
lines(x,y2, col="red")
lines(x,y3, col="blue")
legend("topright",lty = 1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()
