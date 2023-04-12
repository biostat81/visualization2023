# 패키지 불러오기
library(readxl)
library(xts)
library(zoo)
library(reshape2)
library(scales)
library(tidyverse)

## 데이터 읽기
gdp     = read_excel("./data/ch7/GDP.xlsx")

## ts 클래스 시계열
gdp_ts  = gdp[,2:3] %>% ts(start=1960, frequency=4)
gdp_ts
plot(gdp_ts/1000, main="", xlab="")

## zoo 클래스 시계열
date_q  = seq(as.Date("1960-01-01"), as.Date("2022-01-01"), "quarter") 
gdp_zoo = zoo(gdp[,2:3], date_q)
gdp_zoo
plot(gdp_zoo/1000, screens=1, col=1:2, ylab="(조원)", xlab="")
legend("topleft", col=1:2, lty=1, c("원계열", "계절조정계열"),  bty = "n")

## autoplot
autoplot(gdp_zoo/1000, facets=NULL) + 
  theme(legend.position = "bottom") +
  labs(x="", y="(조원)") + scale_colour_hue("GDP")

## xts 클래스 시계열
date_q  = seq(as.Date("1960-01-01"), as.Date("2022-01-01"), "quarter") 
gdp_xts = xts(gdp[,2:3], date_q)
gdp_xts
plot(gdp_xts/1000, ylab="(조원)", xlab="")

## tsibble 클래스 시계열
library(tsibble); library(feasts)
gdp_tsibble = gdp_ts %>% as_tsibble()
gdp_tsibble
gdp_tsibble %>% autoplot(value/1000) + labs(x="", y="(조원)") +
  guides(color = guide_legend(title = "GDP"))

## 그림 8-8 우리나라 GDP의 추이

gdp_melt = cbind(gdp[,2:3], date_q) %>% melt(id="date_q")
gdp_melt
ggplot(gdp_melt, aes(x=date_q)) + 
  geom_line(aes(y = value/1000, colour = variable)) +
  labs(x=NULL, y="GDP (조원)") + scale_colour_hue(NULL) +
  theme(legend.position = c(0,1), legend.justification =  c(0,1), 
        legend.background = element_rect(fill='transparent'))

## 그림 8-9 종합주가지수의 선그래프

library(quantmod) 
getSymbols("^KS11",src="yahoo") 

chartSeries(KS11,name="KOSPI", theme = chartTheme("white",                              up.col='red',dn.col='blue'),subset='2020-01::2022-06')  
addSMA(n=5, col="red")
addSMA(n=20, col="blue")
addSMA(n=60, col="green")
addSMA(n=120, col="black")
addRSI()

## 그림 8-10 우리나라 COVID-19 확진자 수 추이

library(COVID19)
library(TSstudio)
cov  = covid19("KR", verbose = FALSE) 
date_d  = seq(as.Date("2020-01-01"), as.Date("2020-12-31"), "day") 
con = xts(cov[,c("confirmed", "tests")], order.by = cov$date)

ts = con[date_d,]

ts_plot(diff(ts$confirmed), title = "한국의 일별 확진자 수",
        Xtitle = NULL,  Ytitle = "확진자수")

## 그림 8-11 실질 GDP의 계절 그래프의 작성

library(forecast)
gdp = read_excel("./data/ch7/GDP.xlsx")
gdp_ts  =  gdp[,2] %>% ts(start=1960, frequency=4) %>%  
  window(start=c(2010, 1), end=c(2021, 4))

# ggseasonplot
ggseasonplot(gdp_ts/1000, year.labels = TRUE, xlab = "분기", 
             ylab = "GDP(조원)") +  ggtitle(NULL)

# ggsubseriesplot
ggsubseriesplot(gdp_ts/1000, xlab = "분기", ylab = "GDP(조원)") + 
  ggtitle(NULL)

## 그림 8-12 경기동행지수 순환변동치 추이

# 경기종합지수 데이터 불러와서 xts 객체로 만듬
cycle1 = read_excel("./data/ch7/경기종합지수.xlsx")
연도  = seq(as.Date("1970-01-01"), as.Date("2022-04-01"), "month")
cycle = xts(cycle1[,3], 연도)

# 경기 기준순환일 데이터를 가져와서 정리
refdate = read.csv("./data/ch7/refdate1.csv",header=TRUE)
yrng <- range(cycle)
datebreaks <- seq(as.Date("1970-01-01"), as.Date("2023-01-01"), "5 year")

# 그래프 그리기
p = autoplot(cycle, facets = NULL) + 
  theme(panel.background = element_rect(fill = "white", colour = "gray"),  
        legend.position = "bottom") + 
  geom_rect(aes(NULL, NULL, xmin = as.Date(start), xmax = as.Date(end), 
                fill = 경기순환), ymin = yrng[1], ymax = yrng[2], data = refdate) + 
  scale_fill_manual(values = alpha(c("yellow", "darkblue"),0.1)) + ylab(NULL) + 
  xlab(NULL) + geom_hline(yintercept=100, colour="gray") +
  geom_text(aes(x = as.Date(start), y = yrng[2], label = name1),data = refdate, 
            size = 2, hjust = 0.5, vjust = -0.5) + 
  geom_text(aes(x = as.Date(end), y = yrng[2], label = name2), data = refdate, 
            size = 2, hjust = 0.5, vjust = -0.5)
p + scale_x_date(breaks=datebreaks, labels=date_format("%Y"), expand=c(0.01,0.01)) 


## 그림 8-13 제주시 강수량의 선그래프 작성

climate = read_excel("./data/ch7/기온강수량.xlsx", sheet="강수량")
연도  = seq(as.Date("2000-01-01"), as.Date("2020-12-01"), "month")
climate_xts = xts(climate[,4], 연도)
climate_xts %>% ggplot(aes(x=연도, y=제주)) +
  geom_area(colour="black", fill="blue", alpha=.2) +
  ylab("강수량 (mm)")

## 그림 8-14 강릉시, 서울시, 제주시 기온의 선그래프

climate = read_excel("./data/ch7/기온강수량.xlsx", sheet="기온")
연도  = seq(as.Date("2000-01-01"), as.Date("2020-12-01"), "month")
climate_1 = cbind(연도, climate[,2:4]) 
climate_2 =  melt(climate_1, id="연도")
climate_2 %>% ggplot(aes(x=연도)) + facet_grid(variable~.)+
  geom_line(aes(y=value), colour="red") + theme_bw() +
  ylab(NULL) + xlab(NULL) 


