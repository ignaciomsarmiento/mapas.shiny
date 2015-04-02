require(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Montos anuales  de anuncios de inversión por provincia 2003 - 2014*(mill u$s)"),
  sidebarPanel(
    conditionalPanel(condition="input.conditionedPanels==1",
                     selectInput("year", 
                                 label = "Elija un Año",
                                 choices = list("2003"= 2003,
                                                "2004"=2004,
                                                "2005"=2005,
                                                "2006"=2006,
                                                "2007"=2007,
                                                "2008"=2008,
                                                "2009"=2009,
                                                "2010"=2010,
                                                "2011"=2011,
                                                "2012"=2012,
                                                "2013"=2013,
                                                "2014"=2014),
                                 selected = 2003)
                     
    ),
    conditionalPanel(condition="input.conditionedPanels==2",
                     selectInput("provincia", 
                                 label = "Elija una Provincia",
                                 choices = list("Autonomous City of Buenos Aires"="AR-C",
                                                "Buenos Aires"="AR-B",
                                                "Catamarca"="AR-K",
                                                "Cordoba"="AR-X",
                                                "Corrientes"="AR-W",
                                                "Chaco"="AR-H",
                                                "Chubut"="AR-U",
                                                "Entre Rios"="AR-E",
                                                "Formosa"="AR-P",
                                                "Jujuy"="AR-Y",
                                                "La Pampa"="AR-L",
                                                "La Rioja"="AR-F",
                                                "Mendoza"="AR-M",
                                                "Misiones"="AR-N",
                                                "Neuquen"="AR-Q",
                                                "Rio Negro"="AR-R",
                                                "Salta"="AR-A",
                                                "San Juan"="AR-J",
                                                "San Luis"="AR-D",
                                                "Santa Cruz"="AR-Z",
                                                "Santa Fe"="AR-S",
                                                "Santiago del Estero"="AR-G",
                                                "Tucuman"="AR-T",
                                                "Tierra del Fuego"="AR-V",
                                                "Malvinas"="FK"),
                                 selected = "AR-C")
     
    
    )
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Mapas de Inversión", h4("Mapas de Inversión"), htmlOutput("gvis"), value=1),
      tabPanel("Evolución Inversión por Provincia", h4("Evolución Inversión por Provincia"), htmlOutput("bar"), value=2),
      id="conditionedPanels"
    )
)
))
