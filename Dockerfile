# Set the base image to use for subsequent instructions
FROM node:alpine

# Add metadata to an image 
LABEL app="simple-node-application"
# Directive to set environmental variables key to value pair
ENV NPM_CONFIG_LOGLEVEL warn

# Set the working directory
WORKDIR /usr/src/app

# Install curl
RUN apk add --no-cache curl \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install

# Copy files or folders from source to the dest path in the image's filesystem.
COPY package.json /usr/src/app/
COPY . /usr/src/app/

# Execute any commands on top of the current image as a new layer and commit the results.
RUN npm install --production

# Define the network ports that this container will listen on at runtime.
EXPOSE 3000

# Configure the container to be run as an executable.
ENTRYPOINT ["npm", "start"]
