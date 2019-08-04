


shinyServer(function(input,output){
  
  output$strikeouts = renderPlotly({
    
    ggplotly(KsDF %>% 
      ggplot(aes(x = year, y = KsPerGame)) +
      geom_bar(stat = "identity", color = 'red') +
      labs(x = "Year", y = "Strikeouts", title = "Strikeouts Per Game"))
  })
  
  output$noH = renderPlotly({

    ggplotly(noHitters %>%
      ggplot(aes(x = seasonYear, y = NoHitters)) +
      geom_bar(stat ="identity",color = "red" ) +
      labs(x = "Year", y = "# of No Hitters", title = "No Hitters"))
  })

  output$pitchers = renderPlot(
    seasonWins %>% 
      filter(pitchers.winning_pitcher_name == input$pitchers.winning_pitcher_name) %>% 
      ggplot(aes(x = pitchers.seasonYear, y = V1)) +
      geom_col(fill = "red") +
      labs(x = "Year", y = "Wins") +
      ggtitle("Career Results")
  )
  
})