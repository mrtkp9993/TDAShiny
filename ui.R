library(DT)
library(shiny)
library(shinycssloaders)
library(shinythemes)

shinyUI(fluidPage(
    tags$head(
        tags$link(rel = "stylesheet",
                  href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css")
    ),
    titlePanel("Topological Data Analysis"),
    hr(),
    tags$a(
        href = "https://github.com/mrtkp9993",
        target = "_blank",
        class = "fa fa-2x fa-github"
    ),
    HTML("&nbsp;"),
    tags$a(
        href = "https://www.linkedin.com/in/muratkoptur/",
        target = "_blank",
        class = "fa fa-2x fa-linkedin"
    ),
    hr(),
    sidebarLayout(sidebarPanel(
        tabsetPanel(
            type = "tabs",
            tabPanel(
                "Upload File",
                br(),
                fileInput(
                    "inputFile",
                    "Choose CSV file",
                    
                    multiple = FALSE,
                    accept = c("text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv"),
                    width = NULL
                ),
                checkboxInput("headers",
                              "Header",
                              value = TRUE),
                selectInput(
                    "sep",
                    "Seperator",
                    choices = list(space = " ", comma = ",", tab = "\t"),
                    selected = ","
                )
            ),
            tabPanel(
                "Persistence",
                br(),
                selectInput(
                    "maxdim",
                    "Max Dimension",
                    choices = list(
                        "1 - Connected Components & Loops " = 1,
                        "2 - Connected Components & Loops & Voids" = 2
                    ),
                    selected = 1
                ),
                br(),
                checkboxInput(
                    "standardize",
                    "Standardize point cloud size",
                    value = FALSE
                )
            ),
            tabPanel(
                "Usage",
                br(),
                tags$ol(
                    tags$li("Load csv file."),
                    tags$li("If your contains a header, please check Headers.")
                ),
                br(),
                p(
                    h5("If you have suggestions, please send them to"),
                    em("mkoptur3@gmail.com"),
                    h5("and if you like this project, please give a star on GitHub: ")
                ),
                tags$a(
                    href = "https://github.com/mrtkp9993",
                    target = "_blank",
                    class = "fa fa-github"
                )
            )
        )
    ),
    mainPanel(
        tabsetPanel(
            type = "tabs",
            tabPanel("Data",
                     br(),
                     DT::dataTableOutput("dataTable")),
            tabPanel("Persistence Diagram",
                     br(),
                     withSpinner(plotOutput("persist", height = "500px"))),
            tabPanel("Barcode Diagram",
                     br(),
                     withSpinner(plotOutput("barcode", height = "500px")))
        )
    ))
))