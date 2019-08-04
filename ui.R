


shinyUI(dashboardPage(skin = "red",
                      
    # Application title
    dashboardHeader(title = "MLB Stats"),
    # Application sidebar
    dashboardSidebar(width = 250,
      
      sidebarUserPanel("NYC DSA",
                       image = "https://upload.wikimedia.org/wikipedia/en/thumb/1/1e/Baseball_%28crop%29.jpg/290px-Baseball_%28crop%29.jpg"),
      sidebarMenu(
        menuItem("About", tabName = "intro"),
        menuItem("Historical: Pitching", tabName = "pitch", icon = icon("list-alt")),
        menuItem("Pitchers Index", tabName = "players", icon = icon("list-alt")),
        menuItem("Hitting", tabName = "hit", icon = icon("list-alt"))
      )
    ),
    dashboardBody(
      
      
      tabItems(
        
        
        ## about tab ##
        tabItem(tabName = "intro",
                fluidRow(
                  column(width = 12,
                         box(height = 200,
                             title = h2(strong("Purpose"), align = "center"), width = NULL, solidHeader = TRUE, background = "navy",
                             tags$h4("This project, which includes Major League Baseball data dating back to 1910, uses statistics to show
                                      how the game of baseball is evolving and also visualize some of this historical data")
                            )
                         )
                        )
                ),
        
        #### Historical PITCHING TAB
        tabItem(tabName = "pitch",
                fluidRow(
                  box(width = 12,
                      solidHeader = TRUE,status= NULL, plotlyOutput("strikeouts", height = 450)),
                         
                fluidRow(
                  box(width = 12,
                      solidHeader = TRUE, status = NULL, plotlyOutput("noH", height = 450))
                        )
                )
        ),
        
        
        #### individual pitchers tab
        tabItem(tabName = "players",
                fluidRow(
                  box(height = 150, width = 12,
                      selectizeInput(inputId = "winning_pitcher_name",
                                     label = "Player Name",
                                     choices = pitcherWins$winning_pitcher_name)
                                  
                      )
                ),
                fluidRow(
                  box(height = 350, width = 12,
                      plotOutput(outputId = "pitchers")
                      )
                )
                )
        
        
        
        )
        
      )
      
    )
)