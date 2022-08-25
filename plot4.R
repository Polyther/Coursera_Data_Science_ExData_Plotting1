sub_pc <- read.delim('household_power_consumption.txt', 
                     sep=';',header=TRUE, nrows = 700000, na.strings='?')

sub_pc$Date <- as.Date(sub_pc$Date, '%d/%m/%Y')
pdata <- subset.data.frame(sub_pc, Date >= as.Date('2007-02-01') &
                             Date <= as.Date('2007-02-02'))
pdata$Global_active_power <- as.numeric(pdata$Global_active_power)
library(dplyr)
pdata4 <- mutate(pdata, Ftime =as.POSIXct(paste(Date, Time)),.before=Global_active_power)
pdata4 <- pdata4[complete.cases(pdata4), ] # remove the incomplete rows.
# create a png file for the plot2.
png(filename='plot4.png', width=480, height=480)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(pdata4, {plot(Global_active_power~Ftime, type='s',
                  xlab='', ylab='Global Active Power' )

  plot(Voltage~Ftime, type='s',
                  xlab='datetime', ylab='Voltage' )

  {plot(Sub_metering_1~Ftime, type='s', xlab='', ylab='Energy sub metering')
  lines(Sub_metering_2 ~Ftime, type='s',xlab='', col='red') 
  lines(Sub_metering_3 ~Ftime, type='s',xlab='', col='blue')
  legend('topright', col=c('black', 'red', 'blue'),lwd=1, bty='n',cex=0.5,
       c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))}

  plot(Global_reactive_power~Ftime, type='s',
                  xlab='datetime', ylab='Global_Reactive_Power' )})

dev.off()