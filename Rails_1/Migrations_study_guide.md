## Migrations 
-----

- Given a resource, demonstrate how to create a new table in Rails

- Identify the file that will show you the effect of all the migrations that have been run so far

- Given several distractors, identify the proper way to change the schema of a rails application

- Given a setup rails project - demonstrate how to change a column in a given table

- [a/A Rails 1 Practice Assessment Video](https://open.appacademy.io/learn/ch---nov-2021-ny-cohort/sql-draft/rails-1-practice---migrations)

<br><br/>

-----

## Strategy
**Set-Up**
  - README.md
  - (2.5.8 only) Check `Gemfile` for Ruby version, update
  - (2.5.8 only) Check `.ruby-version` for Ruby version, update
  - Install gems and db: `cd associations/` and `bundle install && ./setup_db.sh`
  - Review schema: `db` > `schema.rb`

1. Create a new migration: `bundle exec rails generate CreateComments`
    - =>`create    db/migrate/20220109221804_create_comments.rb`
    - navigate to file from resulting tree
    ```Ruby
    class CreateComments < ActiveRecord::Migration[5.2]
      def change
        create_table :comments do |t|
        end
      end
    end     # this is the boilerplate
    ```
  
2. Check Rspec for column requirements and add
    ```bash
    'body' column
      exists with a type of 'string' (FAILED - 3)
      has a 'not null' constraint (FAILED - 4)
    'video_id' column
      exists with a type of 'integer' (FAILED - 5)
      has a 'not null' constraint (FAILED - 6)
      is indexed (FAILED - 7)
    ```

    - Add columns to migration with type and constraint:
    ```Ruby
      def change
        create_table :comments do |t|
          t.string :body, null: false
          t.integer :video_id, null: false
        end
        
        add_index :comments, :video_id
      end
    ```
    - Note: `add_index` specifies table and column **outside** the `create_table` method


