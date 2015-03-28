require(googleVis)
require(shiny)
## Prepare data to be displayed
## Load presidential election data by state from 1932 - 2012
library(RCurl)
# url <- "https://raw.githubusercontent.com/mages/diesunddas/master/Data/US%20Presidential%20Elections.csv"
# dat <- getURL(url, ssl.verifypeer=0L, followlocation=1L)
# dat <- read.csv(text=dat)
dat<-read.csv("/Users/IKI/Dropbox/Phd\ Illinois/Work\ with\ Pedro/Shiny/census-app/data/data.csv")
dat<-dat[,-3]
names(dat)<-c("province","Desocupados","Mujeres", "Criteria.ID",	"Name","Name_orig",	"Canonical Name",	"Parent ID", 	"Country Code",	"Target Type",	"Status")
dat<-data.frame(dat)


shinyServer(function(input, output) {
  
  output$gvis <- renderGvis({
    gvisGeoChart(dat, locationvar="Name", input$var, options=list(region="AR", displayMode="region", resolution="provinces", width=600, height=400))  
  })
})