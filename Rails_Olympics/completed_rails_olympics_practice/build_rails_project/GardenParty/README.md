# Rails Olympics Part 2 - Building a Rails Project

You have _45 minutes_ for this portion evaluation.

This evaluation will focus on the creation of a simple CRUD Gardening
application. For this part fo the evaluation you will be creating models and
controllers for users, gardens and flowers.

## File Structure

You will start with a standard Rails file structure that including pre-written
HTML views and specs. **Do not alter any of the spec files.**

## Scoring & Objective

Each passing spec will award one point, for a total of 24 points. This component
of the evaluation is estimated to take **45 minutes**. Your objective is to pass
as many specs as possible.

## Getting Started

Before you begin running the specs, make sure that you create your database:

```sh
bundle exec rails db:create
```

#### Database Configuration

Every time you run `bundle exec rails db:migrate`, also run
`bundle exec rails db:test:load`. `db:migrate` only updates the development
database; `db:test:load` updates the test DB schema to mirror the development
DB.

You can combine both commands into one:

```sh
bundle exec rails db:migrate db:test:load
```

### Data Types

You will create migration, models and controllers for the following data types:

1. `Users` will have a username which is a string.
   - a User's username will be unique
2. `Gardens` will have a `name` which is a string, a `size` which is an integer,
   and will belong to a `User` (name this column `garden_owner_id`).
   - A User has many gardens, but those gardens must all have unique names in
     regards to that User.
3. `Flowers` will have a `flower_type` which is a string, and will belong to
   both a `User` (name this column `gardener_id`). and a `Garden` (name this
   column `garden_id`).

A User owns many Gardens. A User can plant Flowers in their own garden as well
as any other User's garden.

You will only be writing and tested on the migrations, models, and controllers.
When writing the strong parameters for your controllers, you can assume all
incoming parameters will be passed in though the body of incoming requests
(including `foreign_keys`).

## Specs

As you progress though this Evaluation we recommend completing and running all
the Models specs before attempting the Controller specs.

If a failing spec confuses you, look at the spec file to see if you can discern
what it is asking of you.

As ever, please ask your TAs any questions. If you get stuck or don't know why
something is failing; ask. TAs will let you know whether they can answer your
question, so ask anything.

### Running Specs

- `cd` into the project's root directory (`build_rails_project_pt2/GardenParty`)
- `bundle install` to install dependencies
- `bundle exec rspec` to run the entire spec suite
- `bundle exec rspec spec/<spec_file_name>` to run all specs in a given spec
  file
  - for example: `bundle exec rspec spec/models/user_spec.rb`
- `bundle exec rspec spec/<spec_file_name>:<line_number>` to run the spec(s) in
  the block that contains the given line number of a given spec file
  - for example: `bundle exec rspec spec/models/user_spec.rb:1`
