
# Formatting Notes in Markdown

## What the heck is Markdown?
>Markdown is a lightweight markup language that you can use to add **formatting** elements to _plaintext_ text documents. It is portable, platform independent, and supported on a wide range of [websites](https://www.markdownguide.org/tools/reddit/) and applications. 

<br><br/>

## Okay, but wasn't this about notes?

  ###### (Yeah, but it's internet tradition to waste your time with an intro first. I'm getting there.)   


  - Organize your coding notes with a mixture of formatted text and code **_in the same document_**!

  - This guide was written using Visual Studio Code, but there are plenty of other ways to write a Markdown document. Check out [dilliger.io](https://dillinger.io/) or [stackedit.io](https://stackedit.io/) for a good online Markdown editor.
  
  - Please note, this was not meant to be a complete guide.  See [additional](https://www.google.com/search?q=markdown+guide&sxsrf=AOaemvI5q5O4VGw7nnrrLaE8ombY2FFojA%3A1641669210757&ei=WuLZYf7ZLdOpptQPy4iveA&ved=0ahUKEwj-7pSx7qL1AhXTlIkEHUvECw8Q4dUDCA8&uact=5&oq=markdown+guide&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBQgAEJECMgoILhCABBCHAhAUMgUIABCRAjIFCAAQkQIyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDoHCAAQRxCwAzoKCAAQgAQQhwIQFDoNCAAQgAQQhwIQsQMQFDoICAAQgAQQsQNKBAhBGABKBAhGGABQ8A1Y5iBgvyFoAXACeACAAUWIAasEkgEBOZgBAKABAcgBCMABAQ&sclient=gws-wiz) for more reputable information.  

  - To begin, create a new file in your program of choice with the `.md` filetype in the name.  
  
  - Preview in VSCode using ` shift + cmd + v ` or right-clicking the file and selecting `preview`.

  - View 'raw' code on Github to see full syntax.

  - **VSCode Extensions** 
      - [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) adds some fantastic editor options 
      - [GitHub Markdown Preview](https://marketplace.visualstudio.com/items?itemName=bierner.github-markdown-preview) adds a cleaner GitHub-style preview    

<br><br/>

------


## Quick Reference

| Element | Syntax Description |
| ----------- | ----------- |
| **Bold** |  `**bold**` or `__bold__`   |
| _Italic_ | `_italic_` or `*italic*` |
| **_Bold + Italic_** | `**_Bold + Italic_**` |
| ~~Strikethrough~~ | `~~Strikethrough~~` |
| Inline `code` | `` `code` `` |
| [Link](https://example.com/) | `[Link](https://example.com/)` |
| Horizontal Rule | `---` or `***` |
| Heading 1 | `# Text` |
| Heading 2 | `## Text` |
| Heading 3 | `### Text` |
| Line Break | `<br><br/>` or end a line with 2+ spaces '  ' | 
| Blockquotes | `>Text` or `>` on empty line to continue block paragraph |  

<br><br/>

-----

## Code Blocks

```
Generic code block open/close with (3) backticks " ` "
```
But you can also specify the language after the opening backticks to format accordingly.

_Ruby_
```Ruby
ny_nov_cohort.each do |get_grades|
    puts "It's obviously 100%. Hire us already."
end
```

_SQL_
```SQL
SELECT better_humor
FROM life
WHERE humor != 'cheesy'
```
<br><br/>

------


## Tables 

| Table | Syntax | Description | 
| :------ | :------: | ------: |
| Use colons  | in dashes | to align | 
| left | center | right |
| 42 | 42 | 42 |

<br><br/>

--------


## Lists

This is an Ordered List:
  1. Banana
  2. Tomato

This is an Unordered List:
  - Banana
  - Tomato
  - New level:
      - whoa.



-----
> Sourced from [markdownguide.org](https://www.markdownguide.org/) and [w3schools.io](https://www.w3schools.io/file/markdown-introduction/)

