(Thank you Emily L. for putting this together!)  
(Note, the triangles indicate toggled drop-downs)

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
      gem 'annotate'
      gem 'bcrypt'
      gem 'better_errors'
      gem 'binding_of_caller'
      gem 'byebug'
      gem 'pry-rails'
      #possible add-ons
      # Testing: 'capybara', 'rspec', 'rspec-rails', 'factory_bot_rails', 'faker', 'shoulda-matchers'
    ```
    </details>

- Create db `$ bundle exec rails db:create` 


## Create Models, Migrations, Controllers, and Routes
- Create tables, models, migrations: `$ be rails g model Name column:type:index`
    - null: false, unique: true, etc. 

- Create routes: `/config/routes.rb` 
    - <details>
      <summary><b>Routes Detail</b></summary>

      - add `resource :users` for standard 8 routes
      - add `resource :session, only: [:new, :create, :destroy]`
      - nested routes from `has_many`/`belongs_to` associations
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
- before_action :require_signed_in!
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

`generate_session_token` (redundant if `||=`)
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
  validates :username, :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  ```

</details>

<details>
<summary><b>A</b></summary>

`after_initialize` 
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
  self.password_digest = BCrypt::Password.create(password) # 
  @password = password # 
end

def password 
  @password
end
```

</details>

<details>
<summary><b>E</b></summary>

`ensure_session_token`
```Ruby
def ensure_session_token 
  self.session_token ||= SecureRandom::urlsafe_base64 
end
# also generates with ||= 
```

</details>

<details>
<summary><b>R</b></summary>

`reset_session_token!`
```Ruby 
def reset_session_token! 
  self.session_token = SecureRandom::urlsafe_base64(16)
  self.save! 
  self.session_token  
end
```

</details>

---

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
  session[:session_token] = user.reset_session_token!  
end
```

</details>

<details>
<summary><b>L</b></summary>

`logout!`
```Ruby
def logout!
  current_user.reset_session_token! if logged_in?
  session[:session_token] = nil
  @current_user = nil
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
