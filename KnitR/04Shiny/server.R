# server.R

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="/Library/Frameworks/R.framework/Versions/3.0/Resources/library/ojdbc6.jar")
  # In the following, use your username and password instead of "CS347_prof", "orcl_prof" once you have an Oracle account
  possibleError <- tryCatch(
    jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_fao286", "orcl_fao286"),
    error=function(e) e
  )
  
  if(!inherits(possibleError, "error")){
    shinyT <- dbGetQuery(jdbcConnection, "select * from shinyT2")
    dbDisconnect(jdbcConnection)
  }
  
  output$summary <- renderPrint({
    dataset <- shinyT
    summary(dataset)
  })
  
  output$view <- renderTable({
    head(shinyT[0], n = shinyT[3])
  })
  

  
})