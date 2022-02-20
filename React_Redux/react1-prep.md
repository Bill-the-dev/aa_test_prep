# React 1 Practice - Action Order
(WIP)

<details>
  
  <summary>TOGGLE</summary> 

</details>

## Instructions

<details>
  
  <summary>Setup</summary>  
  
  1. `npm install`
  2. `bundle install`
  3. `bundle exec rails db:setup`
    - postgres running!

  To test your code live in the browser, run:
  1. `rails server`
  2. `npm run build:watch` (this runs `webpack -w`. check your `package.json` for other scripts)
  3. Navigate to localhost:3000.  

  NB: you do **not** need to have a server or webpack running to run and pass specs.

</details>

<details>
  
  <summary>Specs</summary>   
  
  You will be running your code using Jest.  
  Jest specs location `./frontent/__tests__` 
  - run `npm test` to run all specs
  - run `npm test frontend/__tests__/somepath/sometest.js` to run a single test file
  * `npm test -- --watchAll`
    * similar to `webpack --watch`, will update every time there is a change
  * `npm test -- --bail`
    * similar to `--fail-fast`, will abort test run after first error
    * execution does not stop after first failed test, but at end of file.

</details>

<details>
  
  <summary>Spec Order</summary> 
  Entry point test:

  1. `frontend/__tests__/react1-test.js`

  Redux tests:

  1. `frontend/__tests__/post_api_util-test.js`
  2. `frontend/__tests__/post_actions-test.js`
  3. `frontend/__tests__/reducers-test.js`
  4. `frontend/__tests__/store-test.js`

  Component tests:

  1. `frontend/__tests__/post_index-test.js`
    * Write `PostIndexContainer` before `PostIndex`
  2. `frontend/__tests__/post_index_item-test.js`
  3. `frontend/__tests__/post_form-test.js`
    * Write `CreatePostFormContainer` and `EditPostFormContainer` before `PostForm`
  4. `frontend/__tests__/post_show-test.js`
    * Write `PostShowContainer` before `PostShow`

</details>

---

## Action Order

### Entry Point Test

`./frontend/react1.jsx`

<details>
  
  <summary>1. sets a listener for the DOMContentLoaded event</summary> 
  
  ```JSX
  document.addEventListener('DOMContentLoaded', () => {
  
  })  
  ```
</details>


<details>
  
  <summary>2. renders the Root component </summary> 
  
  ```JSX 
  // document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('root');

    ReactDOM.render(<Root />, root);
  // })
  ```
  - declare root 
  - reactDOM render root
  
</details>



<details>
  
  <summary>3. queries for and renders into the root div</summary> 

  > Cleared in step 2. with root render
    
  ```JSX 
  // document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('root');

    ReactDOM.render(<Root />, root);
  // })
  ```
  - declare root 
  - reactDOM render root

</details>



<details>
  
  <summary>4. invokes the configureStore function</summary> 

  ```JSX 
  // document.addEventListener('DOMContentLoaded', () => {
    // const root = document.getElementById('root');
    const store = configureStore();

    ReactDOM.render(<Root />, root);
  // })
  ```

</details>



<details>
  
  <summary>5. passes the store as a prop to the Root component</summary> 

  ```JSX 
  // document.addEventListener('DOMContentLoaded', () => {
    // const root = document.getElementById('root');
    // const store = configureStore();
    
    ReactDOM.render(<Root store={store} />, root);
  // })
  ```

</details>

---

### Post API Util Test

<details>
  
  <summary>fetchPosts makes request and returns an ajax promise</summary> 

  ```JS
  export const fetchPosts = () => {
    return $.ajax({
      url: `api/posts`
    })
  };
  ```

</details>


<details>
  
  <summary>fetchPost makes request and returns an ajax promise</summary> 

  ```JS
  export const fetchPost = (postId) => {
    return $.ajax({
      url: `api/posts/${postId}`
    })
  };
  ```

</details>


<details>
  
  <summary>createPost makes request and returns an ajax promise</summary> 

  ```JS
  export const createPost = (post) => {
    return $.ajax({
      url: `api/posts`,
      method: 'POST',
      data: { post }
    });
  };
  ```

</details>


<details>
  
  <summary>updatePost makes request and returns an ajax promise</summary> 

</details>


<details>
  
  <summary>deletePost makes request and returns an ajax promise</summary> 

</details>



