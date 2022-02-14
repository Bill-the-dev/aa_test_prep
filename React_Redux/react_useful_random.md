## Write Comments in JSX

Single-line comment: 

  ```JSX
  <div>
    {/* Comment goes here */}
    Hello, {name}!
  </div>
  ```

Multi-line comment: 

  ```JSX
  <div>
    {/* It also works 
    for multi-line comments. */}
    Hello, {name}! 
  </div>
  ```

---

## Styling and CSS 

Use the `className` prop. CSS classes can depend on component props or state:

  ```JSX 
  render() {
    let className = 'menu';
    if (this.props.isActive) {
      className += ' menu-active';
    }
    return <span className={className}>Menu</span>
  }
  ```

Animations in React resources:
  - [React Transition Group](https://reactcommunity.org/react-transition-group/)
  - [React Motion](https://github.com/chenglou/react-motion)
  - [React Spring](https://github.com/react-spring/react-spring)
  - [Framer Motion](https://framer.com/motion)

---


