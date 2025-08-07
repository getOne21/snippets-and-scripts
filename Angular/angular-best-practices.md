# 🌟 Angular – Architecture, Patterns & Best Practices

This guide focuses on advanced Angular concepts including scalable architecture, form handling, performance tuning, and tooling.

---

## 🧱 Feature-Based Architecture

Organize code by **feature**, not technical type:

```diagram
app/
├── features/
│   ├── dashboard/
│   │   ├── dashboard.component.ts
│   │   ├── dashboard.module.ts
│   │   └── state/
│   └── auth/
│       ├── login.component.ts
│       ├── auth.service.ts
│       └── guards/
├── core/
│   ├── interceptors/
│   ├── services/
├── shared/
│   ├── components/
│   ├── pipes/
│   └── directives/
```

---

## 🧾 Forms: Reactive & Custom Validators

### Reactive Form Example

```ts
form = this.fb.group({
  email: ['', [Validators.required, Validators.email]],
  password: ['', Validators.required]
});
```

### Custom Validator

```ts
function noSpecialChars(control: AbstractControl): ValidationErrors | null {
  const valid = /^[a-zA-Z0-9]*$/.test(control.value);
  return valid ? null : { invalidChars: true };
}
```

---

## ⚡ Performance Tips

- Use `ChangeDetectionStrategy.OnPush`
- Lazy-load feature modules
- Avoid inline functions and complex bindings in templates
- TrackBy for `*ngFor`

---

## 🔐 Auth & Route Guards

```ts
canActivate(route: ActivatedRouteSnapshot): boolean {
  return this.authService.hasRole('admin');
}
```

Setup `HttpInterceptor` for token injection:

```ts
intercept(req, next): Observable<HttpEvent<any>> {
  const authReq = req.clone({ setHeaders: { Authorization: 'Bearer TOKEN' }});
  return next.handle(authReq);
}
```

---

## 🌐 Internationalization (i18n)

```bash
ng add @angular/localize
```

Usage in templates:

```html
<p i18n="@@welcomeMsg">Welcome to our app!</p>
```

---

## 🧰 Developer Tooling

- ✅ **ESLint**: `ng add @angular-eslint/schematics`
- 🧪 **Spectator** for simplified testing
- 🐺 **Husky** + **Lint-staged** for git commit quality
- 💥 **Commitlint** + Conventional Commits

---

## 📦 Angular Libraries & Monorepo with Nx

```bash
npx create-nx-workspace@latest
```

- Isolate libraries per domain
- Built-in caching and workspace generators

---

## 💡 Useful Additions

- 🧩 Angular Material with theming
- 🛰️ WebSocket/SignalR support
- 📱 PWA (`ng add @angular/pwa`)
- 🔌 Offline-first strategies

---

## 🧪 E2E Testing with Cypress

```bash
ng add @cypress/schematic
```

Sample Cypress test:

```js
describe('Homepage', () => {
  it('should show title', () => {
    cy.visit('/');
    cy.contains('Welcome');
  });
});
```

---

## 🧠 Recommended Resources

- [Angular Style Guide](https://angular.io/guide/styleguide)
- [Angular Performance Checklist](https://web.dev/angular/)
- [NgRx Patterns & Techniques](https://ngrx.io/guide/store)

---
