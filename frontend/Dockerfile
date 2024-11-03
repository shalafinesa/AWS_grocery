# Stage 1: Build the React app
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY frontend/package.json frontend/package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the frontend code and build it
COPY frontend/build /app/build

# Create a marker file indicating the build is complete
RUN touch /app/build/BUILD_COMPLETE