library(shiny)
library(ClusterR)
library(cluster)

names(iris) = c("꽃잎 길이", "꽃잎 폭", "꽃받침 길이", "꽃받침 폭")

# UI 정의

ui = fluidPage(
    # 앱의 이름
    titlePanel("붓꽃 k-means 군집화"),
    # Sidebar의 지정 : X변수, Y변수, 군집수
    sidebarLayout(
        sidebarPanel(
          selectInput('xcol', 'X 변수', names(iris)[1:4]),
          selectInput('ycol', 'Y 변수', names(iris)[1:4],
                      selected=names(iris)[[2]]),
          numericInput('clusters', '군집 수', 3,
                       min = 1, max = 5)
        ),
        # 산점도를 보여주기
        mainPanel(
          plotOutput('plot1')
        )
    )
)

# Server 프로그램 작성
server = function(input, output) {
  palette(rainbow(9))
  # 변수의 선택
  selectedData = reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  # K-means방법에 의한 군집화
  clusters = reactive({
    kmeans(selectedData(), input$clusters)
  })
  # 산점도 작성
  output$plot1 = renderPlot({
    clusplot(selectedData(),
             clusters()$cluster,
             lines = 0,
             shade = TRUE,
             color = TRUE,
             labels = 4, 
             plotchar = FALSE, 
             span = TRUE, cex.txt=2,
             main = paste("군집수 : ", input$clusters), sub ="",
             xlab = names(selectedData())[1],
             ylab = names(selectedData())[2])
    
  })
    
}

# 앱의 수행
shinyApp(ui = ui, server = server)
