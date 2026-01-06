# SlowScout Deployment Setup
# Run this script step by step in your R console

cat("========================================\n")
cat("SlowScout Deployment Setup\n")
cat("========================================\n\n")

# Step 1: Install rsconnect
cat("STEP 1: Installing rsconnect package...\n")
if (!require("rsconnect", quietly = TRUE)) {
  install.packages("rsconnect")
  library(rsconnect)
  cat("✓ rsconnect installed successfully!\n\n")
} else {
  cat("✓ rsconnect is already installed.\n\n")
}

# Step 2: Instructions for getting secret
cat("========================================\n")
cat("STEP 2: Get Your Secret from shinyapps.io\n")
cat("========================================\n")
cat("1. Go to: https://www.shinyapps.io/admin/#/tokens\n")
cat("2. Log in to your account\n")
cat("3. Find your token (E5D3041697C33DCEAFDB25AD1E437432)\n")
cat("4. Copy the SECRET associated with that token\n\n")
cat("Press Enter when you have your secret ready...\n")
readline()

# Step 3: Authorize account
cat("\n========================================\n")
cat("STEP 3: Authorize Your Account\n")
cat("========================================\n")
cat("Paste your secret below when prompted.\n\n")

secret <- readline(prompt = "Enter your secret: ")

if (nchar(secret) > 0 && secret != "<SECRET>" && secret != "<YOUR_SECRET_HERE>") {
  tryCatch({
    rsconnect::setAccountInfo(
      name = 'ml0dd3-ayan-nath',
      token = 'E5D3041697C33DCEAFDB25AD1E437432',
      secret = secret
    )
    cat("\n✓ Account authorized successfully!\n\n")
    
    # Step 4: Deploy
    cat("========================================\n")
    cat("STEP 4: Deploy the App\n")
    cat("========================================\n")
    deploy_now <- readline(prompt = "Deploy now? (y/n): ")
    
    if (tolower(deploy_now) == "y" || tolower(deploy_now) == "yes") {
      cat("\nDeploying SlowScout...\n")
      cat("This may take a few minutes...\n\n")
      
      rsconnect::deployApp(
        appDir = getwd(),
        appName = "SlowScout",
        account = "ml0dd3-ayan-nath"
      )
      
      cat("\n✓ Deployment complete!\n")
      cat("Check your app at: https://ml0dd3-ayan-nath.shinyapps.io/SlowScout/\n")
    } else {
      cat("\nYou can deploy later by running:\n")
      cat("library(rsconnect)\n")
      cat("rsconnect::deployApp(appDir = getwd(), appName = 'SlowScout', account = 'ml0dd3-ayan-nath')\n")
    }
  }, error = function(e) {
    cat("\n✗ Error authorizing account:\n")
    cat(e$message, "\n")
    cat("\nPlease check:\n")
    cat("1. Your secret is correct\n")
    cat("2. Your account name is correct\n")
    cat("3. You have an active shinyapps.io account\n")
  })
} else {
  cat("\n✗ Invalid secret. Please run this script again with a valid secret.\n")
  cat("\nTo authorize manually, run:\n")
  cat("rsconnect::setAccountInfo(\n")
  cat("  name='ml0dd3-ayan-nath',\n")
  cat("  token='E5D3041697C33DCEAFDB25AD1E437432',\n")
  cat("  secret='YOUR_SECRET_HERE'\n")
  cat(")\n")
}

