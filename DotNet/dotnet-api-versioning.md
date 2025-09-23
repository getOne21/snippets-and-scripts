# REST API Versioning in .NET

This guide explains different strategies for versioning APIs in **ASP.NET Core**.

---

## 🛠️ Why API Versioning?

- Maintain backward compatibility  
- Support multiple client versions  
- Enable smooth migration

---

## 📦 Setup API Versioning

### Install Package

```bash
dotnet add package Microsoft.AspNetCore.Mvc.Versioning
```

### Configure in Program.cs

```csharp
builder.Services.AddApiVersioning(options =>
{
    options.DefaultApiVersion = new ApiVersion(1, 0);
    options.AssumeDefaultVersionWhenUnspecified = true;
    options.ReportApiVersions = true;
});
```

---

## 🔀 Versioning Approaches

### 1. URL Path

```
GET /api/v1/products
GET /api/v2/products
```

```csharp
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products")]
public class ProductsControllerV1 : ControllerBase { }
```

### 2. Query String

```
GET /api/products?api-version=1.0
```

### 3. Header

```
GET /api/products
api-version: 1.0
```

---

## ✅ Best Practices

- Use **URL versioning** for public APIs.  
- Keep **old versions alive** for backward compatibility.  
- Document with **Swagger/OpenAPI**.  

### Swagger Example

```csharp
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "My API V1", Version = "v1" });
    c.SwaggerDoc("v2", new OpenApiInfo { Title = "My API V2", Version = "v2" });
});
```

---

## ✅ Summary

- Use **Microsoft.AspNetCore.Mvc.Versioning** for built-in support.  
- Support multiple strategies (URL, query string, header).  
- Document versions with Swagger.  
