### Program 4-1
library(scales)
show_col(c("red"))
show_col(c("red", "orange", "yellow", "green"))

### Program 4-2
show_col(c("#FF0000", "#FFFF00", "#00FF00", 
           "#FF00FF", "#FFFFFF", "#00FFFF", 
           "#0000FF", "#000000", "#0000FF"))

### Program 4-3
rgb(1, 0, 0)
show_col(c(rgb(0, 0, 1), rgb(0, 0, 0.5), rgb(0, 0, 0.3), rgb(0, 0, 0)))

### Program 4-4
show_col(1:9)

### Text
rainbow(10)

### Program 4-5
show_col(rainbow(10), ncol=1, cex_label = 0.7, border = NA)
show_col(heat.colors(10), ncol=1, cex_label = 0.7, border = NA)
show_col(topo.colors(10), ncol=1, cex_label = 0.7, border = NA)

### Program 4-6
library(RColorBrewer)
display.brewer.all()

### Program 4-7
brewer.pal(7, "RdBu")
display.brewer.pal(7, "RdBu")

### Program 4-8
library(scico)
scico_palette_show()

### Program 4-9
scico(7, palette = "acton")
show_col(scico(7, palette = "acton"))

### Program 4-10
setwd("C:\\Users\\KNOU_stat\\Dropbox\\KNOU_강의개편\\데이터시각화\\R_in_manuscript")
load("sah.RData")
library(ggplot2)
ggplot(sah, aes(age, ldl, color=BMI.cat)) + geom_point() 

### Program 4-11
ggplot(sah, aes(age, ldl, color=BMI.cat)) + geom_point() +
  scale_color_manual(values=c("tomato", "orange", "skyblue", "forestgreen"))
ggplot(sah, aes(age, ldl, color=BMI.cat)) + geom_point() +
  scale_color_manual(values=c("underweight"="tomato1", "normal"="tomato2", 
                              "overweight"="tomato3", "obese"="tomato4"))

### Program 4-12
ggplot(sah, aes(age, ldl, color=BMI.cat)) + geom_point() +
  scale_color_brewer(palette="Set2")


### Program 4-13
ggplot(sah, aes(BMI.cat)) + geom_bar()
ggplot(sah, aes(BMI.cat, fill=BMI.cat)) + geom_bar()
ggplot(sah, aes(BMI.cat, fill=BMI.cat)) + geom_bar() + 
  scale_fill_manual(values=c("tomato", "orange", "skyblue", "forestgreen"))
ggplot(sah, aes(BMI.cat, fill=BMI.cat)) + geom_bar() + 
  scale_fill_manual(values=c("#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3"))
ggplot(sah, aes(BMI.cat, fill=BMI.cat)) + geom_bar() + 
  scale_fill_brewer(palette="Blues")

### Program 4-14
e<-ggplot(sah, aes(age, ldl, color=obesity)) + geom_point() 
e

### Program 4-15
e + scale_color_gradient(low="yellow", high="red")

### Program 4-16
e + scale_color_viridis_c()
e + scale_color_viridis_c(option="A")
e + scale_color_viridis_c(option="E")

### Program 4-17
e + scale_color_distiller(palette="Purples")
e + scale_color_scico(palette="vik")

### Program 4-18
e + guides(color=guide_colorbar(reverse = TRUE))
e + theme(legend.position = "bottom") +
  guides(color=guide_colorbar(direction="horizontal"))

### Program 4-19
ggplot(sah, aes(age, ldl, color=BMI.cat)) + geom_point(color="dodgerblue3") 
ggplot(sah, aes(BMI.cat)) + geom_bar(fill="dodgerblue3")
ggplot(sah) + geom_bar(aes(BMI.cat), fill="dodgerblue3")
ggplot(sah) + geom_bar(aes(BMI.cat, fill="dodgerblue3"))



