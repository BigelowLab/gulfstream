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
          radioButtons("rbUSN", "Choose one:",
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

  #wallUSN = reactive(input$rbUSN)
  #weekUSN = reactive(input$sliderUSN)
  
  # optsUSN = reactive({
  #   req(input$rbUSN)
  #   req(input$sliderUSN)
  #   list(wallUSN = input$rbUSN,
  #        weekUSN = input$sliderUSN)
  # })
  
  output$mapUSN = renderLeaflet({
    bb = gulfstream_bb("usn", form = "numeric")
    leaflet::leaflet(data = bb) |>
      leaflet::addProviderTiles("Esri.OceanBasemap",
                                options = leaflet::providerTileOptions(variant = "Ocean/World_Ocean_Base")) |>
      leaflet::fitBounds(bb[1], bb[2], bb[3], bb[4])
  })
  
  observeEvent(input$rbUSN,
    {
      req(input$weekUSN)
      leafletProxy("mapUSN") |>
        clearShapes() |>
        clearControls() |>
        add_usn_layer(x = usn, 
                      wall = input$rbUSN, 
                      iweek = isolate(input$weekUSN))
    })
  
  observeEvent(input$weekUSN,
    {
      leafletProxy("mapUSN") |>
        clearShapes() |>
        clearControls() |>
        add_usn_layer(x = usn, 
                      wall = isolate(input$rbUSN), 
                      iweek = input$weekUSN)
    })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
