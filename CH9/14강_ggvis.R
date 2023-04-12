library(ggvis)
library(tidyverse)
library(readxl)
library(zoo)
library(lubridate)

## 전년대비 성장률의 분포

gdp = read_excel("./data/ch8/GDP_GR.xlsx")
연도   = seq(as.Date("1960-01-01"), as.Date("2022-01-01"), "3 months")
gdp_gr = cbind(연도, gdp[,4:5]) %>% filter(year(연도)>2000 )
gdp_gr %>% ggvis(~연도) %>%
  layer_lines(y=~전년동기대비,  opacity := input_slider(0, 1, 
                                                  label="전년동기대비")) %>% 
  layer_lines(y=~전기대비, stroke := input_select(
    c("Red" = "red", "Blue" = "blue", "Green" = "green"), 
    label = "전기대비 색")) %>%
  add_axis("x", title = "") %>%
  add_axis("y", title = "증감률") 

## 전년대비 성장률의 분포

gdp = read_excel("./data/ch8/GDP_GR.xlsx")
gdp_sa_gr  =  na.omit(gdp[,5])
names(gdp_sa_gr) = "전기대비성장률"

gdp_sa_gr %>% ggvis(~전기대비성장률) %>% 
  layer_densities(
    adjust = input_slider(.1, 5, value = 2, step = .1, label = 
                            "Bandwidth adjustment"),
    kernel = input_select( c("Gaussian" = "gaussian",
                             "Epanechnikov"="epanechnikov", "Rectangular" = "rectangular",
                             "Triangular" = "triangular", "Biweight" = "biweight",
                             "Cosine" = "cosine", "Optcosine" = "optcosine"), 
                           label = "Kernel"))
