suppressPackageStartupMessages({
  library(gulfstream)
  library(shiny)
  library(ggplot2)
  library(leaflet)
})

# pre-load the data for ease
gsi = read_gsi()
gsgi = read_gsgi()
usn = read_usn()
patch = read_patch_month()
amoc = read_moc_transports()
heat = read_rapid_mocha()

# Define UI for application that tabs
#  GIS radio buttons and a plot
#  GSGI radio buttons and a plot
#  AMOC a plot
#  HEAT a plot
#  USN draws basemap with gs tracks superimposed
#  PATCH radio buttons and a plot and a static map
ui <- navbarPage(
  
  "Gulf Stream",   
  
  tabPanel("GSI", 
           fluidRow(
             uiOutput("textGSI"),
             radioButtons("rbGSI", "Choose one:",
                          choiceNames = c("time-series", 
                                          "monthly-boxplot", 
                                          "yearly-boxplot"),
                          choiceValues = list("time-series", "month", "year"))),
           plotOutput("plotGSI"),
           downloadButton("downloadGSI")),
  
  tabPanel("GSGI", fluidRow(
    uiOutput("textGSGI"),
    radioButtons("rbGSGI", "Choose one:",
                 choiceNames = c("time-series", 
                                 "monthly-boxplot", 
                                 "yearly-boxplot"),
                 choiceValues = list("time-series", "month", "year"))),
    plotOutput("plotGSGI"),
    downloadButton("downloadGSGI")),
  
  tabPanel("USN",  fluidRow(
    uiOutput("textUSN"),
    radioButtons("rbUSNwall", "Choose one:",
                 choiceNames = c("north wall", 
                                 "south wall"),
                 choiceValues = list("north", "south"))),
    sliderInput("sliderUSN", "select week of year",
                min = 1, 
                max = 52, 
                value = lubridate::week(Sys.Date()), 
                step = 1),
    leafletOutput("mapUSN")),
  tabPanel("AMOC", plotOutput("plotAMOC")),
  tabPanel("RAPID", plotOutput("plotRAPID")),
  tabPanel("Patch", plotOutput("plotPatch")) )


# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  # GSI
  gsi_uri <- a("ecodata R package", href="https://noaa-edab.github.io/tech-doc/index.html")
  output$textGSI <- renderUI({
    tagList("The Gulf Stream Index (gsi) provides a latitudinal positional index of the north wall. Data are provided via the", 
            gsi_uri)
  })

  byGSI = reactive(input$rbGSI)
  output$plotGSI = renderPlot({
    plot(gsi, by = byGSI())
  })
  output$downloadGSI <- downloadHandler(
    filename = function() {
      paste0("gsi_", byGSI(), ".png")
    },
    content = function(file) {
      ggsave(file)
    }
  ) 
  
  #GSGI
  uri_gsgi <- a("GSGI data as matlab", href="https://www2.whoi.edu/staff/ykwon/data/")
  output$textGSGI <- renderUI({
    tagList("The Gulf Stream Gradient Index (gsgi) provides a large-scale sea-surface temperature gradient index. Data are provided via ", 
            uri_gsgi)
  })
  byGSGI = reactive(input$rbGSGI)
  output$plotGSGI = renderPlot({
    plot(gsgi, by = byGSGI())
  })
  output$downloadGSGI <- downloadHandler(
    filename = function() {
      paste0("gsgi_", byGSGI(), ".png")
    },
    content = function(file) {
      ggsave(file)
    }
  ) 
  
  # USN
  uri_usn <- a("USN text data", href="https://ocean.weather.gov/gulf_stream_latest.txt")
  output$textGSGI <- renderUI({
    tagList("The USN (gsgi) publishes estimated north/south wall position coordinates. Data are provided via ", 
            uri_usn)
  })
  wallUSN = reactive(input$rbUSNwall)
  weekUSN = reactive(input$sliderUSN)
  output$mapUSN = renderLeaflet({
    #initial rendering
    plot(usn, wall = wallUSN(), iweek = weekUSN(), graphics = "leaflet")
  })
  
  observe({
    leafletProxy("mapUSN") |>
      clearShapes() |>
      clearControls() |>
      add_usn_layer(x = usn, wall = wallUSN(), iweek = weekUSN())
  })
  
  # HEAT
  output$plotRAPID = renderPlot({
    plot(rapid)
  })
  
  # AMOC
  output$plotAMOC = renderPlot({
    plot(amoc)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
  
