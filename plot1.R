# the dataset so large, just select the parts that are needed.
sub_pc <- read.delim('household_power_consumption.txt', 
                     sep=';',header=TRUE, nrows = 700000)
str(sub_pc)
sub_pc$Date <- as.Date(sub_pc$Date, '%d/%m/%Y')
pdata <- subset.data.frame(sub_pc, Date >= as.Date('2007-02-01') &
                             Date <= as.Date('2007-02-02'), na.strings='?')
pdata$Global_active_power <- as.numeric(pdata$Global_active_power)

# create a png file for the plot.
png(filename='plot1.png', width=480, height=480)
hist(pdata$Global_active_power, main='Global Active Power', col='red', 
     xlab='Global Active Power(kilowatts)')
dev.off()

