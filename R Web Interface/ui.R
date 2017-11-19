# Battle of the Ages Web Interface - UI
# Rick Scavetta
# 19.11.17
# SHDB17

shinyUI(fluidPage(theme = "bootstrap.css",

  # head(HTML('<script type = "text/javascript" src="processing.js"></script>')),



  fluidRow(
    tags$head(
      tags$style(paste0(
        "body:before { ",
        "  content: ''; ",
        "  height: 100%; width: 100%; ",
        "  position: fixed; ",
        "  z-index: -1; ",
        "  background: url(http://ec2-52-28-60-173.eu-central-1.compute.amazonaws.com:3838/backgrounds/",bkgnumb,".png) no-repeat center center fixed; ",
        "  background-size: cover; ",
        "  filter: grayscale(100%); ",
        "  -webkit-filter: grayscale(100%); }"))),
    headerPanel(fluidRow(column(5, tags$h1(
      tags$strong("The Battle of the Ages - Rock vs Cell"),
      style = "font family:Lobster,cursive;color:white;background-color:black;text-align:center;")))),



    column(12, #h1("Cell vs Rock Battle"),
           fluidRow(12,

    tags$div(
    tags$p("What could be more different than rocks and cells?"),
    tags$br(),
    tags$p("After our playful analysis comparing 400 million year old rocks from 60km below the surface or Norway's islands to the peripheral nerves of 5 day old fruit flies,we have concluded that its a rocky life!"),
    tags$br(),
    tags$p("Using electron microscopy, life appears more complex. However, when the animal dies, this complexity degrades into new elements that flow through cracks back into the Earth's crust that supported them throughout their life."),
    tags$br(),
    tags$p("Ultimately, it's all one rocky life cycle."),
    tags$br(),
    tags$p("Start your own now! "),
      style = "font family:Lobster,cursive;color:white;background-color:black;text-align:left;")

           ),
           fluidRow(
             column(4,
                    actionButton("getCell", label = "Pick a Cell"),
                      # selectInput("comp1", label = h3("Competitor 1"),
                      #             choices = list("Cell A" = 1, "Cell B" = 2),
                      #             selected = 1),
                    imageOutput("image", height = 512, width = 512,
                                click = "image_click_1",
                                hover = hoverOpts(
                                  id = "image_hover_1",
                                  delay = 500,
                                  delayType = "throttle"
                                ),
                                brush = brushOpts(id = "image_brush_1")
                    )
             ),
             column(4,
                    actionButton("getRock", label = "Pick a Rock"),
                    # selectInput("comp2", label = h3("Competitor 2"),
                    #             choices = list("Rock A" = 1, "Rock B" = 2),
                    #             selected = 1),
                    imageOutput("imageRock", height = 512, width = 512,
                                click = "image_click_2",
                                hover = hoverOpts(
                                  id = "image_hover_2",
                                  delay = 500,
                                  delayType = "throttle"
                                ),
                                brush = brushOpts(id = "image_brush_2")
                    )

             ),
             column(4, #h2("Mash-up"),
                    # verbatimTextOutput("brush1text"),
                    actionButton("battle", label = "Battle!"),
                    # downloadLink("downloadImage", "Battle"),
                    imageOutput("imageMashup", height = 512, width = 512,
                                click = "image_click_1",
                                hover = hoverOpts(
                                  id = "image_hover_1",
                                  # delay = 500,
                                  delayType = "throttle"
                                  ),
                                brush = brushOpts(id = "image_brush_1")
                                ) #,
           # HTML('<canvas data-processing-sources = "myProgram.pde"></canvas>')


           )
           )
  )
  )
))
