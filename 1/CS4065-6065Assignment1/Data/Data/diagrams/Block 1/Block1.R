#manipulations for block 1
blockOneData = read.csv("Block1.csv")
# Reaction Time Plot for Block 1
reactionTimeScatter = scatter.smooth(blockOneData$Trial, blockOneData$ResponseTime.ms., pch= ifelse(blockOneData$ResponseTime.ms. < 0, NaN, 19), xlab = "Trial Number", ylab = "Reaction Time in ms", main = "Reaction Time Plot for Block 1", xlim= c(1,20), ylim = c(0, 3000))
# ScatterPlot for Errors in block1
x=blockOneData$Trial
y=blockOneData$ErrorTimes
errorScatter = plot(x, y, pch = ifelse(y == 0, NaN, 19), xlab = "Number of trials", ylab = "Number of Errors", main = "ScatterPlot for Errors in block1", xlim= c(1,20), ylim = c(0,1))

# average completion time block 1
averageCompletionTime = mean(blockOneData$ResponseTime.ms.)
averageCompletionTime

# average number of errors block1
averageNumberOfErrors = mean(blockOneData$ErrorTimes)
averageNumberOfErrors