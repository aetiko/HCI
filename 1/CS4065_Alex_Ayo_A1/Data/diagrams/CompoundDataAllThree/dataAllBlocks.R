# Compound data for all data
 dataBlocks = read.csv("data.csv")
 View(dataBlocks)
 
 # barchart for completion time

barplot(dataBlocks$Average.Completion.Times.ms, names.arg = c("2 Targets", "4 Targets", "8 Targets"), col = c("black", "blue", "red"), ylim = c(0,1000), 
        xlab = "Number of Targets", ylab = "Average Completion Time", main = "All Data Blocks Average Completion Time")

barplot(dataBlocks$Average.number.of.Errors, names.arg = c("2 Targets", "4 Targets", "8 Targets"), col = c("black", "blue", "red"), ylim = c(0,0.1), 
        xlab = "Number of Targets", ylab = "Average Errors ", main = "All Data Blocks Average Errors")