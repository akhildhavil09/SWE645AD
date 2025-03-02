# SWE645 - Assignment 1 G01472450

## Project Links
- Homepage: http://gdhavile.s3-website.us-east-2.amazonaws.com/
- Survey Form: http://13.58.201.55/survey.html

## What I Did

1. Created a static website using AWS S3
   - Built a homepage with my profile
   - Added an error page for better user experience
   - Used Tailwind CSS for styling

2. Deployed a student survey form on EC2
   - Set up an EC2 instance with Apache web server
   - Created an interactive survey form
   - Connected it to my homepage

## How to Set It Up

### S3 Setup (Homepage)
- Create and configure S3 bucket
- Enable static website hosting
- Upload index.html and error.html
- Make bucket public

### EC2 Setup (Survey Form)
- Launch EC2 instance
- Install Apache
- Deploy survey.html to /var/www/html
- Configure security group for HTTP access

## Files Included
- index.html - Homepage
- error.html - Error page
- survey.html - Survey form
- images/ - Website images