function(input, output, session) {
  
  
  # Heatmap by country
  output$country <- renderD3heatmap({
    
    d3heatmap(top100c,
              scale = "column", 
              dendrogram = "none", 
              colors = "YlOrBr",
              xaxis_font_size = "10px",
              yaxis_font_size = "10px")
    
  })
  
  
  
  # And by category
  output$category <- renderD3heatmap({
    
    d3heatmap(top100, 
              scale = "column", 
              dendrogram = "none", 
              colors = "Greens",
              xaxis_font_size = "10px",
              yaxis_font_size = "10px")
    
  })
  
  
  
  
  # Data for reactive heatmap
  data <- reactive({
    
    thecat <- top100cat[top100cat$grid_country == input$c, "Subject"]
    
    validate(
      need(nrow(top100cat[top100cat$grid_country == input$c, ]) >1, 
           message = paste0("Sorry, cannot render only one subject (", thecat, "). Select another country."))
    )
    
    top100cat[top100cat$grid_country == input$c, ]
    
  })
  
  
  
  # Reactiv heatmap, by selected country
  output$selcountry <- renderD3heatmap({
    
    countrydata <- data()
    
    row.names(countrydata) <- countrydata$Subject
    
    countrydata <- countrydata %>%
      ungroup() %>%
      select(-grid_country,-Subject)
    
    d3heatmap(countrydata, 
              scale = "column", 
              dendrogram = "none",
              xaxis_font_size = "10px",
              yaxis_font_size = "10px",
              colors = "Blues")
    
  })
  
  
  
  
  
}