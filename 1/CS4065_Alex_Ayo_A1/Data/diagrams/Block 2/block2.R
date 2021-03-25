#manipulations for block 2
blockData = read.csv("block2.csv")
# Reaction Time Plot for Block 2
reactionTimeScatter = scatter.smooth(blockData$Trial, blockData$ResponseTime.ms., pch= ifelse(blockData$ResponseTime.ms. < 0, NaN, 19), xlab = "Trial Number", ylab = "Reaction Time in ms", main = "Reaction Time Plot for Block 2", xlim= c(1,20), ylim = c(0, 3000))
# ScatterPlot for Errors in block 2
x=blockData$Trial
y=blockData$ErrorTimes
errorScatter = plot(x, y, pch = ifelse(y == 0, NaN, 19), xlab = "Number of trials", ylab = "Number of Errors", main = "ScatterPlot for Errors in block 2", xlim= c(1,20), ylim = c(0,1))

# average completion time block 2
averageCompletionTime = mean(blockData$ResponseTime.ms.)
averageCompletionTime

# average number of errors block2
averageNumberOfErrors = mean(blockData$ErrorTimes)
averageNumberOfErrors