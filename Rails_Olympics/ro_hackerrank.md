### Active Record - Match By SQL 

```SQL 
SELECT "boards".*
FROM "boards"
WHERE "boards"."company_id" = 26179
LIMIT 1 
```
The above SQL would be generated from what kind of assoc?
    [ ] has_many
    [ ] has_many through
    [X] has_one 

*`Limit 1` rules out `has many` options.  `through` would likely have a `JOINS`*

---

### Active Record - Callbacks 

```Ruby 
class User < ApplicationRecord
    has_many :posts, dependent: :destroy
end

class Post < ApplicationRecord
    belongs_to :user
end
```
What currently happens when a user is deleted from the db?
- [ ] All other users assoc w/ deleted user's posts are destroyed
- [ ] Posts with 'dependent' set to true will be destroyed when the user is deleted
- [X] All posts with a foreign key that matches the id of the user will be deleted
- [ ] An error will be raised if the user that was going to be deleted had any assoc posts

--- 

### HTTP Status Codes - 500 

What does the HTTP Response Status Code 500 signify?
- [ ] Success
- [ ] Forbidden
- [ ] Not Found 
- [X] Internal Server Error

--- 

### Rails Routing - Action to Verbs 

Complete the blanks in the following question with the appropriate answer.

Table for reference
| Controller Actions | HTTP Verbs | 
| ------------------ | ---------: |
| Index | ? | 
| Destroy | ? |
| Show  | ? |
| Update  | ? |
| Edit  | ? |
| New  | ? |
| Create | ? |


Name the HTTP verb that corresponds to each controller action:
  - The HTTP verb for the Controller action `index` is _________.
  - The HTTP verb for the Controller action `destroy` is _________.
  - The HTTP verb for the Controller action `show` is _________.
  - The HTTP verb for the Controller action `update` is _________.
  - The HTTP verb for the Controller action `edit` is _________.
  - The HTTP verb for the Controller action `new` is _________.
  - The HTTP verb for the Controller action `create` is _________. 

*GET, DELETE, GET, PATCH/PUT, GET, GET, POST*

--- 

### Rails Controller 

A rails controller will persist for: 
- [ ] until the user closes their browser or tab
- [ ] until a request for a different route comes in- requiring a different controller instance
- [X] until the end of the current request
- [ ] as long as the rails server is up

--- 

### Rails Controller Debugging

```Ruby 
class VotersController < ApplicationController
    def create
        @voter = Voter.new(voter_params)
        if @voter.save
            redirect_to voter_url(@voter)
        end 

        render :new 
    end
#...
end
```

Given default routes, the above controller action may cause an error to be raised.
Select the reason why below: 
- [ ] A controller should only redirect outgoing responses
- [ ] A controller should only render outgoing responses 
- [X] The above controller may throw a double render error
- [ ] A controller must explicitly return instead of rendering or redirecting
- [ ] A controller should never render a response

--- 

### Rails Controller - Params Hash

```SQL
GET "/cats/11"
```

Given default routes, when the above HTTP request is dispatched to a controller action which of the following would be available in the params hash?
- [X] `params[:id]`
- [ ] `params[:query_string]`
- [ ] `params[:request]` 
- [ ] `params[:cats]` 
- [ ] `params[:cat_id]`

--- 

### Rails Views - Templates 

```HTML
<!-- app/views/voters/index.html.erb -->
<h1>List of Registered Voters:</h1>

    <ul>
        <% @voters.each do |voter| %>
            <li><% voter.full_name %></li>
        <% end %>
    </ul>
```

In the above code snippet the @voters instance variable contains an ActiveRecord::Relation with 5 voters.  What, if anything, is wrong with the above snippet?

Pick **ONE** option:
- [X] The code on line 5 needs a returning ERB tag
- [ ] The voters variable on line 4 should not be an instance variable
- [ ] The index page should show information for only one voter
- [ ] Nothing is wrong

--- 

### Metaprogramming 

```Ruby
class Corgi
    define_method(:output_name) do
        puts self
    end
end

corgi1 = Corgi.new
corgi1.output_name # ????
```

What is printed out when we run the above code?
Pick **ONE** option:
- [X] The instance of the new Corgi
- [ ] The Corgi class

---

### Metaprogramming - Defining Methods

```Ruby 
class Human
    def self.makes_sound(sound)
        define_method(sound) {puts "#{sound}!"}
    end

    makes_sound(:hello)
    makes_sound(:goodbye)
    makes_sound(:party)
end

friend = Human.new
```

Consider the above snippet - which of the following methods does the Human instance friend have access to?
Pick **ONE OR MORE** options:
- [ ] makes_sound
- [X] hello
- [X] goodbye
- [X] party

--- 

### CSS - Flexbox 

Make sure you **Render** your page to see your progrss!

#### HTML

```HTML 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="./index.css" />
    <title>App Academy Flex</title>
  </head>
  <body>
    <div class="title-header">
      <h2>Time to</h2>
      <h2>FLEX</h2>
      <h2>those CSS muscles</h2>
    </div>
    
    <div class="flex-list">
      <h1>This is the list of things I can flex:</h1>
      <ul>
        <li class="red">Frogs</li>
        <li class="red">Lists</li>
        <li class="red">My Mind</li>
      </ul>
    </div>

    <div id="animal-list">
      <h4>Look at these animals!</h4>
      <ul class="animals">
        <li class="blue">Whale</li>
        <li class="blue">Dolphin</li>
        <li class="blue">Turtle</li>
      </ul>
    </div>
  </body>
</html>
</html>
``` 

--- 

```CSS 
/*
An html skeleton is provided. Apply the following styles:

1. Add one line of code to the below styling for the "flex-list" class. 
The added line of code should horizontally align all the children of the
`flex-list` class into the center of the page. 

2. Add the display property for flex to the element with the class of
"title-header". Then use the "justify-content" property to horizontally 
center all elements nested within the "title-header" into the center of
the page.

3. Add a margin of 20 pixels all around to all "li" element nested within the 
"animals" class.

4. Add the display property for flex to the element with the id of
"animal-list". Then use the "justify-content" property to show both the
"h4" tag on the far left of the page AND the elements shown within the 
"animals" class to the right of the page. 
(See the photo from the directions for a visual).


You may not edit the html skeleton.
The following CSS styles are provided for you.
*/

.flex-list {
    display: flex;
    flex-direction: column;
    align-items: center
}
/* align-items will align according to cross-axis */ 

.title-header {
    display: flex;
    justify-content: center;
}
/* justify content is always about the main axis, in this case the row */

.animals > li {
    margin: 20px
}

#animal-list {
    display: flex;
    justify-content: space-between;
}

```

--- 


### Short Answer - Strong Parameters

*One of the reasons we use strong parameters in Rails Controllers is to require certain calues be present in the parameters of a request for that controller.  Identify and explain the second main reason we use strong parameters in Rails Controllers.*

> Strong parameters in Rails controllers will only allow specified parameters to be permitted.  This would prevent a user or website from attempting to add their own parameters to a request.

Grading criteria: response mentions explicitly filtering incoming parameters to avoid additional submitted parameters

--- 

### Short Answer - Rails Router

*Name the two things the Rails Router uses to recognize which controller action to dispatch a request to.*

> The Rails Router utilizes the request HTTP verb, and the request's URL path to know which controller and action to dispatch a request to.

Grading criteria: response fully identifies HTTP verb and the request URL path


---