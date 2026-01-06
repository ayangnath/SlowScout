# SlowScout Deployment Guide

This guide will help you deploy the SlowScout Shiny app to your shinyapps.io account.

## Prerequisites

- R installed on your computer
- A shinyapps.io account (you already have one: `ml0dd3-ayan-nath`)
- Your shinyapps.io token and secret

## Step 1: Install rsconnect

Open R or RStudio and run:

```r
install.packages('rsconnect')
```

Or simply run the `deploy.R` script which will check and install it for you.

## Step 2: Get Your Secret

**IMPORTANT:** You need to get your actual secret from your shinyapps.io account.

1. Go to: https://www.shinyapps.io/admin/#/tokens
2. Log in to your account
3. Find your token (the one starting with `E5D3041697C33DCEAFDB25AD1E437432`)
4. Copy the **secret** associated with that token

## Step 3: Authorize Your Account

In your R console, run this command (replace `<YOUR_SECRET_HERE>` with the actual secret you copied):

```r
rsconnect::setAccountInfo(
  name='ml0dd3-ayan-nath',
  token='E5D3041697C33DCEAFDB25AD1E437432',
  secret='<YOUR_SECRET_HERE>'
)
```

**Note:** This only needs to be done once per computer. After this, your computer is authorized to deploy apps to your shinyapps.io account.

## Step 4: Deploy the App

Make sure you're in the project directory (the folder containing `app.R`), then run:

```r
library(rsconnect)
rsconnect::deployApp(
  appDir = getwd(),
  appName = "SlowScout",
  account = "ml0dd3-ayan-nath"
)
```

Or you can use the helper function in `deploy.R`:

```r
source("deploy.R")
deploy_app()
```

## Important Notes

### MongoDB Connection
This app connects to a MongoDB database. The connection URL is currently hardcoded in `R Scripts/Database.R`. 

**For production deployment, you should:**
1. Store the MongoDB connection string as an environment variable
2. Set it in your shinyapps.io dashboard under "Variables" in your app settings
3. Update `Database.R` to read from the environment variable

To set environment variables in shinyapps.io:
1. Go to your app dashboard
2. Click on "Settings"
3. Scroll to "Environment Variables"
4. Add a variable named `MONGODB_URL` with your connection string

### Dependencies
The app uses many R packages. rsconnect will automatically detect and install them during deployment, but the first deployment may take a while.

### App Name
If the app name "SlowScout" is already taken on your account, you can change it in the `deployApp()` call:

```r
rsconnect::deployApp(
  appDir = getwd(),
  appName = "SlowScout-YourName",  # Change this
  account = "ml0dd3-ayan-nath"
)
```

## Troubleshooting

### "Account not found" error
- Make sure you've completed Step 3 (authorization) first
- Verify your account name is correct: `ml0dd3-ayan-nath`

### "Secret is invalid" error
- Double-check that you copied the secret correctly from shinyapps.io
- Make sure there are no extra spaces or characters

### Deployment fails
- Check that all required files are in the project directory
- Make sure `app.R` is in the root directory
- Check the deployment logs in the R console for specific error messages

## Updating the App

To update your deployed app, simply run the deployment command again. It will update the existing app.

```r
rsconnect::deployApp(
  appDir = getwd(),
  appName = "SlowScout",
  account = "ml0dd3-ayan-nath"
)
```

