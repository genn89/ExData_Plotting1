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
x=df$Time

png(file="plot2.png",
    width=480, height=480, units = "px")
plot(x,y, type = "l", xlab = "", ylab = "Global Activer Power (kilowatts)")
dev.off()