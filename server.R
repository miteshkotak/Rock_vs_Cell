# Battle of the Ages Web Interface - server
# Rick Scavetta
# 19.11.17
# SHDB17

server <- function(input, output, session) {

  img1 <- reactive({

    input$getCell

    CellFiles <- list.files("./images_cells_cropped/")

    # if (input$comp1 == 1) {
    #   import <- "./images_cells_cropped/13-03-11-repomagiRNAi-L_001_000.png"
    # } else {
    #   import <- "./images_cells_cropped/13-03-11-repomagiRNAi-L_001_001.png"
    # }

    import <- paste0("./images_cells_cropped/",sample(CellFiles, 1))

      readImage(import)
  })



  img2 <- reactive({

    input$getRock

    RockFiles <- list.files("./images_rocks_cropped/")


    # if (input$comp2 == 1) {
    #   import <- "./images_cells_cropped/13-03-11-repomagiRNAi-L_001_002.png"
    # } else {
    #   import <- "./images_cells_cropped/13-03-11-repomagiRNAi-L_001_003.png"
    # }

    import <- paste0("./images_rocks_cropped/",sample(RockFiles, 1))

    readImage(import)
  })


  output$image <- renderImage({

    # Get width and height of image output
    width  <- session$clientData$output_image_width
    height <- session$clientData$output_image_height

    # Write to a temporary PNG file
    outfile <- tempfile("test", fileext = "png")

    png(outfile, width=width, height=height)
    display(img1(),  method = "raster")
    # plot(rnorm(200), rnorm(200))
    dev.off()

    # display(img, method = "raster")

    # Return a list containing information about the image
    list(
      src = outfile,
      contentType = "image/png",
      width = width,
      height = height,
      alt = "The image can't be displayed"
    )
  }, deleteFile = TRUE)


  ######### image 2:
  output$imageRock <- renderImage({
    # input$newimage

    # Get width and height of image output
    width  <- session$clientData$output_image_width
    height <- session$clientData$output_image_height

    # Write to a temporary PNG file
    outfile <- tempfile("test", fileext = "png")


    # if (input$comp1 == 1) {
    #
    #   import <- "./testimages/A16-013A_No0054.tif"
    # } else {
    #
    #   import <- "./testimages/A16-013B_No0038.tif"
    # }
    #
    #
    # img <- readImage(import)
    # # img <- readImage("./testimages/A16-013A_No0054.tif")


    png(outfile, width=width, height=height)
    display(img2(),  method = "raster")
    # plot(rnorm(200), rnorm(200))
    dev.off()

    # display(img, method = "raster")

    # Return a list containing information about the image
    list(
      src = outfile,
      contentType = "image/png",
      width = width,
      height = height,
      alt = "The image can't be displayed"
    )
  }, deleteFile = TRUE)

  # xmin <- reactive({round(input$image_brush_1$xmin)})
  # xmax <- reactive({round(input$image_brush_1$xmax)})
  #
  # ymin <- reactive({round(input$image_brush_1$ymin)})
  # ymax <- reactive({round(input$image_brush_1$ymax)})

  # output$brush1text <- renderPrint({c(xmax(), xmin(), ymax(), ymin())})
  # output$brush1text <- renderPrint({c(round(input$image_brush_1$xmax),
  #                                     round(input$image_brush_1$ymax),
  #                                     round(input$image_brush_1$xmin),
  #                                     round(input$image_brush_1$ymin))})
  output$brush1text <- renderPrint({img2()[round(input$image_brush_1$xmin):round(input$image_brush_1$xmax),
                                           round(input$image_brush_1$ymin):round(input$image_brush_1$ymax)]})

  ######### Mashup image
  output$imageMashup <- renderImage({
    # input$newimage
    req(input$image_brush_1)
    req(input$image_brush_2)


    # brushed <- brushedPoints(img1(), input$image_brush_1)

    xmax <- round(input$image_brush_1$xmax)
    xmin <- round(input$image_brush_1$xmin)
    ymax <- round(input$image_brush_1$ymax)
    ymin <- round(input$image_brush_1$ymin)

    xmax2 <- round(input$image_brush_2$xmax)
    xmin2 <- round(input$image_brush_2$xmin)
    ymax2 <- round(input$image_brush_2$ymax)
    ymin2 <- round(input$image_brush_2$ymin)


    # img1()[xmin:xmax, ymin:ymax]
    img2 <- img2()
    img1 <- img1()


    # Mash-up adjust:
    img1Adj <- 0
    img2Adj <- 0

    brushed <- (img1*img1Adj) + (img2*img2Adj)
    brushed[xmin:xmax, ymin:ymax] <- img1[xmin:xmax, ymin:ymax]
    brushed[xmin2:xmax2, ymin2:ymax2] <- img2[xmin2:xmax2, ymin2:ymax2]


    # img2()[xmin:xmax, ymin:ymax] <- 0
    # brushed <- img2

    # Get width and height of image output
    width  <- session$clientData$output_image_width
    height <- session$clientData$output_image_height

    # Write to a temporary PNG file
    outfile <- tempfile("test", fileext = "png")


    # if (input$comp1 == 1) {
    #
    #   import <- "./testimages/A16-013A_No0054.tif"
    # } else {
    #
    #   import <- "./testimages/A16-013B_No0038.tif"
    # }
    #
    #
    # img <- readImage(import)
    # # img <- readImage("./testimages/A16-013A_No0054.tif")


    png(outfile, width=width, height=height)
    display(brushed,  method = "raster")
    # plot(rnorm(200), rnorm(200))
    dev.off()

    # display(img, method = "raster")

    # Return a list containing information about the image
    list(
      src = outfile,
      contentType = "image/png",
      width = width,
      height = height,
      alt = "The image can't be displayed"
    )
  }, deleteFile = TRUE)


  # Make matrix just for export:
  myPlot <- reactive({
    # input$newimage
    req(input$image_brush_1)
    req(input$image_brush_2)


    # brushed <- brushedPoints(img1(), input$image_brush_1)

    xmax <- round(input$image_brush_1$xmax)
    xmin <- round(input$image_brush_1$xmin)
    ymax <- round(input$image_brush_1$ymax)
    ymin <- round(input$image_brush_1$ymin)

    xmax2 <- round(input$image_brush_2$xmax)
    xmin2 <- round(input$image_brush_2$xmin)
    ymax2 <- round(input$image_brush_2$ymax)
    ymin2 <- round(input$image_brush_2$ymin)


    # img1()[xmin:xmax, ymin:ymax]
    img2 <- img2()
    img1 <- img1()


    # Mash-up adjust:
    img1Adj <- 0
    img2Adj <- 0

    brushed <- (img1*img1Adj) + (img2*img2Adj)
    brushed[xmin:xmax, ymin:ymax] <- img1[xmin:xmax, ymin:ymax]
    brushed[xmin2:xmax2, ymin2:ymax2] <- img2[xmin2:xmax2, ymin2:ymax2]

    return(brushed)

  })

  observeEvent(input$battle, {
    writeImage(myPlot(), "hello.png", type = "png")
  })




}
