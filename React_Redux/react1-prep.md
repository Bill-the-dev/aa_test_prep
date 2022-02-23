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

### Redux - Post API Util Test

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

  ```JS
  export const updatePost = (post) => {
    return $.ajax({
      url: `api/posts/${post.id}`,
      method: 'PATCH',
      data: { post }
    })
  }
  ```

</details>


<details>
  
  <summary>deletePost makes request and returns an ajax promise</summary> 

  ```JS
  export const deletePost = (postId) => {
    return $.ajax({
      url: `api/posts/${postId}`,
      method: 'DELETE'
    })
  }
  ```

</details>

*[jQuery.ajax() Docs](https://api.jquery.com/Jquery.ajax/)*

---

### Redux - Post Action Test

<details>
  
  <summary>post constants</summary>   
   
  - should export a RECEIVE_ALL_POSTS constant
  - should export a RECEIVE_POST constant
  - should export a REMOVE_POST constant
  
  ```JS
  // import * as PostApiUtil from '../util/post_api_util';

  export const RECEIVE_ALL_POSTS = `RECEIVE_ALL_POSTS`;
  export const RECEIVE_POST = `RECEIVE_POST`;
  export const REMOVE_POST = `REMOVE_POST`;
  ```

</details>


<details>
  
  <summary>setup dispatch actions</summary> 

  ```JS 
  const receiveAllPosts = (posts) => {
    return({
      type: RECEIVE_ALL_POSTS,
      posts
    })
  }

  const receivePost = (post) => {
    return({
      type: RECEIVE_POST,
      post
    })
  }

  const removePost = (postId) => {
    return({
      type: REMOVE_POST,
      postId
    })
  }
  ```

</details>


<details>
  
  <summary>fetchPosts (thunk)</summary> 

  ```JS
  export const fetchPosts = () => dispatch => {
    return (
      PostApiUtil.fetchPosts()
      .then(posts => dispatch(receiveAllPosts(posts)))
      // .then(posts => dispatch({ type: RECEIVE_ALL_POSTS, posts }))
    )
  }
  ```

  - should export a fetchPosts function
  - dispatches RECEIVE_ALL_POSTS when posts have been fetched

</details>


<details>
  
  <summary>fetchPost  (thunk)</summary> 

  ```JS 
  export const fetchPost = (postId) => dispatch => {
    return (
      PostApiUtil.fetchPost(postId)
      .then(post => dispatch(receivePost(post)))
    )
  }
  ```

  - should export a fetchPost function
  - dispatches RECEIVE_POST when a single post has been fetched

</details>


<details>
  
  <summary>createPost  (thunk)</summary> 

  ```JS
  export const createPost = (post) => dispatch => {
    return (
      PostApiUtil.createPost(post)
      .then(createdPost => dispatch(receivePost(createdPost)))
    )
  }
  ```

  - should export a createPost function 
  - dispatches RECEIVE_POST when a post has been created

</details>


<details>
  
  <summary>updatePost  (thunk)</summary> 

  ```JS
  export const updatePost = (post) => dispatch => {
    return (
      PostApiUtil.updatePost(post)
      .then(updatedPost => dispatch(receivePost(updatedPost)))
    )
  }
  ```

  - should export an updatePost function
  - dispatches RECEIVE_POST when a post has been updated

</details>


<details>
  
  <summary>deletePost  (thunk)</summary> 

  ```JS
  export const deletePost = (postId) => dispatch => {
    return (
      PostApiUtil.deletePost(postId)
      .then(() => dispatch(removePost(postId)))
      // () works because we already have Id, otherwise:
      // .then((post) => dispatch(removePost(post.id)))
    )
  } 
  ```

  - should export a deletePost function
  - dispatches REMOVE_POST when a post has been deleted 

</details>

---

### Redux - Reducers Test


<details>
  
  <summary>Posts Reducer</summary> 

  ```JS
  // ={} sets default
  const PostsReducer = (oldState = {}, action) => { 
    Object.freeze(oldState); // prevents mutation
    let nextState = Object.assign({}, oldState); // copy of state

    switch (action.type) {  // always action.type

      default:
        return oldState;
    }
  };

  export default PostsReducer;
  ```

  - exports a function
  - should initialize with an empty object as the default state
  - should return the previous state if an action is not matched

</details>


<details>
  
  <summary>handling the RECEIVE_ALL_POSTS action</summary> 

  ```JS
  // ...
  switch (action.type) {  
    case RECEIVE_ALL_POSTS:
      return action.posts;

    default:
      return oldState;
  }
  // ...
  ```

  - should replace the state with the action's posts
  - should not modify the old state

</details>


<details>
  
  <summary>handling the RECEIVE_POST action</summary> 

  ```JS 
  // ...
  switch (action.type) {  
    // case RECEIVE_ALL_POSTS:
      // return action.posts;
    case RECEIVE_POST:
      nextState[action.post.id] = action.post;
      return nextState;

    default:
      return oldState;
  }
  // ...
  ```

  - should add the post to the state using the post id as a key
  - should not affect the other posts in the state
  - should not modify the old state

</details>


<details>
  
  <summary>handling the REMOVE_POST action</summary> 

  ```JS 
  // ...
  switch (action.type) { 
    // case RECEIVE_ALL_POSTS:
    //   return action.posts;
    // case RECEIVE_POST:
    //   nextState[action.post.id] = action.post;
    //   return nextState;
    case REMOVE_POST:
      delete nextState[action.postId];
      return nextState;

    default:
      return oldState;
  }
  // ...
  ```

  - should remove the correct post from the state
  - should not affect the other posts in the state
  - should not modify the old state

</details>


<details>
  
  <summary>RootReducer</summary> 

  ```JS 
  // import { combineReducers } from 'redux';
  // import PostsReducer from './posts_reducer';

  const RootReducer = combineReducers({
    posts: PostsReducer
  })

  export default RootReducer;
  ```

  - exports a function 
  - includes the PostsReducer under the key `posts`

</details>


---

### Redux - Store Test


<details>
  
  <summary>Store</summary> 

  ```JS 
  // import { createStore, applyMiddleware } from 'redux';
  // import RootReducer from '../reducers/root_reducer';
  // import thunk from 'redux-thunk';

  const configureStore = (preloadedState = {}) => {
    return createStore(RootReducer, preloadedState, applyMiddleware(thunk))
  }

  export default configureStore;
  // hints in import for createStore and args
  ```
  - should export a configureStore function 
  - the exported function should create a store when invoked
  - passes dispatched objects to the root reducer
  - creates a store with thunk middleware
</details>

---

### Component - Post Index Test

Recommended to start with the `post_indec_container.jsx` before heading to the `post_index.jsx` file and specs.  Specs will not run w/o it.

<details>
  
  <summary>`Post_Index_Container`</summary> 

  ```JS
  import { connect } from 'react-redux';
  import PostIndex from './post_index';
  import { fetchPosts, deletePost } from '../../actions/post_actions';

  const mSTP = state => ({
    posts: Object.values(state.posts)
  })

  const mDTP = dispatch => ({
    fetchPosts: () => dispatch(fetchPosts()),
    deletePost: (postId) => dispatch(deletePost(postId))
  })

  export default connect(mSTP, mDTP)(PostIndex)
  ```
  
  - mapStateToProps
  - mapDispatchToProps
  - connect(mSTP, mDTP)(PostIndex) 


</details>


<details>
  
  <summary>correctly maps state to props / dispatch to props</summary> 

  ```JS
  // import React from 'react';
  // import PostIndexItem from './post_index_item';
  // import CreatePostFormContainer from './create_post_form_container';

  class PostIndex extends React.Component {
    // class must render and return something
    // constructor not needed
    render() {  
      return (
        <div>
          <ul> </ul>
        </div>
      );
    }
  }

  export default PostIndex;
  ```

  (2 test specs passed after container setup)

</details>


<details>
  
  <summary>fetches posts after being mounted </summary> 

  ```JS
  // import React from 'react';
  // import PostIndexItem from './post_index_item';
  // import CreatePostFormContainer from './create_post_form_container';

  class PostIndex extends React.Component {
    
    componentDidMount() {
      this.props.fetchPosts();
    }
    
    // render() {  
    //   return (
      // ...
  ```

</details>


<details>
  
  <summary>renders a PostIndexItem for each post, passing in the `post` object and `deletePost` action as props</summary> 


  ```JS
  // import React from 'react';
  // import PostIndexItem from './post_index_item';
  // import CreatePostFormContainer from './create_post_form_container';
  import { deletePost } from '../../util/post_api_util';

  class PostIndex extends React.Component {

    // componentDidMount() {
    //   this.props.fetchPosts();
    // }

    render() { 
      const {posts, deletePost} = this.props;
      // destructure from props
      // this.props object extracts post key, give variable called post we can use to see the value at that post  
      
      return (
        <div>
          <ul>
            {
              posts.map((post) => {
                return <PostIndexItem 
                  key={post.id} // each child warning
                  post={post} 
                  deletePost={deletePost} 
                />;
              })
            }
          </ul>
        </div>
      );
    }
  }

  // export default PostIndex;
  ```

</details>


<details>
  
  <summary>contains a PostFormContainer component</summary> 

  ```JS
  // import React from 'react';
  // import PostIndexItem from './post_index_item';
  // import CreatePostFormContainer from './create_post_form_container';
  // import { deletePost } from '../../util/post_api_util';

  class PostIndex extends React.Component {

    // componentDidMount() {
    //   this.props.fetchPosts();
    // }

    render() { 
      // const {posts, deletePost} = this.props;  
      
      return (  // all inside one div for return!
        <div>  
          {/* <ul>
            ...
          </ul> */ }
          <CreatePostFormContainer />
        </div>
      );
    }
  }

  // export default PostIndex;
  ```

</details>

---

### Component - Post Index Item Test


<details>
  
  <summary>should be a function</summary>

  ```JS 
  // import React from 'react';
  // import { Link } from 'react-router-dom';

  const PostIndexItem = (props) => {
    return (
      <li></li>
    )
  }

  export default PostIndexItem;
  ```

</details>


<details>
  
  <summary>shows the post's title as a Link to the post's show page</summary> 

  ```JS
  // import React from 'react';
  // import { Link } from 'react-router-dom';

  const PostIndexItem = (props) => {
    return (
      <li>
        <Link to={`/posts/${props.post.id}`} >{props.post.title}</Link>  
      </li>
    )
  }

  export default PostIndexItem;
  ```

  - Hint, `{Link}` is imported.  Check `app.jsx` that shows all routes!
  - Props are passed down, contain both `id` and `title`
  - String interpolate `${}` using \`\` inside `.jsx` will error!  This is a JS feature, so must nest inside `{``}` 

</details>


<details>
  
  <summary>has a link that links to the post edit page</summary> 

  ```JS
  // import React from 'react';
  // import { Link } from 'react-router-dom';

  const PostIndexItem = (props) => {
    return (
      <li>
        <Link to={`/posts/${props.post.id}`} >{props.post.title}</Link>   
        <Link to={`/posts/${props.post.id}/edit`} >Edit</Link>  
      </li>
    )
  }

  export default PostIndexItem; 
  ```

</details>


<details>
  
  <summary>has a button that deletes the post when clicked</summary> 

  ```JS 
  // import React from 'react';
  // import { Link } from 'react-router-dom';

  const PostIndexItem = (props) => {
    return (
      <li>
        <Link to={`/posts/${props.post.id}`} >{props.post.title}</Link>   
        <Link to={`/posts/${props.post.id}/edit`} >Edit</Link>
        <button onClick={() => props.deletePost(props.post.id)}>Delete Post</button>   
      </li>
    )
  }

  export default PostIndexItem; 
  ```

  - Note: `onClick={props.deletePost(props.post.id)}` is BAD.  This is not handing off this function that will delete the post, we are invoking it to delete as soon as it renders.
  - Need to hand FUNCTIONS to eventlisteners.  Turn it into an arrow function!

</details>


<details>
  
  <summary>Optional: clean it up!</summary> 

  ```JS
  // import React from 'react';
  // import { Link } from 'react-router-dom';

  const PostIndexItem = ({post, deletePost}) => {
    return (
      <li>
        <Link to={`/posts/${post.id}`} >{post.title}</Link>  
        <Link to={`/posts/${post.id}/edit`} >Edit</Link>
        <button onClick={() => deletePost(post.id)}>Delete Post</button>  
      </li>
    )
  }

  export default PostIndexItem;
  ```

  - By destructing the props into post and delete post, we can remove props in all return references. 
</details>

---

### Component - Create Post Form  

Recommended to start with `create_post_form_container.jsx` before heading to the `post_form.jsx` file and specs.  Specs will error w/o it.

<details>
  
  <summary>`create_post_form_container`</summary> 

  ```JS
  // import { connect } from 'react-redux';
  // import { withRouter } from 'react-router-dom';
  // import PostForm from './post_form';
  // import { createPost } from '../../actions/post_actions';

  const mSTP = state => ({
    post: {
      title: '',
      body: ''
    },
    formType: 'Create Post'
  })

  const mDTP = dispatch => ({
    action: post => dispatch(createPost(post))
  })

  export default connect(mSTP, mDTP)(PostForm)
  ```

</details>


<details>
  
  <summary>correctly maps state to props / dispatch to props</summary> 

  (2 specs)

  ```JS
  // import React from 'react';

  class PostForm extends React.Component {
    render() {
      return null;
    }
  }

  export default PostForm
  ```

</details>


<details>
  
  <summary>3 spec</summary> 

  ```JS
  // import React from 'react';

  class PostForm extends React.Component {
    constructor(props) {
      super(props);
      this.state = this.props.post;
    }

    update(field) {
      return e => {
        this.setState({ [field]: e.currentTarget.value });
      };
    }
    render() {
      return (
        <form action="">
          <label >Title
            <input
              type="text"
              value={this.state.title}
              onChange={this.update('title')}
            />
          </label>

        </form>
      );
    }
  }

  // export default PostForm;
  ```

</details>


<details>
  
  <summary>5 spec</summary> 

  ```JS
  class PostForm extends React.Component {
    constructor(props) {
      super(props);
      this.state = this.props.post;
    }

    update(field) {
      return e => {
        this.setState({ [field]: e.currentTarget.value });
      };
    }
    render() {
      return (
        <form action="">
          <label >Title
            <input
              type="text"
              value={this.state.title}
              onChange={this.update('title')}
            />
          </label>
          <label >Body
            <textarea
              value={this.state.body}
              onChange={this.update('body')}
            />
          </label>
        </form>
      );
    }
  }
  ```

</details>


<details>
  
  <summary>TOGGLE</summary> 

</details>


<details>
  
  <summary>TOGGLE</summary> 

</details>


<details>
  
  <summary>TOGGLE</summary> 

</details>


<details>
  
  <summary>TOGGLE</summary> 

</details>


