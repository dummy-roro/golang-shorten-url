# 🔗 Go URL Shortener

A fast and minimal URL shortening service written in Go.

## 🚀 Features

- REST API to shorten and resolve URLs
- In-memory or Redis-based storage (extendable)
- Clean URL structure
- Lightweight Docker image
- CI/CD and GitOps-ready

---

## 🛠️ Tech Stack

- **Language**: Go
- **Framework**: net/http
- **Container**: Docker
- **CI/CD**: GitHub Actions
- **GitOps**: Manifest repo integration
- **Security**: gosec, Trivy, golangci-lint

---

## 🚧 Getting Started

### 📦 Clone

```bash
git clone https://github.com/dummy-roro/golang-shorten-url.git
cd golang-shorten-url
```

### 🔨 Build Locally

```bash
go build -o shorturl
./shorturl
```

By default it runs on: `http://localhost:8080`

---

## 📦 Run with Docker

### 🔧 Build

```bash
docker build -t ghcr.io/dummy-roro/golang-shorten-url:latest .
```

### ▶️ Run

```bash
docker run -p 8080:8080 ghcr.io/dummy-roro/golang-shorten-url:latest
```

---

## 📤 API Endpoints

| Method | Endpoint        | Description               |
|--------|------------------|---------------------------|
| POST   | `/shorten`       | Create short URL          |
| GET    | `/:shortcode`    | Redirect to original URL  |

Example POST payload:
```json
{
  "url": "https://example.com"
}
```

---

## 🔐 DevSecOps Integration

| Tool      | Description                   |
|-----------|-------------------------------|
| `gosec`   | Static code security analysis |
| `golangci-lint` | Code linting           |
| `Trivy`   | Container vulnerability scan  |

Security checks run in GitHub Actions pipeline.

---

## 🔄 GitOps

Deployment manifests live in [shorten-url-manifests](https://github.com/dummy-roro/shorten-url-manifests).  
CI pushes new image tags to GHCR and updates the manifest repo automatically.

---

## 📃 License

MIT License © dummy-roro
