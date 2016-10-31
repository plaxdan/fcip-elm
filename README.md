---
title: An Exploration of Elm
theme: css/theme/solarized.css
revealOptions:
    transition: 'fade'
---

# An Exploration of Elm

---

## Part 1 - Convergence
## Part 2 - Intro to Elm
## Part 3 - Why Elm is Different
## Part 4 - Working With Types
## Part 5 - Up and Running

---

<!-- .slide: data-background="hotpink" -->
<!-- .slide: data-transition="default" -->
# Part 1 - Convergence

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

## We've all been there

# Production project has an inconsistency

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

# Apply the fix...

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

## Things are changed in multiple places
## Functions fire out of order

Note: We've all seen those projects that are a bug-prone mess

---

## Multiple people have applied "quick fixes"
## Fear of breaking existing code

---

# You finally fix it

### but notice some weird edge-case or behavior...

---

# You don't have time to track down the cause

---

# fix the bug,
## not
# refactor an old code-base

Note: ain't nobody got time for that!

---

## So you wearily add another

# If/Else

## ...and move on

---

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

# Wonky!

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

1. Change wanted
1. Scrap the old
1. Create the new
1. ...goto step 1.

---

# You can do this with the DOM

---

<!-- .slide: data-background="#000" -->
![Imgur](http://i.imgur.com/PIDNzxY.png)
![Imgur](http://i.imgur.com/QGXEvM6.png)
![Imgur](http://i.imgur.com/UF7fPAy.png)

---

# data

# function(data)

# dom

---

![Imgur](http://i.imgur.com/uoFFxzF.png)

---

# We nest the boxes

![Imgur](http://i.imgur.com/leg2fVU.png)

---

### Render functions return a
# Description of the DOM

---

# As data

---

### The dirty work is left to...
# Virtual DOM

---

# data

# virtualdom(data)

# _...side effect_

---

### Virtual DOM is an
# Effect manager

---

# Works on your behalf...

- queue and batch update render "requests"
- minimize DOM mutation
- output cross-platform HTML

---

# Almost forget about the DOM

---

# Data in, DOM out

---

## Each box has it's own state

![Imgur](http://i.imgur.com/fGi5nho.jpg)

---

## Like good, OO Programmers

- our component state is _mutable_
- so we encapsulate it
- and provide "setter" or callback functions
- so others can modify a portion of our state

---

## State is...

![Imgur](http://i.imgur.com/fGi5nho.jpg)

- Still spread out
- Sometimes duplicated

---

## Centralize the state
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
  inventory: React.PropTypes.shape(
    {items: React.PropTypes.arrayOf(React.PropTypes.object)}
  ).isRequired
}
...
render() {
  if (this.props.inventory.items.length) {
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

## This is great!
![Imgur](http://i.imgur.com/jtNQLEa.png)
## You fix all the warnings

---

# We've come a long way!


| 💥 | ✅  |
|---|---|
| Mutating the DOM manually   | Virtual DOM  |
| State was spread out   | Now it's centralized  |
| Multi-directional data flow  | Uni-directional data flow  |
| Mutable shared state  | Immutable shared state  |
| No type checking  | Type checking UI props  |

---

## ✅ Part 1 - Convergence
## Part 2 - Intro to Elm
## Part 3 - Why Elm is Different
## Part 4 - Working With Types
## Part 5 - Up and Running

---

<!-- .slide: data-transition="default" -->
<!-- .slide: data-background="hotpink" -->
# Part 2 - Intro to Elm

---

![Imgur](http://i.imgur.com/q25B2pt.png)

---

![Imgur](http://xahlee.info/UnixResource_dir/gki/elm_logo.png)
