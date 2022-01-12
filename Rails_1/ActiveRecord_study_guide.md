## ActiveRecord Queries
-----

- Given a rails project, demonstrate how to write methods utilizing complex ActiveRecord queries

- Use aggregates with ActiveRecord

- Write ActiveRecord queries using multiple `where` statements

- Write ActiveRecord queries using `group` with columns defined in select

- Use the `pluck` method with ActiveRecord to return ids



-----

## ActiveRecord Query Methods

- `includes(*args)`
  Specify relationships to be included in the result set.
  
  Allows you to access the address attribute of the User model without firing an additional query. This will often result in a performance improvement over a simple join.

  ```Ruby
  User.includes(:posts).where('posts.name = ?', 'example')

  User.includes(:posts).where(posts: { name: 'example' })
  ```

  You can also specify multiple relationships

  ```Ruby 
  users = User.includes(:address, :friends)
  ```

- `group(*args)`
  Returns an array with distinct records based on the group attribute

  ```Ruby
  User.select([:id, :name])
  # => [#<User id: 1, name: "Oscar">, #<User id: 2, name: "Oscar">, #<User id: 3, name: "Foo">]

  User.group(:name)
  # => [#<User id: 3, name: "Foo", ...>, #<User id: 2, name: "Oscar", ...>]

  User.group('name AS grouped_name, age')
  # => [#<User id: 3, name: "Foo", age: 21, ...>, #<User id: 2, name: "Oscar", age: 21, ...>, #<User id: 5, name: "Foo", age: 23, ...>]
  ```

- `having(opts, *rest)`
  Allows to specify a HAVING clause. Note that you can’t use HAVING without also specifying a GROUP clause.

  Req'd for aggregate methods.

  ```Ruby
  Order.having('SUM(price) > 30').group('user_id')
  ```

    - Aggregate methods:

    - `MAX and MIN`
      ```Ruby 
      Movie.having('MAX(movies.score) < ?', 8)
      ```

- `distinct(value = true)`
  Specifies whether the records should be unique or not.
  
  ```Ruby
  User.select(:name).distinct
  # Returns 1 record per distinct name
  ```



-----

## Pluck v Select

### Select

`select(*fields)` public

First: takes a block so it can be used just like Array#select.

```Ruby
Model.all.select { |m| m.field == value }
```

This will build an array of objects from the database for the scope, converting them into an array and iterating through them using Array#select.

Second: Modifies the SELECT statement for the query so that only certain fields are retrieved:

```Ruby
Model.select(:field)
# => [#<Model id: nil, field: "value">]
```

Although in the above example it looks as though this method returns an array, it actually returns a relation object and can have other query methods appended to it, such as the other methods in ActiveRecord::QueryMethods.

The argument to the method can also be an array of fields.

```Ruby
Model.select(:field, :other_field, :and_one_more)
# => [#<Model id: nil, field: "value", other_field: "value", and_one_more: "value">]
```

You can also use one or more strings, which will be used unchanged as SELECT fields.

```Ruby
Model.select('field AS field_one', 'other_field AS field_two')
# => [#<Model id: nil, field: "value", other_field: "value">]
```

-----

### Pluck

`pluck(*column_names)` public

Use #pluck as a shortcut to select one or more attributes without loading a bunch of records just to grab the attributes you want.

```Ruby
Person.pluck(:name)
```

instead of 

```Ruby
Person.all.map(&:name)
```

Pluck returns an Array of attribute values type-casted to match the plucked column names, if they can be deduced. Plucking an SQL fragment returns String values by default.

```Ruby
Person.pluck(:name)
# SELECT people.name FROM people
# => ['David', 'Jeremy', 'Jose']

Person.pluck(:id, :name)
# SELECT people.id, people.name FROM people
# => [[1, 'David'], [2, 'Jeremy'], [3, 'Jose']]

Person.distinct.pluck(:role)
# SELECT DISTINCT role FROM people
# => ['admin', 'member', 'guest']

Person.where(age: 21).limit(5).pluck(:id)
# SELECT people.id FROM people WHERE people.age = 21 LIMIT 5
# => [2, 3]

Person.pluck('DATEDIFF(updated_at, created_at)')
# SELECT DATEDIFF(updated_at, created_at) FROM people
# => ['0', '27761', '173']
```



>source: [select](https://apidock.com/rails/ActiveRecord/QueryMethods/select), [pluck](https://apidock.com/rails/ActiveRecord/Calculations/pluck)