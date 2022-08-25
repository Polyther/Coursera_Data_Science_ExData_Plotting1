# the dataset so large, just select the parts that are needed.
sub_pc <- read.delim('household_power_consumption.txt', 
                     sep=';',header=TRUE, nrows = 700000, na.strings='?')

sub_pc$Date <- as.Date(sub_pc$Date, '%d/%m/%Y')
pdata <- subset.data.frame(sub_pc, Date >= as.Date('2007-02-01') &
                             Date <= as.Date('2007-02-02'))
pdata$Global_active_power <- as.numeric(pdata$Global_active_power)
library(dplyr)
pdata2 <- mutate(pdata, Ftime =as.POSIXct(paste(Date, Time)),.before=Global_active_power)
pdata2 <- pdata2[complete.cases(pdata2), ] # remove the incomplete rows.
# create a png file for the plot2.
png(filename='plot2.png', width=480, height=480)


with(pdata2, plot(Global_active_power~Ftime, type='s',
     xlab='', ylab='Global Active Power(kilowatts)' ))

dev.off()