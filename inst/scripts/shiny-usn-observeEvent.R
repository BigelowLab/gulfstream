suppressPackageStartupMessages({
  library(gulfstream)
  library(shiny)
  library(lubridate)
  library(ggplot2)
  library(leaflet)
  library(sf)
})

usn = read_usn() |>
  dplyr::mutate(Date = format(date, "%Y-%m-%d"),
                week = lubridate::week(date))

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("USN"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("wallUSN", "Choose one:",
                   choiceNames = c("north wall", 
                                   "south wall"),
                   choiceValues = list("north", "south")),
      sliderInput("weekUSN",
                  "Week of year:",
                  min = 1,
                  max = 52,
                  value = lubridate::week(Sys.Date()), 
                  step = 1)
    ),
    mainPanel(
      leafletOutput("mapUSN")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$mapUSN = renderLeaflet({
    bb = gulfstream_bb("usn", form = "numeric")
    leaflet::leaflet(data = bb) |>
      leaflet::addProviderTiles("Esri.OceanBasemap",
                                options = leaflet::providerTileOptions(variant = "Ocean/World_Ocean_Base")) |>
      leaflet::fitBounds(bb[1], bb[2], bb[3], bb[4])
  })
  
  optsUSN = reactive({
    list(input$wallUSN,input$weekUSN)
  })
  
  observeEvent(optsUSN(),
               {
                 #req(input$weekUSN)
                 leafletProxy("mapUSN") |>
                   clearShapes() |>
                   clearControls() |>
                   gulfstream::add_usn_layer(x = usn, 
                                 wall = input$wallUSN, 
                                 iweek = input$weekUSN)
               })
  
  # observeEvent(input$wallUSN,
  #              {
  #                req(input$weekUSN)
  #                leafletProxy("mapUSN") |>
  #                  clearShapes() |>
  #                  clearControls() |>
  #                  gulfstream::add_usn_layer(x = usn, 
  #                                wall = input$wallUSN, 
  #                                iweek = isolate(input$weekUSN))
  #              })
  # 
  # observeEvent(input$weekUSN,
  #              {
  #                leafletProxy("mapUSN") |>
  #                  clearShapes() |>
  #                  clearControls() |>
  #                  gulfstream::add_usn_layer(x = usn, 
  #                                wall = isolate(input$wallUSN), 
  #                                iweek = input$weekUSN)
  #              })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
