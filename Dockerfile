# --- Stage 1: Build the Go application ---
FROM golang:1.23 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum first to leverage Docker's caching.
# If these files don't change, the 'go mod download' step won't rerun.
COPY go.mod go.sum ./

# Download Go module dependencies
# This caches dependencies, so only re-runs if go.mod/go.sum change
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the Go application.
# CGO_ENABLED=0 and GOOS=linux ensure a statically linked binary,
# which is crucial for distroless images that don't include C libraries.
# -a rebuilds all packages, -installsuffix nocgo avoids CGO-related issues.
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o main .

# --- Stage 2: Create the minimal runtime image ---
# Use a distroless 'static' image, which is even smaller than 'base'
# as it only contains ca-certificates and can run statically linked binaries.
FROM gcr.io/distroless/static

# Set the working directory for the final application
WORKDIR /app

# IMPORTANT: Distroless images do NOT have groupadd or useradd.
# You simply set the USER to a numeric UID.
# UID 65532 is a common non-root user in distroless images.
USER 65532

# Copy the compiled binary from the 'build' stage
# Ensure it's copied to the correct working directory path.
# Use --chown to set ownership of the copied files to the non-root UID/GID
COPY --from=build --chown=65532:65532 /app/main /app/main

# Copy static assets required by the application
# Ensure it's copied to the correct working directory path.
# Use --chown to set ownership of the copied files to the non-root UID/GID
COPY --from=build --chown=65532:65532 /app/static /app/static

# Expose the port your application listens on
EXPOSE 8080

# Define the command to run your application when the container starts
CMD ["/app/main"]
