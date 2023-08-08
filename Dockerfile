# Use a lightweight base image
FROM nginx:alpine

# Copy app files to the container
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/
