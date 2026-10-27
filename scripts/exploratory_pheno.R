dir.create('/Users/user/Documents/Documents - Mac/PMx', recursive=TRUE)
getwd()
project_dir <- '/Users/user/Documents/nlmixr2'
folders <- c()
folders <- c("data","scripts","results","figures","reports")
dir.create(project_dir, recursive =TRUE, showWarnings= FALSE)
for (folder in folders){dir.create(file.path(project_dir,folder), showWarnings=FALSE)}
setwd(project_dir)
getwd()
list.files()
#load required packages
library(nlmixr2)
library(nlmixr2)
library(nlmixr2data)
library(ggplot2) 
#load dataset
data("pheno_sd")
head(pheno_sd)
#extract observation records
obs <- subset(pheno_sd, EVID == 0)
#summarize the dataset 
c(infants = length(unique(pheno_sd$ID)), doses = sum(pheno_sd$EVID == 1), concentrations = nrow(obs))
table ('samples per infant' = table(obs$ID))
# this means 9 infants have exactly one concentration, 40% have 2 or fewer. There are 589 doses and only 155 measurements. Relentless dosing with infrequent sampling#

library(ggplot2)
samples_per_infant <- as.data.frame(table(obs$ID))
names(samples_per_infant) <- c("ID", "n_samples")

#plot distributions of obs per infant
p1 <- ggplot(samples_per_infant, aes(x = n_samples)) + geom_bar(fill = "steelblue", color = "white") + scale_x_continuous(breaks = 1:6) + 
  labs(title = "Distribution of Concentration observations per Infant", x= "No. of conc. observations", y= "Number of Infants") +
  theme_minimal()
# Save plots
ggsave("figures/sampling_distribution.png", p1,
       width = 7, height = 5, dpi = 300)

#plot 2: Concentration over time
p2 <- ggplot(obs, aes(x = TIME, y = DV)) + geom_point(alpha = 0.7, color= "steelblue", size = 2) + labs( title = "Phenobarbital Concentrations Over Time", x= "Time", y = "Observed concentration (DV)") + theme_minimal()
print(p2)
ggsave("figures/concentration_time.png", p2, width = 7, height = 5, dpi = 300)



