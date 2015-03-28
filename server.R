require(googleVis)
require(shiny)

library(RCurl)

dat<-read.csv("data/data.csv")
dat<-dat[,-3]
names(dat)<-c("province","Desocupados","Mujeres", "Criteria.ID",	"Name","Name_orig",	"Canonical Name",	"Parent ID", 	"Country Code",	"Target Type",	"Status")
dat<-data.frame(dat)


shinyServer(function(input, output) {
  
  output$gvis <- renderGvis({
    gvisGeoChart(dat, locationvar="Name", input$var, options=list(region="AR", displayMode="region", resolution="provinces", width=600, height=400))  
  })
})