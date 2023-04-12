---
title: "금융상황판"
output: 
  flexdashboard::flex_dashboard:
    orientation: rows
    vertical_layout: fill
---

```{r setup, include=FALSE}
library(flexdashboard)
library(dygraphs)
library(quantmod)

## 환율
kor_ex_xts = getSymbols(Symbols="KRW=X", 
                         from= "2010-01-01", 
                         to = Sys.Date(), auto.assign = FALSE)[,4]
names(kor_ex_xts) = "원"

yen_xts = getSymbols(Symbols="JPY=X", 
                         from= "2010-01-01", 
                         to = Sys.Date(), auto.assign = FALSE)[,4]

names(yen_xts) = "엔"

euro_xts = getSymbols(Symbols="EUR=X", 
                         from= "2010-01-01", 
                         to = Sys.Date(), auto.assign = FALSE)[,4]
names(euro_xts) = "유로"

## 주가지수

kospi_xts = getSymbols(Symbols="^KS11", 
                         from= "2010-01-01", 
                         to = Sys.Date(), auto.assign = FALSE)[,4]
names(kospi_xts) = "KOSPI"

sp500_xts = getSymbols(Symbols="^GSPC", 
                         from= "2010-01-01", 
                         to = Sys.Date(), auto.assign = FALSE)[,4]

names(sp500_xts) = "S&P500"

ftse_xts = getSymbols(Symbols="^FTSE", 
                         from= "2010-01-01", 
                         to = Sys.Date(), auto.assign = FALSE)[,4]
names(ftse_xts) = "FTSE 100"

```
외환 {data-icon="fa-signal"}
===================================== 
Row
-----------------------------------------------------------------------

### 원/달러 환율

```{r}
ex1 = as.integer(tail(kor_ex_xts,1))
valueBox(ex1, icon = "fa-dollar-sign", caption = paste("원/달러 환율 : ", index(tail(kor_ex_xts,1))))
```

### 엔/달러 환율

```{r}
ex2 = as.integer(tail(yen_xts,1))
valueBox(ex2, icon = "fa-yen-sign", color="red", caption = paste("엔/달러 환율 : ", index(tail(yen_xts,1))))
```

### 유로/달러 환율

```{r}
ex3 = as.integer(tail(euro_xts,1)*100)/100
valueBox(ex3, icon = "fa-euro-sign", color="green", caption = paste("유로/달러 환율 : ", index(tail(euro_xts,1))))
```

Column {data-width=650}
-----------------------------------------------------------------------

### 원/달러 환율

```{r}
aa1 = dygraph(kor_ex_xts)
dyRangeSelector(aa1)
```

Column {data-width=350}
-----------------------------------------------------------------------

### 엔/달러 환율

```{r}
yy2 = dygraph(yen_xts)
dyRangeSelector(yy2)
```

### 유로/달러 환율

```{r}
ee3 = dygraph(euro_xts)
dyRangeSelector(ee3)
```

주가지수 {data-icon="fa-chart-line"}
===================================== 
Row
-----------------------------------------------------------------------

### KOSPI

```{r}
ss1 = as.integer(tail(kospi_xts,1))
valueBox(ss1, icon = "fa-chart-line", caption = paste("한국 KOSPI : ", index(tail(kospi_xts,1))))
```

### S&P 500

```{r}
ss2 = as.integer(tail(sp500_xts,1))
valueBox(ss2, icon = "fa-chart-bar", color="red", caption = paste("S&P 500 : ", index(tail(sp500_xts,1))))
```

### FTSE

```{r}
ss3 = as.integer(tail(ftse_xts,1))
valueBox(ss3, icon = "fa-chart-area", color="green", caption = paste("FTSE 100 : ", index(tail(ftse_xts,1))))
```

Column {data-width=650}
-----------------------------------------------------------------------

### KOSPI

```{r}
qq1 = dygraph(kospi_xts)
dyRangeSelector(qq1)
```

Row {.tabset .tabset-fade}
-----------------------------------------------------------------------

### S&P 500

```{r}
qq2 = dygraph(sp500_xts)
dyRangeSelector(qq2)
```

### FTSE 100

```{r}
qq3 = dygraph(ftse_xts)
dyRangeSelector(qq3)
```
