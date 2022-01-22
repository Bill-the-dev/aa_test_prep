(Thank you Emily L. for putting this together!)  
(Note, the triangles indicate toggled drop-downs)
## Table of Contents
- [Table of Contents](#table-of-contents)
- [New Rails App](#new-rails-app)
- [Set Up](#set-up)
- [Create Models, Migrations, Controllers, and Routes](#create-models-migrations-controllers-and-routes)
- [Models](#models)
- [Controllers](#controllers)
- [Views/Features](#viewsfeatures)
- [FIGVAPER CELL (hidden)](#figvaper-cell-hidden)
  - [User](#user)
  - [Application Controller](#application-controller)
  - [Users Controller](#users-controller)
  - [Sessions Controller](#sessions-controller)
  - [Goals Controller](#goals-controller)



---
## New Rails App

<details>
<summary><b>Creating Rails App</b></summary> 

- Create your new project, if no skeleton.  Version specific, no git, using postrgres.
  ```sh
  rails _5.2.3_ new -G Record_Shelf --database=postgresql
  ```

</details>


## Set Up
- Configure gemfile and `bundle install`
  - <details>
    <summary><b>Gem List</b></summary>

    ```Ruby
      #...
      gem 'bcrypt' # comment in
      #...
    group :development do
      gem 'annotate'
      gem 'pry-rails'
      gem 'better_errors'
      gem 'binding_of_caller'
      
    #possible add-ons:
      
    # group :development, :test do
    #   gem 'capybara'
    #   gem 'rspec'
    #   gem 'rspec-rails', '~3.5' 
    #   gem 'launchy'
    #   gem 'shoulda-matchers'
    #   gem 'factory_bot_rails'
    #   gem 'faker'
    ```
    </details>

- Create db `$ bundle exec rails db:create` 


## Create Models, Migrations, Controllers, and Routes
- Create tables, models, migrations: `$ be rails g model Name column:type:index`
    - null: false, unique: true, etc. 

- Create routes: `/config/routes.rb` 
    - <details>
      <summary><b>Routes Detail</b></summary>

      - add `resources :users` for standard 8 routes
      - add `resource :session, only: [:new, :create, :destroy]`
      - nested routes usually imply `has_many`/`belongs_to` associations 
      - reference `$ rails routes`

      </details>

- Create controllers: `$ be rails g controller Names`
    - *session plural here only in name*

- Migrate `$ bundle exec rails db:migrate db:test:load`

## Models
```Ruby 
# user model
- FIGVAPER 
    - self.find_by_credentials(username,password)
    - is_password?(password)
    - self.generate_session_token
    - validate --> username/digest presence; username uniqueness; password length/nill
    - after_initialize :ensure_session_token
    - password, password=(password)
    - ensure_session_token
    - reset_session_token!
```

```Ruby
# goal/other model
- Validations 
    - (boolean) validates :status, inclusion: { in: [true, false] }
- Associations #check nested routes
```

## Controllers
```Ruby
# application controller
- CELLL
    private 
    - current_user
    - ensure_logged_in
    - login!(user)
    - logout!
    - logged_in?
- helper_method :current_user, :logged_in?
```

```Ruby
# user controller
- before_action :require_logged_in! 
- new
- create
- show
- index
- private: user_params
```

```Ruby
# session controller
- new
- create
- destroy
```

```Ruby
# goals controller
- before_action :ensure_logged_in
- create
- destroy
- private: goal_params
```

## Views/Features
- users
    - index
    - new
    - show
- sessions
    - new
- layouts - application.html.erb
    - if logged_in?...
    - if flash[:errors]...

---

## FIGVAPER CELL (hidden)

[(good for you)](https://media.giphy.com/media/ULrNQwq5zKUz6/giphy.gif) 
[(bad for you)](https://media.giphy.com/media/l0HlVCgwhCKKjMNQQ/giphy.gif)

### User

<details>
<summary><b>F</b></summary>

`self.find_by_credentials`
```Ruby
def self.find_by_credentials(username, password)  
  user = User.find_by(username: username)
  
  if user && user.check_password?(password) 
    user 
  else  
    nil
  end 
end

# if statement alternative:
# return nil if user.nil?
# user.is_password?(password) ? user : nil
```

</details>

<details>
<summary><b>I</b></summary>

`is_password?` (a.k.a `check_password`)
```Ruby 
def check_password?(password) 
  password_object = BCrypt::Password.new(self.password_digest) 
  password_object.is_password?(password)  
end 
```

</details>

<details>
<summary><b>G</b></summary>

`generate_session_token` (redundant if using 'E' `||=`)
```Ruby 
def self.generate_session_token
  SecureRandom::urlsafe_base64(16)
end
```

</details>

<details>
<summary><b>V</b></summary>

Validations
```Ruby
class User < ApplicationRecord
  #...
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  ```

</details>

<details>
<summary><b>A</b></summary>

`after_initialize` and check associations
```Ruby
class User < ApplicationRecord
  after_initialize :ensure_session_token
  # before_validation :ensure_session_token # (alternative)
  #...
  ```

</details>

<details>
<summary><b>P</b></summary>

`password` and `password=`
```Ruby 
def password=(password)
  @password = password # 
  self.password_digest = BCrypt::Password.create(password) # 
end

def password 
  @password
end

# or attr_reader :password
```

</details>

<details>
<summary><b>E</b></summary>

`ensure_session_token`
```Ruby
private
def ensure_session_token 
  self.session_token ||= SecureRandom.base64(16) 
end
# also 'G' generates with ||= 
```

</details>

<details>
<summary><b>R</b></summary>

`reset_session_token!`
```Ruby 
def reset_session_token! 
  self.session_token = SecureRandom.base64(16)
  self.save! 
  self.session_token  
end
```

</details>

---

### Application Controller

<details>
<summary><b>C</b></summary>

`current_user`
```Ruby
def current_user
  return nil if !session[:session_token]
  @current_user ||= User.find_by(session_token: session[:session_token])
end
```

</details>

<details>
<summary><b>E</b></summary>

`ensure_logged_in`
```Ruby
def ensure_logged_in #
  redirect_to new_session_url unless logged_in?
end
```

</details>

<details>
<summary><b>L</b></summary>

`login!`
```Ruby
def login!(user)
  @current_user = user
  session[:session_token] = user.reset_session_token!  
end
```

</details>

<details>
<summary><b>L</b></summary>

`logout!`
```Ruby
def logout!
  current_user.reset_session_token! 
  session[:session_token] = nil
end
```

</details>

<details>
<summary><b>L</b></summary>

`logged_in?`
```Ruby
def logged_in?
  !!current_user 
end
```
</details>

<details>
<summary><b>h (it's silent, guess?)</b></summary>

```Ruby
  # Expose these methods to the views
  helper_method :current_user, :signed_in?
```

</details>

---

### Users Controller

<details>
<summary><b>(expand)</b></summary>

  <details>
  <summary><b>b</b></summary>

  ```Ruby
  before_action :require_logged_in!, only: [:show, :index]
  ```

  </details>

  <details>
  <summary><b>i</b></summary>

  ```Ruby
    def index 
      @users = User.all 
      render :index 
    end
  ```

  </details>

  <details>
  <summary><b>s</b></summary>

  ```Ruby
    def show
      @user = User.find(params[:id])
      render :show
    end
  ```

  </details>

  <details>
  <summary><b>n</b></summary>

  ```Ruby
    def new
      @user = User.new
      render :new
    end
  ```

  </details>

  <details>
  <summary><b>c</b></summary>

  ```Ruby
    def create
      @user = User.create(user_params)

      if @user.save
        login!(@user)
        redirect_to users_url
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new
      end
    end
  ```

  </details>

  <details>
  <summary><b>p</b></summary>

  ```Ruby
    def user_params
      self.params.require(:user).permit(:username, :password)
    end
  ```

  </details>
  <!-- nest end -->
</details>

---

### Sessions Controller

<details>
<summary><b>(expand)</b></summary>

  <details>
  <summary><b>b</b></summary>

  ```Ruby
    before_action :require_logged_in!, only[:destroy] 
  ```

  </details>

  <details>
  <summary><b>n</b></summary>

  ```Ruby
    def new
      render :new
    end
  ```

  </details>

  <details>
  <summary><b>c</b></summary>

  ```Ruby
    def create 
      @user = User.find_by_credentials(
        params[:user][:username], 
        params[:user][:password]
      )
      
      if @user
        login!(@user)
        redirect_to users_url 
      else
        flash.now[:errors] = ['Invalid username or password']
        render :new 
      end
    end
  ```

  </details>

  <details>
  <summary><b>d</b></summary>

  ```Ruby
    def destroy 
      logout!
      redirect_to new_session_url
    end
  ```

  </details>
<!-- nest end -->
</details>

---

### Goals Controller


<details>
<summary><b>(expand)</b></summary>

  <details>
  <summary><b>b</b></summary>

  ```Ruby
    before_action :require_signed_in!
  ```

  </details> 

  <details>
  <summary><b>c</b></summary>

  ```Ruby
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = params[:user_id]

    if @goal.save
    else
        flash[:errors] = @goal.errors.full_messages
    end

    # redirecting to the same url no matter what
    redirect_to user_url(@goal.user)
  end
  ```

  </details> 

  <details>
  <summary><b>e</b></summary>

  ```Ruby
  def edit
    @goal = current_user.goals.find_by(id: params[:id])

    if @goal
      render :edit
    else
      flash[:errors] = ["You cannot update goals created by someone else."]
      redirect_to user_url(current_user.id)
    end
  end
  ```

  </details> 

  <details>
  <summary><b>u</b></summary>

  ```Ruby
  def update
    @goal = current_user.goals.find_by(id: params[:id])
    # @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  ```

  </details> 

  <details>
  <summary><b>d</b></summary>

  ```Ruby
  def destroy
    @goal = current_user.goals.find_by(id: params[:id])

    if @goal 
      @goal.destroy
      redirect_to users_url
    else
      flash[:errors] = ["You cannot delete someone else's goal."]
      redirect_to users_url
    end
  end
  ```

  </details> 

  <details>
  <summary><b>p</b></summary>

  ```Ruby
    private
    def goal_params
      params.require(:goal).permit(:name, :details, :status)
    end
  ```

  </details> 

<!-- nest end -->
</details> 
