library(DT)
library(readr)
library(shiny)
library(TDAstats)

shinyServer(function(input, output) {
    dataInput <- reactive({
        req(input$inputFile)
        df <-
            read_delim(
                input$inputFile$datapath,
                col_names = input$headers,
                delim = input$sep
            )
        df <- apply(df, 2, as.numeric)
        return(df)
    })
    
    output$dataTable <- DT::renderDataTable({
        df <- dataInput()
        return(df)
    })
    
    persistance <- reactive({
        df <- dataInput()
        Diag <- calculate_homology(
            df,
            dim = as.integer(input$maxdim),
            standardize = input$standardize
        )
        return(Diag)
    })
    
    output$persist <- renderPlot({
        Diag <- persistance()
        return(plot_persist(Diag))
    })
    
    output$barcode <- renderPlot({
        Diag <- persistance()
        return(plot_barcode(Diag))
    })

})
