require(googleVis)
require(shiny)


load("data/data.Rda")

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

