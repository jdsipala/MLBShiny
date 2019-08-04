


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
    pitcherWins %>% 
      filter(winning_pitcher_name == input$winning_pitcher_name) %>% 
      ggplot(aes(x = winning_pitcher_name, y = wins)) +
      geom_col(fill = "red") +
      ggtitle("Number of Wins")
  )
  
})