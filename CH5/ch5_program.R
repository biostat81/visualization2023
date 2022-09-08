### Program 5-1
setwd("C:\\Users\\KNOU_stat\\Dropbox\\KNOU_강의개편\\데이터시각화\\R_in_manuscript")
load("sah.RData")
library(ggplot2)
ggplot(sah, aes(age, ldl)) + geom_point()
ggplot(sah, aes(age, ldl)) + geom_point(shape=1)
ggplot(sah, aes(age, ldl)) + geom_point(size=1, color="forestgreen")

### Program 5-2
ggplot(sah, aes(age, ldl, color=famhist)) + geom_point()
ggplot(sah, aes(age, ldl, color=famhist)) + geom_point(shape=1, size=2)
ggplot(sah, aes(age, ldl, shape=famhist)) + geom_point()
ggplot(sah, aes(age, ldl, shape=famhist)) + geom_point() + 
  scale_shape_manual(values=c(1, 4))

### Program 5-3
ggplot(Loblolly, aes(age, height)) + geom_point()
ggplot(Loblolly, aes(age, height)) + geom_jitter()
ggplot(Loblolly, aes(age, height)) + geom_jitter(width=0.5, height=0)

### Program 5-4
ggplot(sah, aes(age, ldl)) + geom_point() + geom_smooth(method=lm)
ggplot(sah, aes(age, ldl)) + geom_point() + geom_smooth(method=lm, level=0.99)
ggplot(sah, aes(age, ldl)) + geom_point() + 
  geom_smooth(method=lm, se=FALSE, color="red")


### Program 5-5
plot(iris[, 1:4])
library(GGally)
ggpairs(iris[, 1:4])


### Program 5-6
library(dplyr)
sah2<-sah %>% group_by(BMI.cat) %>%
              summarise(mean.ldl=mean(ldl))
ggplot(sah2, aes(BMI.cat, mean.ldl)) + geom_col()

### Program 5-7
ggplot(sah2, aes(BMI.cat, mean.ldl)) + geom_col(width=0.5)
ggplot(sah2, aes(BMI.cat, mean.ldl)) + geom_col(width=1)
ggplot(sah2, aes(BMI.cat, mean.ldl)) + geom_col() + 
  geom_text(aes(label=round(mean.ldl, 2)), vjust=-0.2)

### Program 5-8
sah3<-sah %>% group_by(BMI.cat, chd) %>%
  summarise(mean.ldl=mean(ldl))
ggplot(sah3, aes(BMI.cat, mean.ldl, fill=chd)) + geom_col(position="dodge")

### Program 5-9
ggplot(sah, aes(x=BMI.cat)) + geom_bar()
ggplot(sah, aes(x=BMI.cat)) + geom_bar(width=0.7) + 
  geom_text(aes(label = ..count..), stat = "count", vjust = 1.5, color = "white")
ggplot(sah, aes(x=BMI.cat)) + geom_bar(aes(y=..count../sum(..count..)) ) +
  ylab("Percent") + scale_y_continuous(labels=scales::percent)
ggplot(sah, aes(x=BMI.cat)) + geom_bar(aes(y=..count../sum(..count..)*100) ) +
  ylab("Percent(%)")


### Program 5-10
ggplot(sah, aes(x=BMI.cat, fill=chd)) + geom_bar()
### Program 5-11
ggplot(sah, aes(x=BMI.cat, fill=chd)) + geom_bar(position="fill") +
  ylab("Percent") + scale_y_continuous(labels=scales::percent)

### Program 5-12
ggplot(sah, aes(x=sbp)) + geom_histogram()
ggplot(sah, aes(x=sbp)) + geom_histogram(fill="skyblue", color="black")

### Program 5-13
ggplot(sah, aes(x=sbp)) + 
  geom_histogram(fill="skyblue", color="black", binwidth = 20)
ggplot(sah, aes(x=sbp)) + 
  geom_histogram(fill="skyblue", color="black", binwidth = 20, boundary=120)
ggplot(sah, aes(x=sbp)) + 
  geom_histogram(fill="skyblue", color="black", breaks=seq(100, 220, 10))

### Program 5-14
ggplot(sah, aes(x=sbp, fill=chd)) + geom_histogram(position="identity", alpha=0.5)

### Program 5-15
ggplot(sah, aes(x=sbp)) + geom_density()
ggplot(sah, aes(x=sbp)) + geom_density(adjust=0.2)
ggplot(sah, aes(x=sbp)) + geom_density(adjust=3)

### Program 5-16
ggplot(sah, aes(x=sbp, color=chd)) + geom_density(key_glyph=draw_key_path)

### Program 5-17
ggplot(sah, aes(chd, sbp)) + geom_boxplot()
ggplot(sah, aes(chd, sbp)) + geom_boxplot(width=0.5, outlier.size=3, outlier.shape=4)

### Program 5-18
ggplot(Loblolly, aes(age, height)) + geom_boxplot() + xlab("age")  ### graph shown not as intended
ggplot(Loblolly, aes(as.factor(age), height)) + geom_boxplot() + xlab("age")

### Program 5-19
ggplot(sah, aes(1, sbp)) + geom_boxplot()  + 
  scale_x_continuous(breaks = NULL) +
  theme(axis.title.x = element_blank())

### Program 5-20
ggplot(sah, aes(chd, sbp)) + geom_violin()


### Program 5-21
ggplot(BOD, aes(Time, demand)) + geom_line()
ggplot(BOD, aes(Time, demand)) + geom_line(linetype="dashed", size=2, color="forestgreen")
ggplot(BOD, aes(Time, demand)) + geom_line() + geom_point()

### Program 5-22
ggplot(BOD, aes(Time, demand)) + geom_area()
ggplot(BOD, aes(Time, demand)) + geom_area(color="black", fill="skyblue", alpha=0.3)

### Program 5-23
ggplot(Orange, aes(age, circumference, group=Tree)) + 
  geom_line() 

### Program 5-24
ggplot(Orange, aes(age, circumference, color=Tree)) + 
  geom_line() 
ggplot(Orange, aes(age, circumference, color=Tree)) + 
  geom_line() + scale_color_discrete(limits=c("1", "2", "3", "4", "5"))

### Program 5-25
ggplot(sah, aes(x=1, fill=BMI.cat)) + geom_bar() + coord_polar("y") + theme_void()

### Program 5-26
vote<-data.frame(response=c("BLACKPINK", "TWICE", "RED VELVET", "Other"), perc=c(45, 23, 21, 11))
ggplot(vote)+geom_col(aes(x="", y=perc, fill=response))+
  coord_polar(theta="y")+
  theme_void()


### Program 5-27
f<-ggplot(sah, aes(age, ldl)) + geom_point()
f + annotate("text", x=50, y=15, label="ID 17") 
f + annotate("text", x=c(50, 57), y=c(15, 13.8), label=c("ID 17", "ID 414")) 

### Program 5-28
f + annotate("rect", xmin=30, xmax=40, ymin=6, ymax=12, alpha=0.3, fill="skyblue")
f + annotate("rect", xmin=60, xmax=Inf, ymin=-Inf, ymax=Inf, alpha=0.3, fill="skyblue")

### Program 5-29
f + geom_vline(xintercept=60)
f + geom_hline(yintercept=13, linetype="dashed", color="red")
f + geom_vline(xintercept=50) + geom_hline(yintercept=10)
f + geom_abline(intercept=3, slope=0.05)

