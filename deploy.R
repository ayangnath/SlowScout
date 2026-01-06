# SlowScout Deployment Script
# This script helps you deploy the SlowScout app to your shinyapps.io account

# Step 1: Install rsconnect (if not already installed)
if (!require("rsconnect", quietly = TRUE)) {
  cat("Installing rsconnect package...\n")
  install.packages("rsconnect")
  cat("rsconnect installed successfully!\n\n")
} else {
  cat("rsconnect is already installed.\n\n")
}

# Step 2: Authorize your account
# IMPORTANT: You need to get your SECRET from your shinyapps.io account
# Go to: https://www.shinyapps.io/admin/#/tokens
# Copy your secret and replace <SECRET> below

cat("========================================\n")
cat("STEP 2: Authorize Your Account\n")
cat("========================================\n")
cat("You need to get your SECRET from:\n")
cat("https://www.shinyapps.io/admin/#/tokens\n\n")
cat("Once you have your secret, run this command in your R console:\n\n")
cat("rsconnect::setAccountInfo(\n")
cat("  name='ml0dd3-ayan-nath',\n")
cat("  token='E5D3041697C33DCEAFDB25AD1E437432',\n")
cat("  secret='<YOUR_SECRET_HERE>'\n")
cat(")\n\n")
cat("Replace <YOUR_SECRET_HERE> with your actual secret.\n\n")

# Step 3: Deploy the app
cat("========================================\n")
cat("STEP 3: Deploy the App\n")
cat("========================================\n")
cat("After authorizing your account, you can deploy by running:\n\n")
cat("library(rsconnect)\n")
cat("rsconnect::deployApp(appDir = getwd(),\n")
cat("                    appName = 'SlowScout',\n")
cat("                    account = 'ml0dd3-ayan-nath')\n\n")

cat("Or use the deploy_app() function below after setting your secret.\n\n")

# Function to deploy the app (run this after setting your secret)
deploy_app <- function() {
  library(rsconnect)
  
  # Get the current working directory (should be the project root)
  app_dir <- getwd()
  
  cat("Deploying SlowScout from:", app_dir, "\n")
  
  # Deploy the app
  rsconnect::deployApp(
    appDir = app_dir,
    appName = "SlowScout",
    account = "ml0dd3-ayan-nath"
  )
  
  cat("\nDeployment complete! Check your shinyapps.io dashboard.\n")
}

cat("To deploy, first authorize your account (Step 2), then run:\n")
cat("  deploy_app()\n")

