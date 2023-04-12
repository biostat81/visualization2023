# 패키지 불러오기
library(readxl)
library(xts)
library(zoo)
library(reshape2)
library(scales)
library(tidyverse)
#detach("package:tsibble", unload = TRUE)

## 그림 8-16 우리나라 경상수지의 추이

cb = read_excel("./data/ch7/경상수지.xlsx")
cb$경상수지 = cb$경상수지/100
cb$pos = ifelse(cb$경상수지 >0, "흑자", "적자")
연도  = seq(as.Date("1980-01-01"), as.Date("2021-01-01"), "year")
cb_xts = xts(cb, 연도) 
cb_xts

ggplot(cb, aes(x=연도, y=경상수지, fill=pos)) + 
  geom_bar(stat="identity", position="identity", colour="black", size=0.25) +
  scale_fill_manual(values=c("red", "darkgray")) + 
  ylab("경상수지 (억달러)") + 
  theme(panel.background = element_rect(fill = "white", colour = "gray"), 
        legend.position = "bottom") +
  guides(fill = guide_legend(title = "경상수지"))


## 그림 8-18 연령대별 우리나라 인구 추이

library(ggstream)

pop_age = read_excel("./data/ch7/연령별_추계인구.xlsx")
head(pop_age)
pop_age_1 = pop_age[,1:10] %>% melt(id="시점")
head(pop_age_1)

# 연령대별 누적 그래프
ggplot(pop_age_1, aes(x = 시점, y = value/10000, fill = variable)) + 
  geom_stream(type = "ridge", color = 1, lwd = 0.25) +
  scale_fill_brewer(palette="Blues") + ylab("인구(만 명)") + xlab(NULL) +
  scale_x_continuous(breaks=seq(1960, 2070, 10), expand = c(0,0)) +
  guides(fill = guide_legend(title = "연령대"))

# 연령대별 구성비 그래프
ggplot(pop_age_1, aes(x = 시점, y = value, fill = variable)) + 
  geom_stream(type = "proportional", color = 1, lwd = 0.25) +
  scale_fill_brewer(palette="Blues") + ylab("인구비중") + xlab(NULL) +
  scale_x_continuous(breaks=seq(1960, 2070, 10), expand = c(0,0)) +
  guides(fill = guide_legend(title = "연령대"))

## 그림 8-19 우리나라 산업구조의 추이

gdp_s1 = read_excel("./data/ch7/경제활동별_GDP.xlsx")
# 데이터 불러온 후 재정렬
gdp_s = gdp_s1[1+1:6*10, 1:7] %>% melt(id="시점")
names(gdp_s) = c("연도", "산업", "비중")
# 그래프 그리기
ggplot(gdp_s, aes(x=연도, y=비중, fill=산업))+
  geom_bar(stat="identity", position='fill')+
  scale_x_continuous(breaks=seq(1970, 2020, 10), expand = c(0,0)) +
  theme(panel.background = element_rect(fill = "white", colour = "gray"),
        legend.position="bottom") + ylab("비중") + xlab(NULL)

## 그림 8-21 우리나라 제조업의 재고출하순환도

# 데이터 불러오기
inven1 = read_excel("./data/ch7/재고출하지수.xlsx")
연도   = seq(as.Date("2000-01-01"), as.Date("2022-04-01"), "month")
inven  = xts(inven1[,4:5],연도)
# 일정기간 데이터 찾기
inven_1 = inven[index(inven) > as.Date('2020-03-01')]
# 그래프 그리기
ggplot(inven_1, aes(x=출하지수증감률, y=재고지수증감률)) + 
  theme_bw() + geom_path() + 
  geom_point() + ylim(-10,15)+xlim(-10,15) +
  geom_text(aes(label=substr(index(inven_1),3,7)), size=3, 
            hjust=-0.2, vjust=-0.3, colour="blue") +
  geom_abline(intercept = 0, slope=1, colour="red") +
  geom_hline(yintercept=0, colour="gray")+ 
  geom_vline(xintercept=0, colour="gray")


## 그림 8-22 채색달력 그래프

library(quantmod) 
library(plyr)

# 야후 파이낸스 데이터베이스에서 가져오기
getSymbols("^KS11",src="yahoo", from='2019-01-01')
KS11$주가변동 = abs(diff(KS11$KS11.Close)/lag.xts(KS11$KS11.Close)) *100
dat = data.frame(date=index(KS11),KS11)
dat$year = as.numeric(as.POSIXlt(dat$date)$year+1900)
dat$month = as.numeric(as.POSIXlt(dat$date)$mon+1)
dat$monthf =factor(dat$month,levels=as.character(1:12),labels=c("1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"),ordered=TRUE)
dat$weekday = as.POSIXlt(dat$date)$wday
dat$weekdayf = factor(dat$weekday,levels=rev(1:7),labels=rev(c("월","화","수","목","금","토","일")),ordered=TRUE)
dat$yearmonth = as.yearmon(dat$date)
dat$yearmonthf = factor(dat$yearmonth)
dat$week = as.numeric(format(dat$date,"%W"))
dat = ddply(dat,.(yearmonthf),transform,monthweek=1+week-min(week))

# 그래프 그리기
ggplot(dat, aes(monthweek, weekdayf, fill = 주가변동)) + 
  geom_tile(colour = "white") + facet_grid(year~monthf) + 
  scale_fill_gradient(limits=c(0, 12), low="lightgray", high="darkred") +
  xlab("") + ylab("") + 
  theme(panel.background = element_rect(fill = "white", colour = "gray"))

