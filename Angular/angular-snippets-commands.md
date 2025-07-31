# 🚀 Angular – Essential Commands & Snippets

This document covers the most commonly used Angular CLI commands and useful snippets for quick reference and efficient development.

---

## 📦 Installation & Setup

Install Angular CLI globally:

```bash
npm install -g @angular/cli
```

Verify installation:

```bash
ng version
```

Create a new Angular application:

```bash
ng new my-app
cd my-app
ng serve
```

---

## 🛠️ Angular CLI Commands

### Generate Components & Services

```bash
ng generate component components/my-component
ng g c components/my-component --inline-template --skip-tests

ng generate service services/data
ng g s services/data
```

### Modules & Routing

```bash
ng generate module app-routing --flat --module=app
```

### Directives & Pipes

```bash
ng g directive directives/highlight
ng g pipe pipes/filterData
```

---

## 🚦 Running & Building the App

Serve locally:

```bash
ng serve
ng serve --open # auto-open browser
```

Build for production:

```bash
ng build --prod
```

---

## 🔍 Testing & Linting

Run unit tests:

```bash
ng test
```

Run end-to-end tests (using Cypress or Protractor):

```bash
ng e2e
```

Run linter:

```bash
ng lint
```

---

## 🚀 Deploying

Deploying to GitHub Pages quickly:

```bash
ng add angular-cli-ghpages
ng deploy --base-href=/<repo-name>/
```

---

## ⚙️ Environment Variables

Set environments (development, production):

```typescript
// environments/environment.prod.ts
export const environment = {
  production: true,
  apiUrl: 'https://api.example.com'
};
```

Use environment variables in services/components:

```typescript
import { environment } from '../environments/environment';

this.http.get(`${environment.apiUrl}/users`);
```

---

## 🔄 HTTP Client Example

Basic HTTP request using HttpClient:

```typescript
import { HttpClient } from '@angular/common/http';

constructor(private http: HttpClient) { }

getData() {
  return this.http.get('https://api.example.com/data');
}
```

---

## 🛣️ Routing Example

Define routes in `app-routing.module.ts`:

```typescript
const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: '**', component: PageNotFoundComponent }
];
```

Navigate programmatically:

```typescript
constructor(private router: Router) {}

goToAboutPage() {
  this.router.navigate(['/about']);
}
```

---

## 📡 Observables & RxJS Basics

Basic observable pattern:

```typescript
import { Observable } from 'rxjs';

const obs = new Observable(subscriber => {
  subscriber.next('First Value');
  subscriber.complete();
});

obs.subscribe({
  next(x) { console.log(x); },
  complete() { console.log('Done'); }
});
```

Common operators (map, filter):

```typescript
import { map, filter } from 'rxjs/operators';

source$.pipe(
  filter(item => item.id > 5),
  map(item => item.name)
).subscribe(name => console.log(name));
```

---

## 📚 Resources

- [Official Angular Docs](https://angular.io/docs)
- [RxJS Operators](https://rxjs.dev/operators)

---
