# the original data is so large, just select the parts that are needed.
sub_pc <- read.delim('household_power_consumption.txt', 
                     sep=';',header=TRUE, nrows = 700000, na.strings='?')

sub_pc$Date <- as.Date(sub_pc$Date, '%d/%m/%Y')
pdata <- subset.data.frame(sub_pc, Date >= as.Date('2007-02-01') &
                             Date <= as.Date('2007-02-02'))

library(dplyr)
pdata3 <- mutate(pdata, Ftime =as.POSIXct(paste(Date, Time)),.before=Global_active_power)
pdata3 <- pdata3[complete.cases(pdata3), ] # remove the incomplete rows.
# create a png file for the plot2.
png(filename='plot3.png', width=480, height=480)


with(pdata3, {plot(Sub_metering_1~Ftime, type='s', xlab='', ylab='Energy sub metering')
 lines(Sub_metering_2 ~Ftime, type='s',xlab='', col='red') 
lines(Sub_metering_3 ~Ftime, type='s',xlab='', col='blue')}) 
legend('topright', col=c('black', 'red', 'blue'),lwd=c('1','1','1'),
       c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

dev.off()