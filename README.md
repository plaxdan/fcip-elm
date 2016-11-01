---
title: An Exploration of Elm
revealOptions:
    transition: 'fade'
---

# An Exploration of Elm

---

<!-- .slide: data-background="#FBB917" -->
<!-- .slide: data-transition="default" -->
## Part 1 - Background
### Part 2 - Intro to Elm
### Part 3 - Why Elm is Different
### Part 4 - Type System
### Part 5 - Up and Running

Note: our programs consist of a combination of state and behavior

---

## State

- All the information pertaining to your program at a given instant in time.

## Behavior

- How state is displayed and changed over time _...logic_

- Changes made to the external world _...side effects_


Note: The way that state, logic, and side-effects are managed in web applications has evolved significantly during my time as a developer.

---

### Interact with a webapp over time...

![Website](http://i.imgur.com/4GjcL9e.png)

Note: it becomes different as you interact with it

---

### Where do developers track all these changes?

![Website](http://i.imgur.com/4GjcL9e.png)

Note: it becomes different as you interact with it

---

## Traditional answer:
# All over the place

Note: historically the answer has been: all over the place.

---

# Use the tools
# available to us

Note: most of use are not writing tools, we're using them

---

## Early days...

# JavaScript
# DOM

Note: in the early days, we relied on the DOM

---

## Common to store state in the DOM

```html
<table>
	<thead>
		<tr>
			<th id="tHead" data-format-string="Do MMMM YYYY">
        ...
      </th>
			...
		</tr>
	</thead>
	<tr>
		<td id="dCell" data-value="975683133000"><!-- 1st December 2000 --></td>
	</tr>
	...
</table>
```

---

### Read and write to the DOM

```html
<table>
	<thead>
		<tr>
			<th id="tHead" data-format-string="Do MMMM YYYY">
        ...
      </th>
			...
		</tr>
	</thead>
	<tr>
		<td id="dCell" data-value="975683133000"><!-- 1st December 2000 --></td>
	</tr>
	...
</table>
```

```javascript
var dateFormat = document.getElementById('tHead');
var dateCell = document.getElementById('dCell');

dateFormat.dataset.formatString // "Do MMMM YYYY"
dateCell.dataset.indexNumber // "975683133000"
// format the date
dateCell.innerHTML = formattedDate;
```

---

# Lots of DOM work

---

## So we invented DOM tools

- jQuery
- Scriptaculous
- Prototype
- Mootools
- etc...

Note: so we invented tools to help with DOM work and carried on.

---

### We've all been there

# Production project

### has an inconsistency

Note: Checked, not checked, Visible, not visible, Expanded, not expanded

---

# You're busy

---

# Multiple Projects
# Upcoming Deadlines

---

# It's on you

Note: you have to fix it anyway. You're the developer.

---

![Imgur](http://i.imgur.com/RD1RE0m.png)

- REPRODUCE
- TRACK IT DOWN
- FIX IT

Note: you spend a lot of time just getting to the point when you're ready to make a change.

---

# YOU THINK YOU'VE FOUND IT!

---

# _Apply the fix..._

---

# Still broken!!!

---

# I'm not supposed to be working on this today!

---

# Why didn't that fix it?

- Same state is in two different places?
- More than one thing can change this?

---

# Maybe you did fix it?

---

## But you broke something else!

![Whackamole](http://i.imgur.com/ffLQlGM.png)

---

### Data is being changed from
# multiple places
### Event handlers fire
# unpredictable order

Note: We've all seen those projects that are a bug-prone mess

---

### Multiple people have applied "quick fixes"
# Fear
### of breaking existing code

---

# You finally fix it

### but notice some weird edge-case or behavior...

---

### But you
# don't have time
### to track down the cause

---

### You're supposed to just
# fix the bug
### not refactor an old project

Note: ain't nobody got time for that!

---

### So you wearily add another

# if/else

### ...and move on

---

## And that's how monsters are created

![Imgur](http://i.imgur.com/sz6iqnb.png)

Note: and that's how monstrous weeds grow.

---

## Make things nicer

![Imgur](http://i.imgur.com/eU22ELO.png)

- Models
- Templates
- Event bus
- Two way data-binding

---

<!-- .slide: data-background="./apartment.jpg" -->
<!-- .slide: data-background-transition="zoom" -->

---

# But, the picture is wonky

---

<!-- .slide: data-background="./disaster-girl.jpg" -->

---

<!-- .slide: data-background="./apartment.jpg" -->
<!-- .slide: data-background-transition="zoom" -->

Note: wasteful, but easy to reason about

---

## When a change is wanted

- scrap the previous version
- create a new one - almost identical
- but it has this one change

---

# You can do this with the DOM

---

<!-- .slide: data-background="#000" -->
![Imgur](http://i.imgur.com/PIDNzxY.png)
![Imgur](http://i.imgur.com/QGXEvM6.png)
![Imgur](http://i.imgur.com/UF7fPAy.png)

---

## `data`

## `function(data)`

## `dom`

---

## `<Components/>`

- initialized with properties
- own and manage their own state
- can be nested inside each other
- render DOM elements

---

# We nest the boxes

![Imgur](http://i.imgur.com/leg2fVU.png)

---

### `render()` function returns a
# Description
...of the DOM

---

# As data

---

`virtualdom(data)`

# _...side effect_

---

Virtual DOM is an
# Effect manager

---

Works on your behalf...

- queue and batch update render "requests"
- minimize DOM mutation
- output cross-platform HTML

---

## Almost forget about the DOM

---

## Data in, DOM out

---

## Each component has it's own state

![Imgur](http://i.imgur.com/fGi5nho.jpg)

---

## State is...

![Imgur](http://i.imgur.com/fGi5nho.jpg)

- Still spread out
- Sometimes duplicated

---

### Centralize the state
# Pass it down

---

# Single
# source of truth

---

# To change the state
### components dispatch messages

---

### Owner of the state
# creates a new state
### in response

---

### and passes it
# down

![Imgur](http://i.imgur.com/fGi5nho.jpg)

---

![Imgur](http://i.imgur.com/8TGP3R7.png)

---

### With a single state object anyone can
# mutate state
### with object references

---

### So now we make our state object
# immutable

- Immutable.JS
- SeamlessImmutable
- ...

---

# Looking good so far

---

## Inventory was refactored

```javascript
// It used to be an array...
var inventory = [
  {name: "Gloves", quantity: 3},
  {name: "Valves", quantity: 7}
]

// But now it's an object...
var inventory = {
  assignedTo: "WAREHOUSE 1",
  items: [
    {name: "Gloves", quantity: 3},
    {name: "Valves", quantity: 7}
  ]
}
```

---

## It broke our code
```javascript
render() {
  if (this.props.inventory.length) {
    return (
      <div>
        this.props.inventory.map(x => {
          return <InventoryItem item={x}/> });
      </div>
    );
  } else {
    return "There are no inventory items.";
  }
}
```
## But no error is thrown

---

## Tools are invented

![Imgur](http://i.imgur.com/4k72vkM.png)

---

## You try it, and get an early warning

```javascript
propTypes: {
  inventory: React.PropTypes.object.isRequired
}
...
render() {
  if (this.props.inventory.items.length) {
    return (
      <div>
        this.props.inventory.map(x => {
          return <InventoryItem item={x}/>
        });
      </div>
    );
  } else {
    return "There are no inventory items.";
  }
}
```

---

## This is great!
![Imgur](http://i.imgur.com/jtNQLEa.png)
## You fix all the warnings

---

## We've come a long way!


| 💥 Early JS| Recent JS |
|---|---|
| Mutating the DOM manually   | Virtual DOM  |
| State was spread out   | Now it's centralized  |
| Multi-directional data flow  | Uni-directional data flow  |
| Mutable shared state  | Immutable shared state  |
| Silent type errors  | Type checking UI props  |

---

<!-- .slide: data-transition="default" -->
<!-- .slide: data-background="#FBB917" -->
### Part 1 - Background
## Part 2 - Intro to Elm
### Part 3 - Why Elm is Different
### Part 4 - Type System
### Part 5 - Up and Running

---

![Imgur](http://i.imgur.com/q25B2pt.png)
![Imgur](http://xahlee.info/UnixResource_dir/gki/elm_logo.png)

---

## Values

```elm
> "hello"
"hello" : String

> "hello" ++ "world"
"helloworld" : String

> "hello" ++ " world"
"hello world" : String
```  

---

```elm
> 2 + 3 * 4
14 : Int

> (2 + 3) * 4
20 : Int

> 9 / 2
4.5 : Float

-- Integer division
> 9 // 2
4 : Int
```

---

## If Expressions

```elm
> if True then
    "hello"
  else
    "world"

"hello" : String

> if False then
    "hello"
  else
    "world"

"world" : String
```

---

## Equality

All of Elm is immutable.

```elm
> 1 == 2
False : Bool

> "banana" == "banana"
True : Bool
```
Everything's a value _(no `===`)_

---

## Strongly Typed

```elm
> 1 == "1"
-- TYPE MISMATCH --------------------------------------------- repl-temp-000.elm

The right argument of (==) is causing a type mismatch.

3|   1 == "1"
          ^^^
(==) is expecting the right argument to be a:

    number

But the right argument is:

    String
```

---

## Lists

Lists hold values of the same type.

```elm
> names = [ "Alice", "Bob", "Eve" ]
["Alice","Bob","Eve"]

> List.isEmpty names
False

> List.length names
3

> List.reverse names
["Eve","Bob","Alice"]

> double n = n * 2
<function>

> List.map double [1,2,3,4]
[2,4,6,8]
```

---

## Records

```elm
> point =
    { x = 3
    , y = 4
    }

> point.x
3

> bill =
    { name = "Gates"
    , age = 57
    }

> bill.name
"Gates"
```

---

`.name` is a function that gets the name field of the record.

```elm
> .name bill
"Gates"

> List.map .name [bill,bill,bill]
["Gates","Gates","Gates"]
```

---

## Tuples

A tuple holds a **fixed** number of values

```elm
import String

validateName name =
  if String.length name <= 20 then
    (True, "name accepted!")
  else
    (False, "name was too long; please limit it to 20 characters")

> validateName "Tom"
(True, "name accepted!")
```


---

Each value can have any type

```elm
> (12.6, "banana", ["a", "b", "c"], False, {name = "Bill"})

  : ( Float, String, List String, Bool, { name : String } )
```

---

## Functions

```elm
isNegative n =
  n < 0

> isNegative 4
False : Bool

addThese this that =
  this + that

> addThese 7 9
16 : number

-- anonymous functions
squares = List.map (\x -> x * x) [-3,-2,-1,0,1,2,3]
[9,4,1,0,1,4,9] : List number
```

---

Functions are auto-curried.

```elm
> divide x y =
    x / y
<function> : Float -> Float -> Float
```

---

```elm
> divideTwelve = divide 12
<function> : Float -> Float

> divideTwelve 3
4 : Float
```

---

Something similar in JavaScript

```javascript
var myCurriableFunction = function (x, y, z) {
  return function (y, z) {
    x + y + z;
  }
}

myCurriableFunction(2)(3, 4)
```

---

All functions are auto-curried in Elm.

```elm
String.repeat 3 "hi"
-- "hihihi" : String

String.repeat
-- <function:repeat> : Int -> String -> String

threeTimes = String.repeat 3
-- <function> : String -> String

threeTimes "hi"
-- "hihihi" : String
```

---

This allows for elegant composition (pipelining)...

```elm
"Fort Collins"
  |> String.repeat 2
  |> String.reverse
  |> String.map (\char -> if char == 'o' then 'x' else char)
  |> String.toUpper

"SNILLXC TRXFSNILLXC TRXF" : String
```

---

## Back to the Pluralizer Example

```elm
pluralize singular plural quantity =
    if quantity == 1 then
        singular
    else
        plural
```

Let's add some interactivity...

---

# Types

One of Elm's major benefits is that users do not see runtime errors in practice.

---

This is because of **type inference**. The compiler figures out what type of values flow in and out of _**all**_ your functions.

---

```elm
-- TYPE MISMATCH ---------------------------------------------------------------

The argument to function `toFullName` is causing a mismatch.

6│   toFullName { fistName = "Hermann", lastName = "Hesse" }
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Function `toFullName` is expecting the argument to be:

    { …, firstName : … }

But it is:

    { …, fistName : … }

Hint: I compared the record fields and found some potential typos.

    firstName <-> fistName
```

---

No matter how big and complex things get, the Elm compiler checks that **everything** fits together properly just based on the source code.

Note: Especially valuable with multiple collaborators.

---

You can actively use Elm's **type system** to improve the **correctness** and **maintainability** of your code.

---

### Back to the Pluralizer Example

```elm
pluralize singular plural quantity =
    if quantity == 1 then
        singular
    else
        plural
```

Let's introduce some
- type annotations
- a new custom type

---

## Pit of success

The **good practices** that we're seeing convergence on in JS land, are inescapable in Elm.

---

TODO: maybe kill?

| 💥 Early JS | Recent JS  | React | Elm
|---|---|---|
| Mutating the DOM manually   | Virtual DOM  | React |  Elm |
| State was spread out   | Now it's centralized  | Redux | Elm |
| Multi-directional data flow  | Uni-directional data flow | Redux |  Elm |
| Mutable shared state  | Immutable shared state  | Immutable.js | Elm |
| Silent type errors  | Type checking UI props  | PropTypes/Flow | Elm

---

JS Frameworks are now Emulating Elm

- http://redux.js.org/
- https://github.com/dvajs/dva
- https://github.com/yoshuawuyts/choo

---

<!-- .slide: data-transition="default" -->
<!-- .slide: data-background="#FBB917" -->
### Part 1 - Background
### Part 2 - Intro to Elm
## Part 3 - Why Elm is Different
### Part 4 - Type System
### Part 5 - Up and Running

---

Every Elm program is composed 100% of

# PURE FUNCTIONS

Note: you can truly say that Elm is a functional programming language.

---

## But what is a pure function?

---

Can anyone spot the hidden **side-effect**?

```javascript
todoList.addTodo = function() {
  todoList.todos.push({text: todoList.todoText, done: false});
  todoList.todoText = '';
}
```

---

A function that **returns nothing** can only be called for its side effects.

---

Can anyone spot the **side-cause**?

```JavaScript
todoList.remaining = function() {
  var count = 0;
  angular.forEach(todoList.todos, function(todo) {
    count += todo.done ? 0 : 1;
  });
  return count; // We ARE returning something this time.
}
```

---

### There are no arguments

- So either: return the **same value** every time
- There is a **hidden argument**
  - Changes the behavior of this code each time it's called.

---


### Every language supports pure functions

```javascript
var adder = function(a, b) {
  return a + b;
}
```
So what makes a language functional?

---

### Kris Jenkins:

> "Functional Programming is about **eliminating side effects** where you can and **controlling them** where you can’t, and that will lead you on a very interesting journey."

---

### Kris Jenkins:
> "It is my deep hope that in the morning, you will go to your computer, and you will see side-effects everywhere."

---

### Kris Jenkins:
> "And it will ruin your lives, and torture you for years..."

---

### Kris Jenkins:
> "...and it will also make you a much better programmer." - [@krisajenkins](https://twitter.com/krisajenkins)

---

### Simon Peyton Jones

- Researcher at Microsoft Research
- https://www.youtube.com/v/iSmkqocn0oQ?start=18&end=115

---

![Imgur](http://i.imgur.com/cu0EOhg.png)

---

Every Elm program is composed 100% of

# PURE FUNCTIONS

(no side-effects)

---

So, how do we do anything **useful**?

---

Remember the Virtual DOM?
```javascript
render() {
  if (this.props.inventory.length) {
    return (
      <div>
        this.props.inventory.map(x => {
          return <InventoryItem item={x}/> });
      </div>
    );
  } else {
    return "There are no inventory items.";
  }
}
```

---

`render()` function returns a
# Description
...of the DOM **as data**

---

`virtualdom(data)`

# _...side effect_

---

Virtual DOM is an
# Effect manager
...for the DOM

---

Elm is an
# Effect Manager
...for **EVERYTHING**

---

### Time

---

### Time
### Randomness

---

### Time
### Randomness
### DOM

---

### Time
### Randomness
### DOM
### HTTP

---

### Time
### Randomness
### DOM
### HTTP
### WebSockets

---

### Time
### Randomness
### DOM
### HTTP
### WebSockets
### Storage

---

### Time
### Randomness
### DOM
### HTTP
### WebSockets
### Storage

...you get the idea.

---

Pure functions describe these effects
## as data

---

Something produces a **`Cmd`**...

![Imgur](http://i.imgur.com/OdGdsdj.png)

...Elm returns a **`Msg`**

---

<!-- .slide: data-background="#fff" -->

### Commands can come from

- **`Html`** - the user, event in the HTML
- **`Cmd`** - your code, returning `Cmd` from a function
- **`Sub`** - a subscription, time, websocket etc

![Elm Runtime](https://guide.elm-lang.org/architecture/effects/program.svg)

---

You will **never** see code like this in Elm...

Time

```javascript
var timeInMs = Date.now()
//-> 1477950154376

timeInMs = Date.now() // no arguments
timeInMs = Date.now() // each call returns a different value
```

Randomness

```javascript
var randomFloat = Math.random()
//-> 0.4274841726102241

randomFloat = Math.random() // no arguments
randomFloat = Math.random() // each call returns a different value
```

---

You ask for these things with a **`Cmd`**...

![Imgur](http://i.imgur.com/OdGdsdj.png)

...Elm returns them to you in a **`Msg`**

---

## Tradeoff

We either move **simple** things (time, random) to **controlled** environment

Or we move **complex** things (your entire codebase) to **uncontrolled** environment

---

This is the **major difference** between Elm and its competitors...

- All functions are pure
- All side effects are controlled

---

That means asynchronous and side-effectful functions are:
- easily understood (and usually smaller)
- easily identified by their return type: `Cmd`
- easily testable (data in, data out, no mocking)

---

This is a huge benefit for **maintanability**.

---

<!-- .slide: data-transition="default" -->
<!-- .slide: data-background="#FBB917" -->
### Part 1 - Background
### Part 2 - Intro to Elm
### Part 3 - Why Elm is Different
## Part 4 - Type System
### Part 5 - Up and Running

---

Elm **lifts** side effects into its type system.

**`Cmd`**

---

But there are many other hazards for our programs...

---

But there are many other hazards for our programs...

### Null / undefined

---

But there are many other hazards for our programs...

### Null / undefined
### Exceptions

---

But there are many other hazards for our programs...

### Null / undefined
### Exceptions
### Invariants

---

As you probably guessed, these are also handled by the type system.

---

"Algebraic data types"

"Discriminated union types"

"Union types"

---

Similar concept to an `enum` that you might have seen in other languages.

---

## Example

```elm
type Bool   -- type
  = True    -- constructor or 'case'
  | False   -- constructor or 'case'
```

**NOT** a constructor in the OO sense. These are values, and the compiler will enforce that all possible cases of a union type are handled in your code.

---

Create your own for modeling your data...

```elm
type GamePhase
  = Ready
  | InProgress
  | Won
  | Lost
```

_(we'll get back to this when we talk about 'invariants')_

---

## Null / undefined

![Imgur](http://i.imgur.com/SaT3FH7.png)

---

![Imgur](http://i.imgur.com/ixqA7lP.png)

---

```elm
List.head ["Alice", "Bob", "Eve"]
> ...?

List.head []
> ...?
```

Let's try....

---

`Maybe` is a union type...

```elm
type Maybe a
    = Just a
    | Nothing
```

Represents values that may or may not exist.

---

The compiler forces you to handle each case...

```elm
names = ["Alice", "Bob", "Eve"]
first = List.head names

case first of
  Nothing
    -- ... the list was empty

  Just value ->
    -- ... succeed with value
```

Sometimes you just provide a default...

```elm
names = ["Alice", "Bob", "Eve"]
first = Maybe.withDefault "NONE" (List.head names)
```

---

Use **`Maybe`** in your data models:

```elm
type alias PersonName =
    { first : String        -- required
    , middle : Maybe String -- optional
    , last : String         -- required
    }
```

---

If a **`Maybe`** is not handled, your code **will not compile**.

http://package.elm-lang.org/packages/elm-lang/core/latest/Maybe

---

An **entire category** of
# Future bugs

![Sarah Connor](http://i.imgur.com/JNTncdq.png)

...is wiped from existence.

---

### ✅ Null / undefined
### Exceptions
### Invariants

---

## Exceptions

![Imgur](http://i.imgur.com/xFMWnZF.png)

---

Exceptions are **lifted** into the type system just like **side effects** and **nulls**.

---

`Result error value`

```elm
type Result error value
    = Ok value
    | Err error
```

A `Result` is either `Ok` meaning the computation succeeded, or it is an `Err` meaning that there was some failure.

---

The Elm compiler will ensure `Result` is used for any operation that might fail.

- conversions
- accessing http
- accessing storage
- etc...

---

```elm
numberString = "1664"
result = String.toInt numberString

case result of
  Err msg ->
    -- ... fail with message

  Ok value ->
    -- ... succeed with value
```

Again, you can provide a default...

```elm
numberString = "This ain't right"
result = Result.withDefault 0 (String.toInt numberString)

-- alternate syntax using the backwards pipe (fewer parens)
result = Result.withDefault 0 <| String.toInt numberString

-- alternate syntax using forwards pipe
result =
  numberString
    |> String.toInt
    |> Maybe.withDefault 0
```

---

Say goodbye to **runtime exceptions**...

![Sarah Connor](http://i.imgur.com/JNTncdq.png)

---

### ✅ Null / undefined
### ✅ Exceptions
### Invariants

So what is an invariant anyway?

---

**Quesion:** What kind of person would model a light bulb like this?

```javascript

// JavaScript model of a light bulb...

var bulb = {
  on: true,
  off: false
}
```

---

**Answer**: Only a maniac.

```javascript
var bulb = {
  on: true,
  off: true
}
```

It's only a matter of time before we get into an illegal state.

---

This is a silly example
of an

## invariant

---

Just like with **Kris Jenkins'** side effects,
### once you start looking
you will notice **invariants**
### all over your code

---

We start with a simple model for a Contact

```elm
type alias Contact =
    { name : String
    , email : String
    , address : String
    }
```

---

Then you learn that email and address are optional, but the a Contact must have at least one contact method.

```elm
type alias Contact =
    { name : String
    , email : String
    , address : String
    }
```

---

We could make `Maybe` to make them both optional...

```elm
type alias Contact =
    { name : String
    , email : Maybe String
    , address : Maybe String
    }
```

---

But it's still possible to create a Contact in an invalid state:

```elm
-- we're supposed to have at least one contact method...
dude =
  { name = "Jeffrey Lebowski"
  , email = Nothing
  , address = Nothing
  }
```

---

Valid Option 1

```elm
type ContactMethod
    = EmailOnly String
    | AddressOnly String
    | EmailAndAddress (String, String) -- we use a Tuple
```

```elm
type alias Contact =
    { name : String
    , contactMethod : ContactMethod
    }
```

---

Try it out...

```elm
dude =
  { name = "Jeffrey Lebowski"
  , contactMethod = EmailOnly "el_duderino@yahoo.com"
  }
```

```elm
dude =
  { name = "Jeffrey Lebowski"
  , contactMethod = AddressOnly "11304 Malibu Heights"
  }
```

```elm
dude =
  { name = "Jeffrey Lebowski"
  , contactMethod =
      EmailAndAddress ("el_duderino@yahoo.com", "11304 Malibu Heights")
  }
```

---

Valid Option 2

```elm
type ContactMethod
  = Email String
  | Address String

type alias Contact =
  { name : String
  , primaryContact : ContactMethod
  , secondaryContact : Maybe ContactMethod
  }
```

---

Let's try it out...

```elm
dude =
  { name = "Jeffrey Lebowski"
  , primaryContact = Email "el_duderino@yahoo.com"
  , secondaryContact = Nothing
  }
```

```elm
dude =
  { name = "Jeffrey Lebowski"
  , primaryContact = Address "11304 Malibu Heights"
  , secondaryContact = Nothing
  }
```

```elm
dude =
  { name = "Jeffrey Lebowski"
  , primaryContact = Email "el_duderino@yahoo.com"
  , secondaryContact = Just "11304 Malibu Heights"
  }
```

---

Option 3

```elm
type ContactMethod
  = Email String
  | Address String
```

```elm
type alias Contact =
  { name : String
  , contactMethod : ContactMethod
  , alternateContactMethods : List ContactMethod
  }
```

---

With our first model, we had to rely on

```elm
type alias Contact =
    { name : String
    , email : Maybe String
    , address : Maybe String
    }
-- it's possible for email and address to both be Nothing
```

### Programmer Correctness

---

### We could live with this.

---

### We could live with this.
### Most of us **do** live with this.

---

### We could live with this.
### Most of us **do** live with this.
### We just communicate the rules to everyone.

---

### We could live with this.
### Most of us **do** live with this.
### We just communicate the rules to everyone.
### Remember to tell the new guy.

---

### We could live with this.
### Most of us **do** live with this.
### We just communicate the rules to everyone.
### Remember to tell the new guy.
### Maybe write some sweet comments in our code.

---

### We could live with this.
### Most of us **do** live with this.
### We just communicate the rules to everyone.
### Remember to tell the new guy.
### Maybe write some sweet comments in our code.
### We might even write tests!

---

### ~~We could live with this.~~
### ~~Most of us **do** live with this.~~
### ~~We just communicate the rules to everyone.~~
### ~~Remember to tell the new guy.~~
### ~~Maybe write some sweet comments in our code.~~
### ~~We might even write tests!~~

---

**type system** + **compiler** help make **invariants**

![Sarah Connor](http://i.imgur.com/JNTncdq.png)

# impossible

---

### ✅ Null / undefined
### ✅ Exceptions
### Invariants

---


| 💥 | ✅ |
| --- | --- |
| null / undefined | `Maybe a` |
| exceptions | `Result error value` |
| invariants | types + compiler |
| side effects | `Cmd msg` |
| mutable shared state | all data immutable |
| mutating the dom manually | virtual dom |
| state was spread out   | centralized state  |
| multidirectional data flow  | unidirectional data flow  |
| silent type errors  | strong type system  |

---

<!-- .slide: data-background="#FBB917" -->
<!-- .slide: data-transition="default" -->
### Part 1 - Background
### Part 2 - Intro to Elm
### Part 3 - Why Elm is Different
### Part 4 - Type System
## Part 5 - Up and Running

---

TODO:

Installing and getting going
- `npm i -g elm`
- `mkdir my-proj && cd py-proj`
- `elm package install`
- `atom Main.elm`

Elm package manager
- enforced semantic versioning
- diff versions

Elm packages

Timeline (compared to python)

.....

---

<!-- .slide: data-background="#FBB917" -->
<!-- .slide: data-transition="default" -->
# People
- Kris Jenkins (London) [@krisajenkins](https://twitter.com/krisajenkins)
- Richard Feldman (NoRedInk) [@rtfeldman](https://twitter.com/rtfeldman)
- Simon Peyton Jones (Microsoft Research) [Google him](https://www.google.com/search?q=simon+peyton+jones)
- Yaron Minsky (Jane Street) [@yminksy](https://twitter.com/yminsky)

---

<!-- .slide: data-background="#FBB917" -->
<!-- .slide: data-transition="default" -->
# Tools
- Elm: http://elm-lang.org
- Markdown presentation: https://github.com/webpro/reveal-md

---

<!-- .slide: data-background="#FBB917" -->
<!-- .slide: data-transition="default" -->
# Links

I'll be adding these soon.....
