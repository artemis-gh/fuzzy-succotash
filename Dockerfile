# Docker base image for running our application.
# golang:1.20-alpine :: Light weight docker image preinstalled with go binaries. 

##  Stage `build`
FROM golang:1.20-alpine AS build

# Default destination for all our subsequent commands.
WORKDIR /app

# go.mod contains the dependencies required to run our application.
# go.sum contains checksum values to verify the integrity of those dependencies.
COPY go.mod ./
COPY go.sum ./

# Installing the dependencies
RUN go mod download

# Copying *.go files to destination
COPY *.go ./

# Generating binary executables
RUN go build -o /main

# Run the executable
# CMD ["/main"] 


# Ship the build to production environment

## Deployment image
FROM gcr.io/distroless/base-debian10

# Default destination for all our subsequent commands.
WORKDIR /

# Copy the build (executable) to production
COPY --from=build /main /main

# Setting ENV variable
ENV HTTP_PORT=8080

# Exposing port 8080
EXPOSE 8080

# Run the Docker daemon as a non-root user (Rootless mode)
USER nonroot:nonroot

# Run the executable
ENTRYPOINT [ "/main" ]

# docker build -t main
# docker images
# docker run -it main
