# .NET Best Practices: Clean Architecture, DI, and Testing

This guide provides best practices for structuring .NET applications using **Clean Architecture**, applying **Dependency Injection (DI)**, and ensuring testability.

---

## 🏗️ Clean Architecture Principles

- **Domain Layer** → Core business logic, entities, and interfaces.  
- **Application Layer** → Use cases, services, and business rules.  
- **Infrastructure Layer** → External concerns (databases, APIs, file system).  
- **Presentation Layer (UI/API)** → Controllers, views, or UI frameworks.

### Folder Structure Example

```text
src/
 ├─ Application/        # Use cases, services, interfaces
 ├─ Domain/             # Entities, value objects, core rules
 ├─ Infrastructure/     # EF Core, external APIs, file storage
 └─ WebAPI/             # Controllers, request/response handling
tests/
 ├─ UnitTests/
 └─ IntegrationTests/
```

---

## 🔌 Dependency Injection (DI)

### Example: Register Services

```csharp
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
```

### Example: Constructor Injection

```csharp
public class UserController : ControllerBase
{
    private readonly IUserService _userService;

    public UserController(IUserService userService)
    {
        _userService = userService;
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetUser(int id)
    {
        var user = await _userService.GetUserByIdAsync(id);
        return Ok(user);
    }
}
```

---

## 🧪 Testing

- **Unit Tests** → Test domain and application layer logic.  
- **Integration Tests** → Test controllers, DB, and external APIs.  
- **End-to-End Tests** → Test full scenarios (UI + backend).  

### Example: NUnit Unit Test

```csharp
[TestFixture]
public class UserServiceTests
{
    private UserService _service;

    [SetUp]
    public void Setup()
    {
        _service = new UserService();
    }

    [Test]
    public void CreateUser_ShouldReturnValidUser()
    {
        var user = _service.CreateUser("John");
        Assert.AreEqual("John", user.Name);
    }
}
```

---

## ✅ Summary

- Follow **Clean Architecture** to separate concerns.  
- Use **DI** for testability and flexibility.  
- Apply **unit, integration, and end-to-end tests** for robustness.  
