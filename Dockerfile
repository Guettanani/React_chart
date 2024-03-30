# Stage 1: Build the React app
FROM node:latest as build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Install additional dependencies
RUN npm install react-router-dom@latest \
                axios \
                react-calendar \
                react-big-calendar \
                moment \
                xlsx \
                file-saver \
                xlsx-style \
                xlsx-populate \
                exceljs \
                react-chartjs-2 chart.js \
                react-big-calendar \
                @mui/material \
                @emotion/react \
                @emotion/styled \
                @mui/x-data-grid \
                @mui/icons-material \
                react-router-dom@6 \
                formik \
                yup \
                @fullcalendar/daygrid \
                @fullcalendar/timegrid \
                @fullcalendar/list \
                @nivo/core \
                @nivo/pie \
                @nivo/line \
                @nivo/bar \
                @nivo/geo \
                @fullcalendar/react \
                @fullcalendar/core \
                @fullcalendar/interaction
RUN npm install react-pro-sidebar@0.7.1
# Install @babel/plugin-proposal-private-property-in-object as a dev dependency
RUN npm install --save-dev @babel/plugin-proposal-private-property-in-object

# Install @fullcalendar/common
RUN npm install --save @fullcalendar/common

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the built React app
FROM node:alpine

# Install serve globally
RUN npm install -g serve

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the built React app from the previous stage
COPY --from=build /usr/src/app/build ./build

# Expose the port the app runs on
EXPOSE 3000

# Command to serve the application
CMD ["serve", "-s", "build"]
