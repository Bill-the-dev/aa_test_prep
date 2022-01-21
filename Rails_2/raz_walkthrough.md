Needs one hell of an edit.  Be careful with accuracy.


- `be rails db:create`
- `be rails g model User username:string session_token:string password_digest:string`
  - check migration, assessment needs no db constraints
  - `be rails db:migrate` and `be rails db:test:load`

User Model 
- FIGVAPER
  ```Ruby 
  validates :password, length { minimum: 6, allow_nil: true }
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true

  after_initialize :ensure_session_token  #A
  # if you are failing features and you can't understand why, check these!  
  # they may pass spec, but still be off

  attr_reader :password #A

  has_many :goals,  #A (for associations)
    foreign_key: :user_id,
    class_name: :Goal
  
  def self.find_by_credentials(username, password)
  end

  def is_password?(password) #check_password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_sessoin_token
  end

  def reset_session_tokan!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  ```

Goal Model 

- `be rails g model goal name:string details:string status:boolean user_id:integer`
  - check migration, assessment needs no db constraints
  - `be rails db:migrate` and `be rails db:test:load`

  ```Ruby 
    validates :name, :details, presence: true 

    belongs_to :user,
      foreign_key: :user_id,
      class_name: :User

    
Users Controller

- `be rails g controller users`
  ```Ruby 
  before 
  
  def new 
    @user = User.new # create template .erb
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      login!(@user)
      redirect_to users_url
    else 
      #render and flash = flash.now
      #redirect_to and flash = .flash
      flash.now[:errors] = @user.errors.full_messages
      #use full_messages only when .save involved, else use custom
      render :new 
    end
  

    def show
      @user = User.find(params[:id])
      #.erb
    end

    def index
      @users = User.all
      #.erb
    end


    def user_params
      params.require(:user).permit(:username, :password)
    end
  end

Application Controller
- CELLL
  ```Ruby 
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def ensure_logged_in 
    redirect_to new_session_url unless logged_in?
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout!(user)
  end

  def logged_in?
  end

  ```


Routes
```Ruby 
  resources :users
    resources :goals, only: [:create] #spec nested shows relationship of parent/child or has_many/belongs_to
  resources :goals, except: [:create]
  resouce :session
```
- `rails routes`

Sessions Controller
- `be rails g controller sessions`

  ```Ruby
  before_action :ensure_logged_in, only: [:destroy] 


  def new
    @user = User.new  #best practice
    #add .erb
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[#...)
    if @user
      login!(@user)
      redirect_to users_url
    else 
      flash.now[:errors] = ['Invalid user....'] 
      render :new
  end

  def destroy
    logout!
    redirect_to new_session_url #was failing views w/o this
  end
  ```

Goals Controller
- `be rails g controller goals`

  ```Ruby 

  before_action :ensure_logged_in

  def create 
    @goal = Goal.new(goals_params)
    @goal.user_id = params[:user_id] #only place

    if @goal.save
    else
      flash[:errors] = @goal.errors.full_messages
    end
    redirect_to user_url(@goal.user_id) # or params[:user_id]
    # came back for goals completion and show
    
    #get clarification on other user create goal, Bill K question on params
  end



  def destroy
    @goal = Goal.find(params[:id])

    if @goal.user_id == current_user.id
      @goal.destroy
      redirect_to(users_url)
    else #empty and passes
    end
  end

  def goals_params
    #returned to add completion param to pass views
  end

  # NOTE: save! may stop the execution of the code, which may halt the spec from progressing! Be careful here, RSpec is designed to fail some and we want it to progress. 
  ```

Views 

click erb on bottom-right of bar, configure language based settings (settings.json), "emmet.includelanguages": should show .erb and HTML

index.erb
- h1 all users
- % @users.each do |user|
- a href= "%= user_url*user) %" %= user.user ...

new.erb (came back and changed it, going line by line)
- h1 sign up
- form action="" method="post">
  - input  type="hidden" name "autheticity_token" value="%= form_authenticity_token %"
  - label username
    - input type=text name=user[username] value="%= @user.username%"
  - label Password
    - input type password name user[password] value ...
  - input type submit value sign up

application.erb

(in body)
- form action=" %= session_url%" method=post
  - input hidden _method delete
  - input hidden name autheticity_token value %= form...
  - input submit signout


- %= yield  
- % id flash[:errors]
  - %= flash[:errors].join(" ,")
- %end

show.erb
- h2 Add new goal
- copy paste form from new, change user_goals_url(@user), Name goal[name] text, Details goal[details] text, Create Goal submit 
- label Complete?
  - input radio goal[status] true
  - input radio goal[status] false
- h2 All Goals 
- % @user.goals.each do |goal| #access from associations
  - %= goal.name
  - %= goal.details
  - % if goal.statis
    - Done
  - %end 
  - form action %= goal_url(goal) #copypasta from other form 
    - hidden method delete
    - hidden autheticity_token %=form_authenticity_token
    - submit Delete Goal


Notes 
- Why cant we just make a button, why do we need a form?
  - a form is required to make changes to the db.  A button does not do this.
- Where do we need auth_token?
  - EVERY form. Any changes to db needs to be allowed to do it.  This token is a rails helper
- Check if logged in before sign-up, helper methods in application controller for loggedin? and 
