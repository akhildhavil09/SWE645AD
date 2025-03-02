# Use an official Nginx image to serve the static content
FROM nginx:alpine

# Copy your static HTML files into the container
COPY . /usr/share/nginx/html

# Expose port 80 (default for Nginx)
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
