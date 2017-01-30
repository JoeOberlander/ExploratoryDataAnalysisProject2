if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatch  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subNEISCC <- NEISCC[coalMatch, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subNEISCC, sum)

png("plot4.png", width=640, height=480)
gp <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
gp <- gp + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from Coal Sources: 1999 to 2008')
print(gp)
dev.off()