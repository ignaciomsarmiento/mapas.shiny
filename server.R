require(googleVis)
require(shiny)
require(xlsx)
library(RCurl)
dat<-read.xlsx("data/Inversion.xlsx",sheetName = "Inversion", header=TRUE)
dat<-dat[,c(-3,-4,-17,-18,-19)]

names(dat)<-c("Code","Name","y.2003","y.2004","y.2005", "y.2006","y.2007","y.2008","y.2009","y.2010","y.2011","y.2012","y.2013","y.2014") 

dat<-reshape(dat, varying=3:14, direction="long")
dat<-data.frame(dat)
names(dat)<-c("Code","Name","Year","Inversion","id")


shinyServer(function(input, output) {
  data<-reactive({
    a <- subset(dat, Year==input$year)
    a<-droplevels(a)
    return(a)
  })
  
  output$gvis <- renderGvis({
    gvisGeoChart(data(), locationvar="Code", colorvar="Inversion", hovervar="Name", options=list(region="AR", displayMode="region", resolution="provinces", width=600, height=400,  colorAxis="{colors:['#FFFFFF', '#0000FF']}"))  
  })
  
  data<-reactive({
    a <- subset(dat, Year==input$year)
    a<-droplevels(a)
    return(a)
  })
  
  output$gvis <- renderGvis({
    gvisGeoChart(data(), locationvar="Code", colorvar="Inversion", hovervar="Name", options=list(region="AR", displayMode="region", resolution="provinces", width=600, height=400,  colorAxis="{colors:['#FFFFFF', '#0000FF']}"))  
  })
  
  
  data2<-reactive({
    a <- subset(dat, Code==input$provincia)
    a<-droplevels(a)
    return(a)
  })
  
  output$bar <- renderGvis({  
    gvisColumnChart(data2(), xvar="Year", yvar="Inversion", options=list(hAxis="{title: 'Año', format: '#,###'}", vAxis="{title:'Montos anuales de anuncios de inversión'}",width=600, height=400,  colorAxis="{colors:['#FFFFFF', '#0000FF']}"))
  })
  
  
  data3<-reactive({
    a <- subset(dat, Code %in% input$provincia2)
    g<-factor(unique(a$Code))
    c<-split(a,g)
    d <- data.frame(do.call("cbind", c))
    x<-seq(4,length(names(d)),by=5)
    d<-d[,c(3,x)]
    z<-as.character(unique(a$Name))
    names(d)<-c("Year",z)
    return(d)
  })
  
  
  output$line <- renderGvis({  
    gvisLineChart(data3(), xvar=colnames(data3())[1], yvar=colnames(data3())[-1], options=list(hAxis="{title: 'Año', format: '#,###'}", vAxis="{title:'Montos anuales de anuncios de inversión'}",width=600, height=400,  colorAxis="{colors:['#FFFFFF', '#0000FF']}"))
  })

})

