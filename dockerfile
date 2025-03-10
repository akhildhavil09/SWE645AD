FROM tomcat:9.0-jdk11

# Set maintainer label
LABEL maintainer="Akhilesh <g01472450@gmu.edu>"

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*
RUN mkdir -p /usr/local/tomcat/webapps/ROOT

# Copy your HTML files directly to Tomcat's webapps directory
COPY *.html /usr/local/tomcat/webapps/ROOT/
COPY *.jpg /usr/local/tomcat/webapps/ROOT/ 

# Create a healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=15s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Expose the default Tomcat port
EXPOSE 8080

CMD ["catalina.sh", "run"]