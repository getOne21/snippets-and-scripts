# 🚀 Angular – Extended Snippets & Commands

This document expands on the basics with advanced Angular patterns including NgRx, component communication, shared modules, and reusable structures.

---

## 📦 State Management with NgRx

### Key Concepts

- **Actions** → Describe state changes  
- **Reducers** → Define how state changes  
- **Selectors** → Query state efficiently  
- **Effects** → Handle async logic (API calls)

Install NgRx:

```bash
ng add @ngrx/store
ng add @ngrx/effects
ng add @ngrx/store-devtools
```

---

### 🧠 Basic Store Setup

Create actions:

```ts
// counter.actions.ts
import { createAction } from '@ngrx/store';

export const increment = createAction('[Counter] Increment');
export const decrement = createAction('[Counter] Decrement');
```

Create reducer:

```ts
// counter.reducer.ts
import { createReducer, on } from '@ngrx/store';
import { increment, decrement } from './counter.actions';

export const initialState = 0;

export const counterReducer = createReducer(
  initialState,
  on(increment, state => state + 1),
  on(decrement, state => state - 1)
);
```

Create effect:

```ts
// counter.effects.ts
@Injectable()
export class CounterEffects {
  loadCounters$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadCounters),
      mergeMap(() =>
        this.countersService.getAll().pipe(
          map(counters => loadCountersSuccess({ counters })),
          catchError(() => of(loadCountersFailure()))
        )
      )
    )
  );

  constructor(private actions$: Actions, private countersService: CountersService) {}
}
```

Register in module:

```ts
import { StoreModule } from '@ngrx/store';
import { counterReducer } from './state/counter.reducer';

@NgModule({
  imports: [
    StoreModule.forRoot({ count: counterReducer })
  ]
})
export class AppModule {}
```

Use in component:

```ts
constructor(private store: Store<{ count: number }>) {}

increment() {
  this.store.dispatch(increment());
}
```

---

## 🔄 Component Communication

### @Input / @Output Example

```ts
// parent.component.html
<app-child [message]="msg" (notify)="onNotify($event)"></app-child>

// child.component.ts
@Input() message: string;
@Output() notify = new EventEmitter<string>();
```

---

### ViewChild Reference

```ts
@ViewChild('searchInput') input: ElementRef;

ngAfterViewInit() {
  this.input.nativeElement.focus();
}
```

---

## ♻️ Shared Modules & Reusability

Create shared module:

```bash
ng g m shared
```

Use for:

- Common components
- Pipes
- Directives
- Reusable services

```ts
@NgModule({
  declarations: [MyPipe, MyComponent],
  exports: [MyPipe, MyComponent],
  imports: [CommonModule]
})
export class SharedModule {}
```

---

## 📁 Folder Structure Best Practices

```text
src/
├── app/
│   ├── core/         # singleton services, auth
│   ├── shared/       # shared module (pipes, directives)
│   ├── features/     # feature modules
│   ├── store/        # ngrx state
```

---

## 📄 Angular Universal (SSR)

```bash
ng add @nguniversal/express-engine
npm run dev:ssr
```

---

## 🧪 Unit Testing Snippet

```ts
it('should return correct value', () => {
  const result = service.add(2, 3);
  expect(result).toBe(5);
});
```

Mock service in test:

```ts
providers: [
  { provide: MyService, useValue: jasmine.createSpyObj('MyService', ['get']) }
]
```

## 🔔 Angular Signals (Angular 16+)

### Example Signal State

```ts
import { signal } from '@angular/core';

export class CounterService {
  count = signal(0);

  increment() {
    this.count.update(value => value + 1);
  }
}
```

### Example Component Usage

```ts
@Component({
  selector: 'app-counter',
  template: `
    <button (click)="service.increment()">Increment</button>
    <p>Count: {{ service.count() }}</p>
  `
})
export class CounterComponent {
  constructor(public service: CounterService) {}
}
```

---

## ✅ When to Use What

- **NgRx** → Large apps, complex state, multiple modules.  
- **Signals** → Small/medium apps, local state, simple reactive needs.  

---

## 📚 Resources

- [NgRx Docs](https://ngrx.io/docs)
- [Angular Universal](https://angular.io/guide/universal)
- [Angular Style Guide](https://angular.io/guide/styleguide)

---
