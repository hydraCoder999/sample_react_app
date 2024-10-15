# Stage 1: Build the React app
FROM node:latest AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY ./package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app (if applicable)
RUN npm run build

# Stage 2: Run the app using npm run preview
FROM node:latest

# Set the working directory
WORKDIR /app

# Copy the built app and package.json from the build stage
COPY --from=build /app .

# Expose the port that the preview server will use (default is 4173 for Vite)
EXPOSE 4173

# Command to run the preview server
CMD ["npm", "run", "preview"]
