## Associations
-----

- Identify the role of associations in a Rails model.

- Given a rails project with two associated models, write a `belongs_to` and `has_many` association relating the two.

- Identify how to know which Rails model gets the `belongs_to` association

- Demonstrate knowledge of which variables to refer to for the `primary_key`, `foriegn_key` and `class_name` for each association.

- Given a rails project with models and a `has_many` or `belongs_to association`, write a `has_many through` association to access data through another model.

- Identify the difference between a `has_many through` and a `has_one` association

- [a/A Rails 1 Practice Assessment Video](https://open.appacademy.io/learn/ch---nov-2021-ny-cohort/sql-draft/rails-1-practice---associations)
<br><br/>

-----

## Strategy
**Set-Up**
  - README.md
  - (2.5.8 only) Check `Gemfile` for Ruby version, update
  - (2.5.8 only) Check `.ruby-version` for Ruby version, update
  - Install gems and db: `cd associations/` and `bundle install && ./setup_db.sh`
  - Review schema: `db` > `schema.rb`

**Complete Associations:** `app` > `models` > `class.rb`
  1. Identify `belongs_to` through foreign keys
      - naming conventions available through spec
      ```RUBY
      belongs_to :video,
        primary_key: :id,         # always id
        foreign_key: :video_id,   # foreign key in schema
        class_name: :Video        # foreign key points to Class
      ```
  2. Write matching `has_many` or `has_one`
      - many v. one hinted in spec *'with comments'* v. *'with a comment'*
      ```Ruby
      has_many :comments,
        primary_key: :id,         # always id
        foreign_key: :video_id,   # foreign key from belongs_to
        class_name: :Comment      # Class from belongs_to
      ```
  3. If all foreign keys have been assigned, move on to `has_many through` and `has_one through`
      - many v. one hinted in spec *'with comments'* v. *'with a comment'*
          - `can be associated with a parent comment`
      ```Ruby 
      has_one :parent_commenter,  # spec error for naming 
        through: :parent_comment, # through another method in same class
        source: :commenter        # to class of through_method to method
      ```
      - can be multiple levels to `source: :method`
          - `is associated with likers comments`
      ```Ruby 
      has_many :likers_comments,
        through: :likers,
        source: :comments
        # through likers > likes > Like(class) > liker > User(class) > comments
      ```
      