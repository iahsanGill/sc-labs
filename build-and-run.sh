#!/bin/bash

# Set image name and tag
IMAGE_NAME="antlr-python-image"
TAG="latest"

# Build the Docker image
echo "Building Docker image: $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG .

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Build successful! Running the Docker container..."
    
    # Check if an untagged image with the specified name exists
    UNTAGGED_IMAGE=$(docker images -f "dangling=true" -q)
    if [ -n "$UNTAGGED_IMAGE" ]; then
        echo "Removing previous untagged image: $UNTAGGED_IMAGE"
        docker rmi $UNTAGGED_IMAGE
    fi
    
    # Run the Docker container
    docker run -it --rm $IMAGE_NAME:$TAG
else
    echo "Build failed. Please check the Dockerfile for errors."
    exit 1
fi
