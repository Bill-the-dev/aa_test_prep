# Ruby 2 Assessment

## Short Answer Questions
1. (OOP) Explain the difference between **public, private, and protected** methods


2. (OOP) Explain the difference between **inheriting from a class** and **including a module**.

3. (Big O) What is **Big O** analysis and why do we use it?

4. (Data) Describe what **LIFO** and **FIFO** are and how they relate to **Stack** and **Queue** respectively. 

5. (Data) Describe the difference between an **Abstract Data Type** and **Data Structure**.

6. (TDD) Describe at least **3 primary motivations** for test suites.

7. (TDD) Explain the difference between **Unit Tests** and **Integration Tests**. 

8. (TDD) Describe the basic **workflow of TDD**.

9. (TDD) Explain the case of a **double or mock** when writing unit tests.

10. (TDD) Describe the difference between RSpec's **describe** and **context** and when to use each.

--------------------

### 1. **Public, Private, and Protected**
- **Public** (default) 
    + API endpoints for user - interface
    + Can be called anywhere inside or outside the class definition
    + Can be called explicitly or implicitly

- **Private** 
    + Can only be called w/in the class definition
    + Always called on `self` 
    + Helper methods usually `private` 

- **Protected** 
    + Can only be called w/in the class definition
    + Can be called implicitly or explicitly
    + Can be used on other instances of the class

--------------------

### 2. **Inheriting a Class v. Including a Module** 
- **Inheritance** 
    + `class SubClass < SuperClass` 
    + DRY up code by  creating subtypes of existing classes
    + 'Child classes' (subclasses) have access to methods defined on their 'Parent class' (superclass)
    + Subclass can have ONE superclass, but superclass can have many subclasses.

- **Modules** 
    + Sometimes we have shared functionality that doesn't make sense to group under a shared parent
    + Modules allow us to write functionality we can add to classes
    + A module is like a class that **can't be initialized** - we can never have an instance of a module
    + While a class can only inherit from one superclass, it can include any number of modules
    + Modules don't necessitate any relationship between the classes that use them
    + Modules keep our code DRY

- (related) **super** 
    + methods on subclass override those of the parent. you can invoke the parent's overridden definition of a method using `super`.
    + `super` method tells Ruby to call the inherited method by the same name as the current method
    + Often used in initialize if we want some shared initialization behavior for our subclass
    + `super` with no parentheses passes all arguments this method received to the superclass' method
    + `super(arg)` with specific arguments passes just those arguments to the superclass's method
    + `super()` with empty parentheses passes no arguments to the superclass' method

--------------------

### 3. **Big O Analysis**
- Big O provides a formalized way to measure how an algorithm performance changes as inputs grow larger.  
- Breaks algorithm down into basic measures of time complexity and space complexity. 
- Considers WORST case scenario to classify

    #### Big O Complexities (from best to worst)
    |                            |            |                   |
    |----------------------------|------------|-------------------|
    | Constant                   | O(1)       | declared or ==    |
    | Logarithmic                | O(log n)   | binary search     |
    | Linear                     | O(n)       | iterative         |
    | Linearithmic (aka logliner)| O(n log n) | quick sort, sort  |
    | Polynomial/Quadratic       | O(n^2)     | nested loop       |
    | Exponential                | O(2^n)     | subsets 4>8>16    |  
    | Factorial                  | O(n!)      | permutations      |  

--------------------
### 4. **LIFO (Stack) v. FIFO (Queue)**
- **Queue (ADT), First-In-First-Out** 
    + **_Sequential collection of objects. Removal at one end, insertion at the other._**
    + `enqueue(el)`: add ele to the back of the queue
    + `dequeue`: remove and return ele from front of queue
    + `show`: show entire queue, don't return it
    + `size` return current size
    + `empty?`: return true or false if empty

- **Stack (ADT), Last-In-First-Out** 
    + **_Sequential collection of objects. All operations take place at one end._**
    + `push(el)`: add ele to top of stack
    + `pop`: remove and return ele from top of stack 
    + `peek`: return top ele of the stack, w/o removing it
    + `size`: return the current size of the stack 
    + `empty`: return true or false if empty

-----------
### 5. **ADT v. Data Structure**
- Abstract Data Type 
    + Defines a set of properties and interactions with some info (blueprint)
- Data Structure
    + Actual implementation of the conceptm with all properties (building)

-------------
### 6. **TDD Motivations**
- Test if it works
- Increase flexibility & reduce fear in refactoring 
- Make collaboration easier
- Produce documentation

-------------
### 7. **Unit Tests v. Integration Tests** 
- Unit Tests 
    + Tests a particular class or thing in isolation. (most tests)
- Integration Tests 
    + Tests that different parts of our app are communicating correctly,
      such as two classes. (less tests)
- End-to-end / UI Tests
    + Flow throughout whole app, user cases. (fewest tests)
-------------
### 8. **TDD Workflow**   
- Red 
: Write a failing test 
- Green 
: Write just enough code to pass 
- Refactor
: Improve the code quality 

-------------
### 9. **RSpec Double (or Mock)**
- A `double` allows spec to be written in isolation of other classes.  It is a fake object that takes the place of external interacting objects, such as another class. 
    + `let(:customer) { double("customer") }`
- (related) A method `stub` is similar, but stands in for a method
    + `allow(double).to receive(:method)`

        
------------

### 10. **RSpec Decribe v. Context** 
- `describe` is RSpec's unit of organization. It gathers several `it` blocks into a single unit.  
- `describe`, use the name of the method you're testing.
    + `#method` for instance methods
    + `::method` for class methods
- `context` is an alias for `describe` that can be more descriptive. 
    + use 'when', 'with', or 'without'
    + `context 'when logged in' do`
    + `context 'when logged out' do`

---------