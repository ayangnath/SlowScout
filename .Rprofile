# Only activate renv/packrat if not deploying to shinyapps.io
if (!identical(Sys.getenv("R_CONFIG_ACTIVE"), "shinyapps")) {
  if (file.exists("renv/activate.R")) {
    source("renv/activate.R")
  }
  #### -- Packrat Autoloader -- ####
  if (file.exists("packrat/init.R")) {
    source("packrat/init.R")
  }
  #### -- End Packrat Autoloader -- ####
}
