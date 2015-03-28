require(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Ejemplo: Creando un mapa con Geo Chart"),
  sidebarPanel(
    selectInput("var", 
                label = "Elija una variable (en %)",
                choices = list("Desocupados","Mujeres"),
                selected = "Desocupados")
  ),
  
  mainPanel(
    h3(textOutput("year")), 
    htmlOutput("gvis")
  )
)
)
