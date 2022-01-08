
# SQL


- [source](https://open.appacademy.io/learn/ch---nov-2021-ny-cohort/sql-draft/study-guide---rails-1-assessment)

- [SQL Bolt](https://sqlbolt.com/)

- [SQL Zoo](https://sqlzoo.net/wiki/SQL_Tutorial)

- [Kahoot SQL](https://play.kahoot.it/v2/?quizId=85da63ee-4075-42f8-94b3-2cd88de6915a)

- [Notes Official](https://github.com/appacademy/2021-11-29-NYC-Lecture-Notes/blob/main/w5d2-sql-intro/slides.md)

- [Demo Official](https://github.com/appacademy/2021-11-29-NYC-Lecture-Notes/tree/main/w5d2-sql-intro/demo/skeleton)

<br><br/>
-----
- Given a database and a series of tables demonstrate the ability to return data from the given database by writing SQL query statements

- Demonstrate how to use aggregates within a SQL query to aggregate data from rows and columns

- Demonstrate how to join three separate tables using a JOIN table by joining on a column

- Demonstrate how to solve more complicated problems using a SELF JOIN to extract multiple types of information from the same table

- Know the basic Postgres commands to interact with the Postgres API via your terminal.

<br><br/>
------

## PostgreSQL Shell Commands 
  - `$psql` opens 
  - `CREATE DATABASE db_name` 
  - `$ psql db_name` opens db
  - `\d`
  - `\d table` lists tables 
  - `\?` to list meta commands 
  - `;` to end queries

## Basics of a SQL Query
  - `SELECT` choose which columns to extract data 
  - `FROM` specifies _relation_ (table) to get data from
  - `WHERE` / `WHERE NOT` filters data according to logical expressions
    - `=`, `>=`, `<=`, `>`, `<`, `<>`, `/`, `!=`
    - `IN`, `BETWEEN`, `LIKE`, `%` 
    - `AND`, `OR`

## SQL Filters and Commands 
  - `ORDER BY` sorts results based on spec column
    - `ASC` or `DESC`
    - `ASC` is default
  - `LIMIT` how many rows you want in result 
  - `OFFSET` how many rows to skip from top
  - `DISTINCT` de-dups data in a result (Array#uniq)
    - `SELECT DISTINCT` name, type
    - `SELECT COUNT`(DISTINCT name)

## NULL
  - Comparisons to `NULL` don't work 
  - `NULL` represents an unknown val
    - `NULL` is not a val, its nothing
  - `IS NULL` `IS NOT NULL`

## Using Aggregate Fxns
  - Agg fxns combine data from a col into a single val
  - **Alias** is req'd for clear results
  - `COUNT`, `SUM`, `AVG`, `MIN`/`MAX`, and more
  - only exist for the query 

_Select the total average cost of possessions_
```SQL
SELECT   
  AVG(cost) AS average_cost 
FROM 
possessions; 
```


_Count the total number of possessions_
```SQL
SELECT
  COUNT(*) AS num_possessions
FROM
  possessions; 
```
<br><br/>

## GROUP BY
  - `GROUP BY` groups rows with matching vals for a column
    - Collapses each group of rows into a single row
  - Any column we `SELECT` must be in our `GROUP BY`
  - Aggr fxns in `SELECT` will apply to individual groups, not the groups as a whole

_For each type of possession with more than 5 items, show the type and number of each_
```SQL
SELECT 
  type, COUNT(*) AS num_items
FROM
  possessions
GROUP BY
  type
HAVING 
  COUNT(*) > 5;
```

## WHERE vs HAVING
  - `HAVING` works like `WHERE` but
    - `WHERE` gets eval before `GROUP BY`
    - `HAVING` gets eval after `GROUP BY`
  - Since the `WHERE` clause executes before the `GROUP BY` clause, grouped entries cannot be filtered by `WHERE`
    - `HAVING` is the same as `WHERE` but is applied to grouped entries
    - Aggregate fxns are not allowed in `WHERE`. Must use by `HAVING`

## Order of Op Execution in SQL
  1. `FROM` 
  2. `JOIN`
  3. `WHERE`
  4. `GROUP BY`
  5. `HAVING`
  6. `SELECT`
  7. `ORDER BY`
  8. `LIMIT / OFFSET`

## Subquery
  - **Subquery** : Sometimes its useful to use the result of a query inside another query
  - Most common in the `WHERE` clause
    - `WHERE IN` _subquery_
    - `WHERE NOT IN` _subquery_  
  - Use a subquery if your query follows the logic of _"Get me this data A, as long as it is in this dataset B"_
  - Can also be used in the `FROM` statement
    - must alias name subquery so that you can add further constraints 

_Of the most common item, list the ones that cost over $1000_
```SQL
SELECT
    *
FROM
    possessions
WHERE
    name IN (
      SELECT
          name
      FROM
          possessions
      GROUP BY
          name
      ORDER BY
          COUNT(*) DESC 
      LIMIT
          1
    ) AND cost > 1000;
```
<br><br/>

_How many types of possessions have a total cost over $200?_
```SQL
SELECT
    COUNT(*) AS num_types
FROM (
      SELECT 
        type
      FROM 
        possessions
      GROUP BY 
        type
      HAVING 
        SUM(cost) > 200
) AS pricey_possessions;
```
<br><br/>

_Who is the owner of the most expensive item?_
```SQL
SELECT
    name
FROM 
    ny_instructors
WHERE 
      id = (
      SELECT
          owner_id 
      FROM
          possessions
      ORDER BY
          cost DESC
      LIMIT 1
);
```


## Subquery v JOIN
  - Subjective!
  - When lots of data across many tables - JOIN
  - Subq use less memory
  - Subq use more CPU than joins (usually bottleneck)
  - May differ between SQL engines 

## JOINS
  - `JOIN` Combine data from multiple tables into one relation (table)
  - Tpes of relationships
      - One to many (Hierarchical)
        _Each student has one circle-leader, and each cirle-leader has many students_

      - Many to many (horizontal)
        _Each NY TA has many SF TA friends, and each SF TA has many NY TA friends_

## Types of JOINs
  - `INNER JOIN` 
      - returns only rows from `table1`and `table2` that match each other.  This is default.
  - `LEFT OUTER JOIN` aka `LEFT JOIN`
      - returns all rows in table1, whether or not they match table2.  Not supp
  - `FULL OUTER JOIN`
      -  returns all whether or not the data matches up

_Show the name of all the possessions and their owner_
```SQL
SELECT  
    ny_instructors.name AS owner_name
    possessions.name AS possession_name
FROM
    ny_instructors
JOIN
    ON ny_instructors.id = possessions.owner_id;
```
<br><br/>

_Find the total number of possessions owned by each person_
```SQL
SELECT 
    ny_instructors.name AS owner_name, 
    COUNT(*) AS total_possessions
FROM 
    ny_instructors
JOIN possessions 
    ON ny_instructors.is = possessions.owner_id 
GROUP BY
    owner_name;
```
<br><br/>

_Which NY instructor does not have any possessions?
```SQL
SELECT 
    ny_instructors.name AS name 
FROM 
    ny_instructors
LEFT OUTER JOIN possessions 
    ON possessions.owner_id = ny_instructors.id
WHERE 
    possessions.id IS NULL; 
```
<br><br/>

## Self Join
  - Joins a table back against itself
  - Must use an alias, make it descriptive!

_Get all of the aA instructors who are also pod leaders_
<br><br/>

_To visualize:_
```SQL
SELECT 
    *
FROM 
    ny_instructors AS instructors
JOIN ny_instructors AS pod_leaders
    ON instructors.pod_leader_id = pod_leaders.id
    ; 
```
_To solve:_
```SQL
SELECT
    DISTINCT(pod_leaders.name)
FROM 
    ny_instructors AS instructors
JOIN ny_instructors AS pod_leaders
    ON instructors.pod_leader_id = pod_leaders.id;
```
<br><br/>

## heredoc.rb

```Ruby 
require 'pg'
# require 'byebug'

def execute(sql)
  # open connection to Postgres
  connection = PG::Connection.open(dbname: 'lecture')
  # execute query
  query_result = connection.exec(sql).values #returns an array of arrays to represent a table
  # close connection to Postgres
  connection.close

  # return result of query
  query_result
end

def example_query

  # Final way adding the heredoc straight into the execute method with funny parentheses
  execute(<<-SQL)
    SELECT
      *
    FROM
      ny_instructors;
  SQL

  # Second, heredoc way of writing this method:
  # query = <<-SQL
  #   SELECT
  #     *
  #   FROM
  #     ny_instructors;
  #   SQL
  
  # execute(query)


  # First way:
  # execute("SELECT * FROM ny_instructors;")
end

p example_query
```


## Review 
  1. How can we store information?
  2. How can we access the data
  3. What are the basics of SQL queries 
  4. What if I want to do calcs on my data?
  5. What if I want to group my data?
  6. Can I use the result of a query in a different query?
  7. How can I query relationships across tables?
  8. What is a seelf-join? 

