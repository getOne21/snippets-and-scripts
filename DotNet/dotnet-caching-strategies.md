# Caching Strategies in .NET: Redis & MemoryCache

This guide explains how to apply caching in **.NET** using **MemoryCache** and **Redis**.

---

## ⚡ MemoryCache (In-Memory)

Best for **single-server apps** where cache doesn’t need to be shared.

### Setup

```csharp
builder.Services.AddMemoryCache();
```

### Usage

```csharp
public class ProductService
{
    private readonly IMemoryCache _cache;

    public ProductService(IMemoryCache cache)
    {
        _cache = cache;
    }

    public string GetProduct(int id)
    {
        return _cache.GetOrCreate($"product-{id}", entry =>
        {
            entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(10);
            return $"Product {id} details";
        });
    }
}
```

---

## ☁️ Redis (Distributed Cache)

Best for **scalable apps** with multiple servers/containers.

### Redis Setup

```bash
dotnet add package Microsoft.Extensions.Caching.StackExchangeRedis
```

```csharp
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = "localhost:6379";
});
```

### Redis Usage

```csharp
public class CartService
{
    private readonly IDistributedCache _cache;

    public CartService(IDistributedCache cache)
    {
        _cache = cache;
    }

    public async Task SaveCartAsync(string userId, string cartData)
    {
        await _cache.SetStringAsync(userId, cartData,
            new DistributedCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(30)
            });
    }

    public async Task<string> GetCartAsync(string userId)
    {
        return await _cache.GetStringAsync(userId);
    }
}
```

---

## ✅ Best Practices

- Use **MemoryCache** for quick, per-instance caching.  
- Use **Redis** for distributed, persistent caching.  
- Always set expiration to avoid stale data.  
- Cache **read-heavy data**, not frequently changing writes.  
