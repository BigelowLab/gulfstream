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

  output$mapUSN = renderLeaflet({
    bb = gulfstream::gulfstream_bb("usn", form = "numeric")
    leaflet::leaflet(data = bb) |>
      leaflet::addProviderTiles("Esri.OceanBasemap",
                                options = leaflet::providerTileOptions(variant = "Ocean/World_Ocean_Base")) |>
      leaflet::fitBounds(bb[1], bb[2], bb[3], bb[4])
  })
  
  optsUSN = reactive({
    req(input$rbUSN)
    req(input$weekUSN)
    list(wall = input$rbUSN, week = input$weekUSN)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
