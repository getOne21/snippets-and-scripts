<img src="dotnet-logo.png" style="max-width:100px">

# .NET CLI Commands

The .NET CLI (`dotnet`) is a powerful tool for building, running, testing, and managing .NET applications from the command line.

---

## 📦 Project Management

```bash
dotnet new console -n MyApp            # Create new console app
dotnet new webapi -n MyApi             # Create new Web API project
dotnet new mvc -n MyWebApp             # Create new MVC web project
dotnet new classlib -n MyLibrary       # Create class library
dotnet new sln -n MySolution           # Create solution file
```

Add project to solution:

```bash
dotnet sln MySolution.sln add MyApp/MyApp.csproj
```

---

## ▶️ Build & Run

```bash
dotnet build                          # Build the solution
dotnet run                            # Run the app
dotnet run --project MyApp.csproj     # Run specific project
```

---

## 🧪 Testing

```bash
dotnet new xunit -n MyTests           # Create xUnit test project
dotnet test                           # Run tests
```

---

## 📥 Dependencies

```bash
dotnet add package <PackageName>      # Add NuGet package
dotnet restore                        # Restore dependencies
dotnet list package                   # List installed packages
```

---

## 🚀 Publishing

```bash
dotnet publish -c Release -o ./publish         # Publish app
dotnet publish -r win-x64 --self-contained     # Publish for specific runtime
```

---

## 🧹 Cleaning

```bash
dotnet clean                          # Clean output
```

---

## 🔧 Global Tools

```bash
dotnet tool install -g <tool-name>     # Install global tool
dotnet tool list -g                    # List installed global tools
dotnet tool update -g <tool-name>      # Update tool
```

Example:

```bash
dotnet tool install -g dotnet-ef       # Install EF Core CLI
```

---

## 🧰 Entity Framework Core (EF Core)

```bash
dotnet ef migrations add InitialCreate       # Add migration
dotnet ef database update                    # Apply migrations
dotnet ef dbcontext info                     # Show DbContext info
```

> 🔧 Ensure you have the EF Core tool installed:
> `dotnet tool install -g dotnet-ef`

---

## 🧪 SDK & Runtime Info

```bash
dotnet --version                    # .NET SDK version
dotnet --list-sdks                 # List installed SDKs
dotnet --list-runtimes            # List installed runtimes
```

---

## 🛠️ Project Templates

```bash
dotnet new list                   # List available templates
```

---

## 🔍 Project Information

```bash
dotnet list reference                # List project references
dotnet list package --vulnerable     # List packages with known vulnerabilities
```

---

## 📋 Scaffolding

Scaffold controllers/views with EF Core in ASP.NET projects:

```bash
dotnet aspnet-codegenerator controller -name MyController -m MyModel -dc MyDbContext --relativeFolderPath Controllers --useDefaultLayout --referenceScriptLibraries
```

> Ensure the ASP.NET scaffolding tool is installed:
>
> ```bash
> dotnet tool install -g dotnet-aspnet-codegenerator
> ```

---

## ⚙️ Runtime Management

Install additional runtimes:

```bash
dotnet install runtime               # Show runtime installation options
```

Check SDK compatibility:

```bash
dotnet --info                        # Detailed SDK/runtime info
```

---

## 📈 Performance and Diagnostics

Collect runtime diagnostics data:

```bash
dotnet counters monitor -p <pid>           # Monitor .NET runtime counters
dotnet trace collect -p <pid>              # Collect detailed trace logs
dotnet dump collect -p <pid>               # Collect memory dumps
```

Install diagnostics tools:

```bash
dotnet tool install --global dotnet-counters
dotnet tool install --global dotnet-trace
dotnet tool install --global dotnet-dump
```

---

## 🚧 Docker Integration

Generate Dockerfile for your .NET app:

```bash
dotnet new dockerfile --project MyProject.csproj
```

---

## 🌐 HTTP and Web Development Tools

Install `httprepl` for testing APIs:

```bash
dotnet tool install -g Microsoft.dotnet-httprepl
```

Run:

```bash
httprepl https://localhost:5001
```
