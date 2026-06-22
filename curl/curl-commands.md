# 🌐 curl & API Testing Commands

> Essential curl patterns for testing APIs, sending requests, handling authentication, and debugging HTTP interactions.

---

## 📦 Installation

```bash
# Usually pre-installed on macOS and Linux

# Windows
choco install curl
winget install cURL.cURL

# Linux (Debian/Ubuntu)
sudo apt install curl

# Verify
curl --version
```

---

## 🚀 Basic Requests

```bash
# GET (default)
curl https://api.example.com/users
curl -s https://api.example.com/users       # Silent mode (no progress bar)

# POST
curl -X POST https://api.example.com/users

# PUT
curl -X PUT https://api.example.com/users/1

# PATCH
curl -X PATCH https://api.example.com/users/1

# DELETE
curl -X DELETE https://api.example.com/users/1
```

---

## 📤 Sending Data

### JSON Body

```bash
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John", "email": "john@example.com"}'
```

### JSON from File

```bash
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d @payload.json
```

### Form Data

```bash
curl -X POST https://api.example.com/login \
  -d "username=admin&password=secret"

# Multipart form (file upload)
curl -X POST https://api.example.com/upload \
  -F "file=@photo.jpg" \
  -F "description=My photo"
```

### URL-Encoded Data

```bash
curl -X POST https://api.example.com/login \
  --data-urlencode "query=hello world" \
  --data-urlencode "filter=name=John"
```

---

## 🏷️ Headers

```bash
# Set custom headers
curl -H "Authorization: Bearer <token>" https://api.example.com/me
curl -H "Accept: application/json" https://api.example.com/users
curl -H "X-Custom-Header: value" https://api.example.com/endpoint

# Multiple headers
curl -H "Authorization: Bearer <token>" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     https://api.example.com/users

# View response headers
curl -I https://api.example.com/users       # HEAD request (headers only)
curl -i https://api.example.com/users       # Include headers in output
```

---

## 🔐 Authentication

### Bearer Token

```bash
curl -H "Authorization: Bearer eyJhbGci..." https://api.example.com/me
```

### Basic Auth

```bash
curl -u username:password https://api.example.com/login
curl -u username https://api.example.com/login   # Prompted for password
```

### API Key (Header)

```bash
curl -H "X-API-Key: your-api-key" https://api.example.com/data
```

### API Key (Query Parameter)

```bash
curl "https://api.example.com/data?api_key=your-api-key"
```

### OAuth Token Request

```bash
curl -X POST https://auth.example.com/oauth/token \
  -d "grant_type=client_credentials" \
  -d "client_id=YOUR_ID" \
  -d "client_secret=YOUR_SECRET"
```

---

## 🔍 Debugging & Verbose Output

```bash
# Verbose mode (shows request/response details)
curl -v https://api.example.com/users

# Show only response headers
curl -I https://api.example.com/users

# Include response headers in output
curl -i https://api.example.com/users

# Show timing info
curl -w "\n---\nTime Total: %{time_total}s\nHTTP Code: %{http_code}\n" \
  -o /dev/null -s https://api.example.com/users

# Detailed timing breakdown
curl -w "\nDNS: %{time_namelookup}s\nConnect: %{time_connect}s\nTLS: %{time_appconnect}s\nStart: %{time_starttransfer}s\nTotal: %{time_total}s\n" \
  -o /dev/null -s https://api.example.com/users

# Write output to file and view headers
curl -D headers.txt -o response.json https://api.example.com/users
```

---

## 📥 Downloading Files

```bash
# Save with remote filename
curl -O https://example.com/file.zip

# Save with custom filename
curl -o myfile.zip https://example.com/file.zip

# Resume interrupted download
curl -C - -O https://example.com/largefile.zip

# Follow redirects while downloading
curl -L -O https://example.com/redirect-to-file

# Download multiple files
curl -O https://example.com/file1.zip -O https://example.com/file2.zip

# Show progress bar
curl --progress-bar -O https://example.com/file.zip
```

---

## 🔄 Following Redirects & Status Codes

```bash
# Follow redirects (3xx)
curl -L https://example.com/redirect

# Show only HTTP status code
curl -o /dev/null -s -w "%{http_code}" https://api.example.com/health

# Fail silently on HTTP errors (exit code non-zero for 4xx/5xx)
curl -f https://api.example.com/endpoint
```

---

## 🍪 Cookies

```bash
# Send cookies
curl -b "session=abc123; theme=dark" https://example.com

# Save cookies from response
curl -c cookies.txt https://example.com/login -d "user=admin&pass=secret"

# Use saved cookies in next request
curl -b cookies.txt https://example.com/dashboard
```

---

## 🔒 SSL/TLS

```bash
# Skip SSL verification (dev only!)
curl -k https://self-signed.example.com

# Specify CA certificate
curl --cacert /path/to/ca.crt https://api.example.com

# Client certificate
curl --cert client.crt --key client.key https://api.example.com
```

---

## ⏱️ Timeouts & Retries

```bash
# Connection timeout (seconds)
curl --connect-timeout 5 https://api.example.com

# Maximum time for entire operation
curl --max-time 30 https://api.example.com

# Retry on failure
curl --retry 3 https://api.example.com
curl --retry 3 --retry-delay 2 https://api.example.com
curl --retry 3 --retry-all-errors https://api.example.com
```

---

## 🧪 Common API Testing Patterns

### Health Check

```bash
curl -s -o /dev/null -w "%{http_code}" https://api.example.com/health
```

### GET with Query Parameters

```bash
curl -G https://api.example.com/users \
  --data-urlencode "search=john" \
  --data-urlencode "page=1" \
  --data-urlencode "limit=10"
```

### CRUD Example

```bash
# Create
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@test.com"}'

# Read
curl https://api.example.com/users/1

# Update
curl -X PUT https://api.example.com/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"John Updated","email":"john@test.com"}'

# Partial Update
curl -X PATCH https://api.example.com/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"John Patched"}'

# Delete
curl -X DELETE https://api.example.com/users/1
```

### Pretty-Print JSON (pipe to jq)

```bash
curl -s https://api.example.com/users | jq .
curl -s https://api.example.com/users | jq '.[0].name'
curl -s https://api.example.com/users | jq '.[] | {name, email}'
```

---

## 📝 Using `.curlrc` for Defaults

Create `~/.curlrc`:

```
# Always follow redirects
-L
# Default content type
-H "Content-Type: application/json"
# Show errors
--show-error
# Connection timeout
--connect-timeout 10
```

---

## ⌨️ Handy Aliases

```bash
# Add to ~/.bashrc or ~/.zshrc
alias GET='curl -s -H "Content-Type: application/json"'
alias POST='curl -s -X POST -H "Content-Type: application/json"'
alias PUT='curl -s -X PUT -H "Content-Type: application/json"'
alias DELETE='curl -s -X DELETE'
alias headers='curl -I -s'

# Usage
GET https://api.example.com/users | jq .
POST https://api.example.com/users -d '{"name":"John"}' | jq .
```

---

## 📚 Resources

- [curl Documentation](https://curl.se/docs/)
- [curl Man Page](https://curl.se/docs/manpage.html)
- [Everything curl (Book)](https://everything.curl.dev/)
- [jq Documentation](https://stedolan.github.io/jq/manual/)
