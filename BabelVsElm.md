### Old JS


```javascript
function pluralize(singular, plural, quantity)  {
  if (quantity === 1) {
    return singular;
  } else {
    return plural;
  }
}

console.log(pluralize("goose", "geese", 1));
```

---

### New JS

```javascript
var pluralize = (singular, plural, quantity) =>  {
  if (quantity === 1) {
    return singular;
  } else {
    return plural;
  }
}

console.log(pluralize("goose", "geese", 7));
```

---

### First Elm

```elm
import Html exposing (text)

pluralize singular plural quantity =
  if quantity == 1 then
    singular
  else
    plural

main =
  text (pluralize "goose" "geese" 1)
```

---

### JS Typo


```javascript
var pluralize = (singular, plural, quantity) =>  {
  if (quantity === 1) {
    return singluar; // <--- TYPO caught only at runtime
  } else {
    return plural;
  }
}

console.log(pluralize("goose", "geese", 7));
```

- In JS this causes a runtime error.
  - The bug sits there waiting, like a time bomb until that particular line of code is run, then :boom:
- Elm makes this impossible

---

### JS Type Error

```javascript
var pluralize = (singular, plural, quantity) =>  {
  if (quantity === 1) { // We'll ignore that we could use `==`
    return singular;
  } else {
    return plural;
  }
}

console.log(pluralize("goose", "geese", "1")); // <-- WRONG TYPE
```

???

No error at all this time, even at runtime. Your program is just wrong.

---

### Type Error in Elm

```elm
import Html exposing (text)

pluralize singular plural quantity =
  if quantity == 1 then
    singular
  else
    plural

main =
  text (pluralize "goose" "geese" "1")
```

???

Elm checks your entire program for integrity before it's ever run.
