# Componenets and Props
*Source: [ReactJS Docs](https://reactjs.org/docs/components-and-props.html) (heavily copied for offline reference)*

- Components let you split the UI into independent, reusable pieces.
- [Component API Reference (full)](https://reactjs.org/docs/react-component.html)

---

## Function and Class Components

### Function Component

The simplest way to define a component is to write a JS fxn:
```JSX 
function Welcome(props) {
  return <h1>Hello, {this.props.name}</h1>;
}
```

- This is a valid React component because it accepts a single `props` (short for "properties") object argument with data and returns a React element.

### Class Component

An [ES6 class](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes) can also define a component:
```JSX 
class Welcome extends React.Component {
  render() { 
    return <h1>Hello, {this.props.name} </h1>;
  }
}
```

### Converting a Funtion to a Class

You can convert a function component like to a class in five steps:

  1. Create an ES6 class, with the same name, that extends `React.Component`.
  2. Add a single empty method to it called `render()`.
  3. Move the body of the function into the `render()` method.
  4. Replace props with `this.props` in the `render()` body.
  5. Delete the remaining empty function declaration.

---

## Rendering a Component 

React elements can represent a DOM tag directly: 
  ```JSX 
  const ele = <div />;
  ```
Or elements can represent user-defined components:
  ```JSX
  const element = <Welcome name="Sara" />;
  ```
When react sees an element representing a user-defined component, it passes JSX attributes and children to this component as a single object.  We call this object **"props"**.

This code will render "Hello, Sara" on the page:
  ```JSX 
  function Welcome(props) {
    return <h1>Hello, {props.name} </h1>;
  }

  const element = <Welcome name="Sara" />;
  ReactDOM.render(
    element, document.getElementById('root')
  )
  ```
So what is happening here?
  1. Call `ReactDom.render()` with the `<Welcome name="Sara" />` element.
  2. React calls `Welcome` component with `{name: 'Sara'}` as the props.
  3. `Welcome` component returns `<h1>Hello, Sara</h1>` element as the result.
  4. React DOM updates the DOM to match `<h1>Hello, Sara</h1>`. 

> ** NOTE: Always start component names with a capital letter.**   
> *React treats components starting with a lowercase letter as DOM tags. A component is required to be in scope is another difference.   
>   Component: `<Welcome />`  
>   DOM tag: `<div />`*

---

## Composing Components 

Components can refer to other components in their output. This lets us use the same component abstraction for any level of detail. A button, a form, a dialog, a screen: in React apps, all those are commonly expressed as components.

For example, we can create an `App` component that renders `Welcome` many times:
  ```JSX 
  function Welcome(props) {
    return <h1>Hello, {props.name}</h1>;
  }

  function App() {
    return (
      <div> 
        <Welcome name="Sara" />
        <Welcome name="Cahal" />
        <Welcome name="Edite" />
      </div>
    );
  }

  ReactDom.render(
    <App />,
    document.getElementById('root')
  );
  ```
>Most new React apps have a single `App` component at the very top.  However, if you integrate into an existing app, you might start bottom-up with a small component like `Button` and gradually work your way to the top of the view hierarchy.

---

## Extracting Components 

Components can be split into smaller components: 
  ```JSX
  function Comment(props) {
    return (
      <div className="Comment">
        <div className="UserInfo">
          <img className="Avatar"
            src={props.author.avatarUrl}
            alt={props.author.name}
          />
          <div className="UserInfo-name">
            {props.author.name}
          </div>
        </div>
        <div className="Comment-text">
          {props.text}
        </div>
        <div className="Comment-date">
          {formatDate(props.date)}
        </div>
      </div>
    );
  }
  ```
It accepts `author` (an object), `text` (a string), and `date` (a date) as props, and describes a comment on a social media website.

This component can be tricky to change because of all the nesting, and it is also hard to reuse individual parts of it. Let’s extract a few components from it. 

First, we will extract `Avatar`:
  ```JSX 
  funtion Avatar(props) {
    return (
      <img className="avatar"
        src={props.user.avatarUrl}
        alt={props.user.name}
      />
    );
  }
  ```

The `Avatar` doesn’t need to know that it is being rendered inside a `Comment`. This is why we have given its prop a more generic name: `user` rather than `author`.

>We recommend naming props from the component’s own point of view rather than the context in which it is being used.

Next, we will extract a `UserInfo` component that renders an `Avatar` next to the user’s name:

  ```JSX 
  function UserInfo(props) {
    return (
      <div className="UserInfo">
        <Avatar user={props.user} />
        <div className="User-Info-name">
          {props.user.name}
        </div>
      </div>
    );
  }
  ```
This will simplify `Comment` to:
  ```JSX
  function Comment(props) {
    return(
      <div className="Comment">
        <UserInfo user={props.author} />
        <div className="Comment-text">
          {props.text}
        </div>
        <div className="Comment-date">
          {formatDate(props.date)}
        </div>
      </div>
    );
  }
  ```
>Extracting components might seem like grunt work at first, but having a palette of reusable components pays off in larger apps. A good rule of thumb is that if a part of your UI is used several times (Button, Panel, Avatar), or is complex enough on its own (App, FeedStory, Comment), it is a good candidate to be extracted to a separate component.

---

## Pure Functions: Props are Read-Only

Whether you declare a component as a function or a class, it must never modify its own props. Consider this `sum` function:
  ```JSX
  function sum(a, b) {
    return a + b;
  }
  ```
Such functions are called *“pure”* because they do not attempt to change their inputs, and always return the same result for the same inputs.

In contrast, this function is impure because it changes its own input:

  ```JSX
  function withdraw(account, amount) {
    account.total -= amount;
  }
  ```

React is pretty flexible but it has a single strict rule:

**All React components must act like pure functions with respect to their props.**

Of course, application UIs are dynamic and change over time. In the next section, we will introduce a new concept of “state”. State allows React components to change their output over time in response to user actions, network responses, and anything else, without violating this rule.

