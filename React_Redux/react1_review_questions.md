## Elaborative Interrogation


<details>
  
  <summary>How do we get information from our backend to our frontend?</summary> 

  - Bootstrapping
  - AJAX requests

</details>


<details>
  
  <summary>Why might we want to use one method (bootstraping vs AJAX requests) over another?</summary> 

  - Bootstrapping will persist on refresh but is not asynchronous. We want to bootstrap to have things in our pre-loaded state. Bootstrapped information will only be sent up when first loading the page.
  - AJAX requests are async and we should use them for anything that will consistently change.

</details>


<details>
  
  <summary>How does the createStore method work? What arguments does it accept?</summary> 

  - The createStore builds our redux store and gives us access to certain methods such as subscribe, getState, and dispatch. It will setup dispatch to, when invoked, pass the argument to the first middleware. The middlewares should continue to pass the argument onto the root reducer UNLESS one of the middlewares intercepts it (as is the case with a thunk action creator and the thunk middleware).
  - It accepts the root reducer, combineMiddlewares and the middlewares, and a preloaded state.

</details>


<details>
  
  <summary>What is a middleware? What does thunk do for us? What does Logger do for us?</summary> 

  - It sits between two other things. In our instance, it sits in front of our reducers so an action must pass through our middleware before hitting reducers.
  - Thunk will intercept functions and invoke them with dispatch and the redux state so that we can have access to dispatch. In practice, this will send off an ajax request and then use the dispatch we got from thunk to re-dispatch an action with the payload that was returned from the ajax request.
  - Logger is PURELY FOR DEVELOPMENT. It will log our state and actions allowing us to see what hits our reducers and how it modifies our redux state.

</details>


<details>
  
  <summary>How do auth and protected routes work?</summary> 

  - They check the sessions slice of redux state for a current user and then use that to either render the intended component or redirect to another component.

</details>


<details>
  
  <summary>What is combineReducers? What does it accept as key value pairs? How does this relate to redux state?</summary> 

  - Combine reducers is just a function that allows us to do what it says, combine the return values of each of our reducers to build the object that becomes our redux state.
  - The keys that are passed will become the keys in our redux state and should point to specific reducers. Those reducers should all return objects which become the slices of our redux state. Combine reducers can easily be re-written to simply invoke each of the reducers with the action and the appropriate slice of redux state.

</details>


<details>
  
  <summary>What causes a component to re-render?</summary> 

  - Props change, state change, parent component re-render

</details>


<details>
  
  <summary>What is msp and mdp? When would you us each?</summary> 

  - MSP -> takes information from the redux state and converts it to props for our presentational component. This method is reinvoked whenever our redux state is updated. We can also use ownProps (from our router) to get specific pieces of information.
  - MDP -> provides a way for our presentational components to communicate back with our redux store by giving them access to dispatch. We build an object that becomes the props and is made up of functions that (after some user action) will dispatch something (a function or an action) meant to update our redux store.

</details>


<details>
  
  <summary>What is OwnProps? When is it important?</summary> 

  - Information that is passed as the 2nd argument to MSP - for us, this means info from the Router.
  - We need this if the URL specifies a specific ID which we can use to pull specific information out of our redux state. This is important if we are looking for a specific post (for example)

</details>


<details>
  
  <summary>What is a lifecycle method and can you give an example of one? When might you want to use one?</summary> 

  - These are methods that are automatically invoked at a certain point in a components "life cycle" - the most common to use are componentDidMount (to fetch data from the db that might not yet exist in redux state), and componentDidUpdate (when we need to look at a propschange and do something specific).

</details>

