## 그림 9-14
library(googleVis)
library(rstudioapi)
options(encoding="utf-8")
x   = c(34267.8, 482774.6, 43069.7,105632.3, 1106359.9)
x_n = c("농림어업", "광공업", "전기가스수도업", "건설업", "서비스업")
dd = data.frame(x_n,x)
Pie2 = gvisPieChart(dd, options=list(is3D=TRUE, 
                                     title='2020년 생산구조(단위: %, 10억원)', width=800))
plot(Pie2, browser=rstudioapi::viewer)

# 그림 9-15
library(COVID19)
library(googleVis)
library(tidyverse)

## COVID-19 데이터 불러오기
date1 = "2022-05-31"
cov = covid19(start=date1, end=date1, verbose = FALSE) %>% 
  select(date, confirmed, deaths, vaccines, population, iso_alpha_2) %>% 
  mutate(인구대비누적확진자비율 = confirmed/population*100, 
         확진자대비사망자비율 = deaths/population*100)
 
## 그래프 그리기
G5 <- gvisGeoChart(cov, "iso_alpha_2", 
                   "인구대비누적확진자비율", 
                   "확진자대비사망자비율",
                   options=list(dataMode="regions", width=1200, height=600))
plot(G5, browser=rstudioapi::viewer)

## 그림 9-17
library(devtools)
install_github('ramnathv/rCharts') 
library(rCharts); library(reshape2)

# 데이터 불러와서 변형
gdp_s <- read.csv("./data/ch8/gdp_s.csv", header=TRUE)
colnames(gdp_s)[2:9] <- substr(colnames(gdp_s), 2, 5)[2:9]
gdp_s1 = melt(gdp_s, id="Industry")
colnames(gdp_s1)[2:3] <- c("Year", "GDP Share")
# 그래프 작성하기
hPlot(x="Industry", y="GDP Share", group="Year", type="column", data=gdp_s1) 

## 그림 9-19
library(WDI)
library(plotly)
library(tidyverse)

# 데이터 불러오기
inds = c('NY.GDP.MKTP.CD', 'NY.GDP.PCAP.CD','SP.POP.65UP.TO.ZS')
indnams = c("GDP", "gdpPercap",  "prop_pop_over65")

wdiData = WDI(country="all", indicator=inds, start=1960, end=format(Sys.Date(), "%Y"), extra=TRUE)
colnum = match(inds, names(wdiData))
names(wdiData)[colnum] = indnams

#  모션차트의 작성
WorldBank = droplevels(subset(wdiData, !region %in% "Aggregates"))

fig3 = WorldBank %>%
  plot_ly(
    x = ~prop_pop_over65, 
    y = ~gdpPercap, 
    size = ~GDP, 
    color = ~region, 
    frame = ~year, 
    text = ~country, 
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers'
  )

fig3


## 그림 9-20
library(rbokeh)
data(iris)

# 산점도의 작성
figure(data=iris, title = 'Iris Data의 산점도') %>%
  ly_points(Sepal.Length, Sepal.Width,
            color = Species, glyph = Species,
            hover = list(Sepal.Length, Sepal.Width)
  )
