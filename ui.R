sidebar <- dashboardSidebar(disable = T)


body <- dashboardBody(
  
  fluidRow(
    column(
      width = 6,
      box(
        height = "1250px",
        width = NULL,
        title = "Average metrics by country",
        status = "success",
        d3heatmapOutput("country", height = "1200px")
      )
    ),
    column(
      width = 6,
      box(
        title = "About",
        width = NULL,
        status = "info",
        tags$div(class="header", checked=NA,
                 tags$a(href="https://figshare.com/collections/Altmetric_Top_100_2016/3590951", "Engineering, Altmetric (2016): Altmetric Top 100 2016. figshare.
https://dx.doi.org/10.6084/m9.figshare.c.3590951.v1 Retrieved: 09 11, Dec 13, 2016 (GMT)")
        ),
        tags$div(class="header", checked=NA,
                 tags$p("To select, click row and/or column label. Draw a rectangle to zoom. To reset, click map.", 
                        a(href="https://github.com/rstudio/d3heatmap/issues/43", "Note tooltip issue in FF while zooming")
                 )
        ),
        tags$div(class="header", checked=NA,
                 tags$a(href="https://github.com/tts/altm2016top100", "R source code"))
      ),
      box(
        title = "Average metrics by subject",
        width = NULL,
        status = "warning",
        d3heatmapOutput("category")
      ),
      box(
        width = NULL,
        selectInput(inputId = "c",
                    label = "Select country for the map below",
                    choices = countries,
                    selected = "United Kingdom")
      ),
      box(
        width = NULL,
        heigth = "400px",
        status = "primary",
        d3heatmapOutput("selcountry", height = "550px")
      )
    )
  )
)


dashboardPage(
  dashboardHeader(title = "Altmetric Top 100 articles 2016",
                  titleWidth = "500"),
  sidebar,
  body,
  skin = "black"
)

