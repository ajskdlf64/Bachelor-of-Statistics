# Library
library(tidyverse)

# Data Loading
Michelson_1 = scan("./Velocity/Michelson1.dat") 
Michelson_2 = scan("./Velocity/Michelson2.dat") 
Newcomb_1 = scan("./Velocity/Newcomb1.dat") 
Newcomb_2 = scan("./Velocity/Newcomb2.dat") 
Newcomb_3 = scan("./Velocity/Newcomb3.dat") 

# Data Merage
data = data.frame(group = c(rep("Michelson_1",length(Michelson_1)),
                            rep("Newcomb_1",length(Newcomb_1)),
                            rep("Newcomb_2",length(Newcomb_2)),
                            rep("Newcomb_3",length(Newcomb_3)),
                            rep("Michelson_2",length(Michelson_2))), 
                  speed = c(Michelson_1, Newcomb_1, Newcomb_2, Newcomb_3, Michelson_2))


# ggplot
myplot = data %>% ggplot(aes(x=group ,y=speed)) + 
         labs(x="", y="") +
         scale_x_discrete(limits=c("Michelson_1","Newcomb_1","Newcomb_2","Newcomb_3","Michelson_2"))

# Boxplot
myplot + geom_boxplot(aes(fill=group)) + labs(title="Boxplot")

# Dotplot
myplot + geom_dotplot(aes(fill=group),binaxis="y", stackdir="center", dotsize=0.4) + labs(title="Dotplot")

# Violinplot
myplot + geom_violin(aes(fill=group),scale="area") + geom_jitter(width=0.1) + labs(title="Viloinplot")
