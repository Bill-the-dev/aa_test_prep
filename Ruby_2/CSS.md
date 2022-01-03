# **CSS Selectors & Specificity** 


## Basic Selectors 



### Element Selector 
- Select directly by stating HTML ele name.

```CSS 
h1 {
    font-size: 24px; 
} 
```
-----------
### Descendant Selector 
- Select all descendants using a space between parent and child

```CSS 
<ul>
    <li><a href="example.com">Style Me!</a></li>
</ul>
```
```CSS
ul a {
    text-decoration: none; /* This assures the a elements are not underlined */
}
```
-------------
### Child Selector 
- Select all *direct* descendants using `>` between parent and child 

```CSS
<ul>
    <li><a href="example.com">Style Me!</a></li>
</ul>
```
```CSS
ul > a {
    text-decoration: none; /* this does not work */
}

ul > li > a {
    text-decoration: none; /* this does work */
}
```
-------------
### Class Selector 
- Select all ele's of a class using `.class` 
```CSS 
<section>This is a normal section</section>

<section class="bg-grey">This section has a greyish background</section>

<header class="bg-grey">This header also has a greyish background</header>
```
```CSS 
.bg-grey {
    background-color: whitesmoke; /* there are many color names */
}
``` 
---------------
### ID Selectors 
- Select all ele's by id using `#id` 
```CSS 
<span id="banana">This span has a banana color</span>
```
```CSS
#banana {
    color: yellow; /* banana is not a color name unfortunately */
}
```
---------------
### Universal Selectors 
- Select every element using `*` 
```CSS
* {
    border: 1px solid red; /* puts a red border around EVERY element */
}
```
----------------

## Specificity

### Overspecificity 
- Overriding properties requires a more 'specific' selector. 
- General rule: **be only as specific as necessary.**
- `!important` will override **_everything_**. With great power comes great responsibility, Peter.
```CSS 
header {
    min-width: 500px !important; /* sets the min-width of the header to 500px regardless of any other styling rules */
}
```

### Specificity Calculations 
- Specificity is calculated by counting various components of your css and expressing them in a form (a,b,c,d).
- The higher the  overall 'score' is more specific. 

    |      1000     |    0100    |    0010    |    0001    |
    |:-------------:|:----------:|:----------:|:----------:|
    | Inline Style  | IDs        | Classes    | Elements   | 
    |               |            | Attributes |            |

- **Inline styles** - An inline style is attached directly to the element to be styled.
  ```CSS 
  <h1 style="color: #ffffff;">
  ```
- **IDs** -  An ID is a unique identifier for the page elements, such as #navbar.
  ```CSS 
  <span id="banana">This span has a banana color</span>
  ```
- **Classes, Attributes, and pseudo classes** - This category includes .classes, [attributes] and pseudo-classes such as :hover, :focus etc.
  ```CSS 
  <section class="bg-grey">This section has a greyish background</section>
  ```
- **Elements and pseudo-elements** - This category includes element names and pseudo-elements, such as h1, div, :before and :after.
  ```CSS 
  h1 {
      font-size: 24px; 
     } 
  ```
