require(googleVis)
require(shiny)

library(RCurl)

dat<-read.csv("data/data.csv")
dat<-dat[,-3]
names(dat)<-c("province","Desocupados","Mujeres", "Criteria.ID",	"Code","Name", "Name_orig",	"Canonical Name",	"Parent ID", 	"Country Code",	"Target Type",	"Status")
dat<-data.frame(dat)


shinyServer(function(input, output) {
  
  output$gvis <- renderGvis({
    gvisGeoChart(dat, locationvar="Code", input$var, hovervar="Name", options=list(region="AR", displayMode="region", resolution="provinces", width=600, height=400,  colorAxis="{colors:['#FFFFFF', '#0000FF']}"))  
  })
})