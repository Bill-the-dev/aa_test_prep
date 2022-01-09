## Migrations 
-----

- Given a resource, demonstrate how to create a new table in Rails

- Identify the file that will show you the effect of all the migrations that have been run so far

- Given several distractors, identify the proper way to change the schema of a rails application

- Given a setup rails project - demonstrate how to change a column in a given table

- [a/A Rails 1 Practice Assessment Video](https://open.appacademy.io/learn/ch---nov-2021-ny-cohort/sql-draft/rails-1-practice---migrations)

- [Notes Official](https://github.com/appacademy/2021-11-29-NYC-Lecture-Notes/blob/main/w5d4-models-migrations/slides.md)

- [Rails Guides Command Line](https://guides.rubyonrails.org/command_line.html)

- [Rails Guides Migration](https://guides.rubyonrails.org/active_record_migrations.html)



<br><br/>

-----

## Strategy
### Set-Up
  - README.md
  - (2.5.8 only) Check `Gemfile` for Ruby version, update
  - (2.5.8 only) Check `.ruby-version` for Ruby version, update
  - Install gems and db: `cd associations/` and `bundle install && ./setup_db.sh`
  - Review schema: `db` > `schema.rb`

### Complete Migrations

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
  <br><br/>

2. Check Rspec for column requirements, copy in, and add
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
          t.integer :commenter_id, null: false
          t.integer :parent_comment_id #no constraint
          
          t.timestamps
        end
        
        add_index :comments, :video_id
        add_index :comments, :commenter_id
        add_index :comments, :parent_comment_id
      end
    ```
    
    - **Note:** `add_index` specifies table and column **outside** the `create_table` method
    
    - **Note:** `t.timestamps` is all that is req'd to populate   
    
    <br><br/>

3. Run `bundle exec rails db:migrate` 
    ```bash
    == 20220109221804 CreateComments: migrating ===================================
    -- create_table(:comments)
      -> 0.0141s
    -- add_index(:comments, :video_id)
      -> 0.0073s
    -- add_index(:comments, :commenter_id)
      -> 0.0039s
    -- add_index(:comments, :parent_comment_id)
      -> 0.0032s
    == 20220109221804 CreateComments: migrated (0.0287s) ==========================
    ```    
    <br><br/>

4. Check status with `rails db:migrate:status` and `bundle exec rspec`
    ```bash
    database: rails-1P-migrations_development

    Status   Migration ID    Migration Name
    --------------------------------------------------
      up     20220109221804  Create comments
    ```     
    <br><br/>

5. Create new migration: `bundle exec rails g migration MakeChangesToUsersVideos`
    - multiple changes can be made in one migration
    - navigate to file from resulting tree
    ```Ruby
    class MakeChangesToUsersVideos < ActiveRecord::Migration[5.2]
      def change
        rename_column :users, :email, :username
        remove_column :users, :bio

        remove_column :videos, :name
        add_column :videos, :title, :string, null: false
        
        add_index :videos, :uploader_id
      end
    end
    ```     
    <br><br/>

6. Check status with `rails db:migrate:status` and `bundle exec rspec` to get that greeeeeeen!

<br><br/>

-----

## Terminal Commands


- `bundle exec rails g migration Create{TableName}`

- `bundle exec rails g migration Add{ColumnName}To{TableName}`

- `bundle exec rails g migration Remove{ColumnName}From{TableName}`

- `bundle exec rails g migration AddIndexTo{TableName}`

- `bundle exec rails db:migrate`

- `bundle exec rails db:migrate:status`

- `rails g` will create a generator list

- `rails --help` will show help file

- `rails destroy` opposite of generate 

- [Rails Guides Command Line](https://guides.rubyonrails.org/command_line.html)

- [Rails Guides Migration](https://guides.rubyonrails.org/active_record_migrations.html)

-----

## Migration Functions

- create_table
- add_column
- change_column
- add_index


-----

## Advanced Rails Migration

Rails has the ability to more than just generate an empty migration

```
rails generate migration AddPartNumberToProducts
```
```Ruby
class AddPartNumberToProducts < ActiveRecord::Migration[7.0]
  def change
  end
end
```

Based on naming conventions and additional (optional) arguments it can also start fleshing out the migration.

If the migration name is of the form **"AddColumnToTable"** or **"RemoveColumnFromTable"** and is followed by a list of column names and types then a migration containing the appropriate [add_column](https://guides.rubyonrails.org/active_record_migrations.html#:~:text=containing%20the%20appropriate-,add_column,-and%20remove_column%20statements) and [remove_column](https://guides.rubyonrails.org/active_record_migrations.html#:~:text=appropriate%20add_column%20and-,remove_column,-statements%20will%20be) statements will be created.

```
bin/rails generate migration AddPartNumberToProducts part_number:string:index

```
```Ruby
class AddPartNumberToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :part_number, :string
    add_index :products, :part_number
  end
end
```

You can also change more than one column

```
bin/rails generate migration AddDetailsToProducts part_number:string price:decimal
```
```Ruby
class AddDetailsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :part_number, :string
    add_column :products, :price, :decimal
  end
end
```

If the migration name is of the form **"CreateXXX"** and is followed by a list of column names and types then a migration creating the table **XXX** with the **columns listed** will be generated. For example:

```
bin/rails generate migration CreateProducts name:string part_number:string
```
```Ruby
class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :part_number

      t.timestamps
    end
  end
end
```

Rails can create boilerplate versions of `belongs_to`, produce `joins` tables, and much more.

>All material sourced from [Rails Guides](https://guides.rubyonrails.org/active_record_migrations.html)



