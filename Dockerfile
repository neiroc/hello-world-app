# Stage 1: Build the Go binary
FROM golang:1.20-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
# COPY go.mod ./
COPY go.mod ./

# Download the Go module dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the Go binary
RUN go build -o hello-world-app

# Stage 2: Create a minimal container with the Go binary
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /root/

# Copy the Go binary from the builder stage
COPY --from=builder /app/hello-world-app .

# Expose port 8080 for the web server
EXPOSE 8080

# Command to run the application
CMD ["./hello-world-app"]
