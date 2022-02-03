
# Javascript Practice Assessment 

## Generator Problems 

### 
Write a function, Write a function, `deepDup(arr)`, that will perform a "deep" duplication of the array and any interior arrays. A deep duplication means that the array itself, as well as any nested arrays (no matter how deeply nested) are duped and are completely different objects in memory than those in the original array.

<details>
<summary>deepDup(arr)</summary>

```JS
function deepDup(arr) {
  return arr.map(el => el instanceof Array ? deepDup(el) : el);
}
```

</details>

---

Write a function `firstEvenNumbersSum(n)` that returns the sum of the first n even numbers recursively. Assume n > 0
<details>
<summary>firstEvenNumbersSum(n)</summary>

```JS
function firstEvenNumbersSum(n) {
  if (n === 1) return 2;
  return (n * 2) + firstEvenNumbersSum(n-1);
}
```

</details>

---
Write a recursive function `stringIncludeKey(string, key)` that takes in 
a string to search and a key string. Return true if the string contains all 
of the characters in the key in the same order that they appear in the key.

stringIncludeKey("cadbpc", "abc") => true
stringIncludeKey("cba", "abc") => false

<details>
<summary>stringIncludeKey(string, key)</summary>

```JS
function stringIncludeKey(string, key) {
  if (key === "") return true;

  let nextKeyChar = key[0];
  let keyI = string.indexOf(nextKeyChar);  // returns -1 if false

  if (keyI < 0) return false;
  return stringIncludeKey(string.slice(keyI + 1), key.slice(1));
}
```

</details>

---

Write a recursive function `recSum(numArr)` that returns the sum of all elements in an array. Assume all elements are numbers.
<details>
<summary>recSum(numArr)</summary>

```JS
function recSum(arr) {
  if (!arr.length) return 0;

  let num = arr[0];
  return num += recSum(arr.slice(1));
}
```

</details>

---

Write a function, `exponent(b, n)`, that calculates b^n recursively. Your solution should accept negative values for n. Do NOT use ** or Math.pow

<details>
<summary>exponent(b, n)</summary>

```JS
function exponent(b, n) {
  if (n === 0) return 1;

  if (n > 0) {
    return b * exponent(b, n - 1);
  } else {
    return 1/b * exponent(b, n + 1);
  }
}
```

</details>

---

Write a function, `factors(num)`, that returns an array containing the factors of a number in ascending order.

<details>
<summary>factors(num)</summary>

```JS
function factors(num) {
  let arr = [];
  for (let i = 1; i <= num; i++) {
    if (num % i === 0) arr.push(i);
  }
  return arr 
}
```

</details>

---

Write a function `primes(num)`, which returns an array of the first "num" primes. You may wish to use an `isPrime(num)` helper function.

<details>
<summary>primes(num)</summary>

```JS
function isPrime(num) {
  for (let i = 2; i < num; i++) {
    if (num % i === 0) return false;
  }
  return true;
}

function primes(num) {
  if (num < 1) return [];
  if (num === 1) return [2];

  let primeArr = [];
  let i = 2;

  while (primeArr.length < num) {
    if (isPrime(i)) primeArr.push(i);
    i += 1;
  }
  return primeArr;
}
```

</details>

---
Write a `String.prototype.mySlice(startIdx, endIdx)` method. It should take a start index and an (optional) end index and return a new string. Do NOT use the built-in string methods `slice`, `substr`, or `substring`. 
`abcde`.mySlice(2) => `cde`
`abcde`.mySlice(1, 3) => `bc`

<details>
<summary>mySlice()</summary>

```JS
String.prototype.mySlice = function (start, end) {
  let letters = this.split("");
  let sliced = [];
  if (end === undefined) end = this.length;

  for (let i = start; i < end; i++) {
    sliced.push(letters[i]);
  }
  return sliced.join("");
};
```

</details>

---

Write an `Array.prototype.twoSum` method, that finds all pairs of positions where the elements at those positions sum to zero.

NB: ordering matters. Each pair must be sorted with the smaller index before bigger index. The array of pairs must be sorted
"dictionary-wise":
[0, 2] before [1, 2] (smaller first elements come first)
[0, 1] before [0, 2] (then smaller second elements come first)

<details>
<summary>twoSum()</summary>

```JS
Array.prototype.twoSum = function () {
  const pairs = [];
  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i+1; j < this.length; j++) {
      if(this[i] + this[j] === 0) pairs.push([i, j]);
    }
  }
  return pairs;
}
```

</details>

---

Write a function `myReverse(array)` which returns the array in reversed order. Do NOT use the built-in `Array.prototype.reverse`.
ex. myReverse([1,2,3]) => [3,2,1]
<details>
<summary>myReverse()</summary>

```JS
function myReverse(arr) {
  if (arr.length === undefined) return arr;
  let newArr = [];
  for (let i = 0; i < arr.length; i++) {
    newArr.unshift(arr[i]);
  }
  return newArr;
};
```

</details>

---

 Write a function `transpose(arr)` that returns a 2d array transposed. e.g. transpose([[1,2],[3,4],[5,6]]) => [[1,3,5],[2,4,6]]
<details>
<summary>transpose(arr)</summary>

```JS
function transpose(arr) {
  let newArr = [];
  for (let inner = 0; inner < arr[0].length; inner++) {
    let sub = [];
    for (let outer = 0; outer < arr.length; outer++) {
      sub.push(arr[outer][inner]);
    }
    newArr.push(sub);
  }
  return newArr;
}
```

</details>

---

Write an `Array.prototype.myJoin(separator)` method, which joins the elements of an array into a string. If an argument is provided to `myJoin`, use that between each element. Otherwise, use an empty string.
Do NOT call the built-in `Array.prototype.join` method.

[1, 2, 3].myJoin() => '123'
[1, 2, 3].myJoin('$') => '1$2$3'
<details>
<summary>myJoin()</summary>

```JS
Array.prototype.myJoin = function (joiner = '') {
  let newStr = '';

  this.forEach((char, i) => {
    newStr += char;
    if (i < this.length - 1) newStr += joiner;
  });
  return newStr;
};
```

</details>

---

Write an `Array.prototype.dups` method that will return an object containing the indices of all duplicate elements. The keys are the duplicate elements; the values are arrays of their indices in ascending order. 
Example: [1, 3, 4, 3, 0, 3, 0].dups => { 3: [1, 3, 5], 0: [4, 6] }
<details>
<summary>dups</summary>

```JS
Array.prototype.dups = function () {
  let dups = {};
  let count = {};

  this.forEach((el, i) => {
    count[el] = count[el] || [];  // if undefined, make []
    count[el].push(i);
  });

  Object.entries(count).forEach(([key, val]) => {
    if (val.length > 1) dups[key] = val;
  });  
  return dups;
};
```

</details>

---

Write a function, `doubler(arr)`, that returns a copy of the input array with all elements doubled. You do not need to worry about invalid input.
Example: doubler([1, 2, 3]) => [2, 4, 6]
<details>
<summary>doubler()</summary>

```JS
function doubler(arr) {
  newArr = [];
  arr.forEach((el) => {
    newArr.push(el * 2);
  });
  return newArr;
}
```

</details>

---

Write an `Array.prototype.myRotate(times)` method which rotates the array by the given argument. If no argument is given, rotate the array by one position.

["a", "b", "c", "d"].myRotate() => ["b", "c", "d", "a"]
["a", "b", "c", "d"].myRotate(2) => ["c", "d", "a", "b"]
["a", "b", "c", "d"].myRotate(-1) => ["d", "a", "b", "c"]
<details>
<summary>myRotate(times)</summary>

```JS
Array.prototype.myRotate = function (times = 1) {
  rotated = this.slice(0);
  let i = 1;

  if (times < 0) {
    times *= -1;
    while (i <= times) {
      let el = rotated.pop();
      rotated.unshift(el);
      i += 1;
    }
  } else {
    while (i <= times) {
      let ele = rotated.shift();
      rotated.push(ele);
      i += 1;
    }
  }
  return rotated;
};

// Two-liner

Array.prototype.myRotate = function(t = 1) {
    let pivot = t % this.length;
    return this.splice(pivot).concat(this);
}
```

</details>

---

Write a function `titleize(str)` that capitalizes each word in a string like a book title. Do not capitalize the following words (unless they are the first word in the string): ["a", "and", "of", "over", "the"]
<details>
<summary>titleize(str)</summary>

```JS
function titleize(str) {
  const littleWords = ["a", "and", "of", "over", "the"];
  let words = str.split(" ");
  const titleizeWords = words.map((word, idx) => {
    if (idx !== 0 && !littleWords.includes(word)) {
      return word.slice(0, 1).toUpperCase() + word.slice(1).toLowerCase();
    } else if (idx === 0) {
      return word.slice(0, 1).toUpperCase() + word.slice(1).toLowerCase();
    } else {
      return word.toLowerCase();
    }
  });
  return titleizeWords.join(' ');
}
```

</details>

---

Write a `String.prototype.symmetricSubstrings` method that returns an array of substrings which are palindromes in alphabetical order. Only include substrings of length > 1. 
e.g. "cool".symmetricSubstrings() => ["oo"]


<details>
<summary>symmetricSubstrings()</summary>

```JS
String.prototype.symmetricSubstrings = function () {
  let arr = [];
  let str = this;

  for (let i = 0; i < str.length - 1; i++) {
    for (let j = i + 2; j <= str.length; j++) {
      let inner = "";
      inner = str.slice(i, j);
      rev = inner.split("").reverse().join("");
      if (inner === rev) arr.push(inner);
    }
  }
  return arr.sort();
};
```

</details>

---

Write a function, `anagrams(str1, str2)`, that takes in two words and returns a boolean indicating whether or not the words are anagrams. Anagrams are words that contain the same characters but not necessarily in the same order. Solve this without using Array.prototype.sort.
Examples:
anagrams('listen', 'silent') => true
anagrams('listen', 'potato') => false
<details>
<summary>anagrams()</summary>

```JS
function anagrams(str1, str2) {
  if (str1.length !== str2.length) return false;
  for (let i = 0; i < str1.length; i++) {
    if (!str2.includes(str1[i])) return false;
  }
  return true;
}
```

</details>

---

Write a `String.prototype.realWordsInString(dictionary)` method, that returns an array containing the substrings of `string` that appear in `dictionary` sorted alphabetically. This method does NOT return any duplicates. 
<details>
<summary>realWordsInString()</summary>

```JS
String.prototype.realWordsInString = function (dictionary) {
  let words = [];
  dictionary.forEach(word => {
    if (this.includes(word)) {
      words.push(word);
    }
  });
  return words.sort();
};
```

</details>

---

Write a recursive function, `binarySearch(sortedArray, target)`, that returns the index of `target` in `sortedArray`, or -1 if it is not found. Do NOT use the built-in `Array.prototype.indexOf` or `Array.prototype.includes` methods in your implementation.
Here's a quick summary of the binary search algorithm:
Start by looking at the middle item of the array. If it matches the target, return its index. Otherwise, recursively search either the left or the right half of the array until the target is found or the base case (empty array) is reached.

<details>
<summary>binarySearch(arr,target)</summary>

```JS
function binarySearch(arr, target) {
  let mid = Math.floor(arr.length / 2);
  if (arr[mid] === target) return mid;

  let left = arr.slice(0, mid);
  let right = arr.slice(mid + 1);

  if (target > arr[mid] && target <= arr[arr.length - 1]) {
    let rightSub = binarySearch(right, target);
    return rightSub + mid + 1;
  } else if (target < arr[mid] && target >= arr[0]) {
    return binarySearch(left, target);
  } else {
    return -1;
  }
}
```

</details>

---

Write an `Array.prototype.quickSort(callback)` method that quick sorts an array. It should take an optional callback that compares two elements, returning -1 if the first element should appear before the second, 0 if they are equal, and 1 if the first element should appear after the second. Do NOT call the built-in Array.prototype.sort method in your implementation.
Here's a summary of the quick sort algorithm:
Choose a pivot element, then iterate over the rest of the array, moving the remaining elements on to the appropriate side of the pivot. Recursively quick sort each side of the array until a base case is reached.

<details>
<summary>quickSort()</summary>

```JS
const callbackQuick = (el1, el2) => {
  if (el1 < el2) {
    return -1;
  } else if (el1 === el2) {
    return 0;
  } else {
    return 1;
  }
};

Array.prototype.quickSort = function (callback) {
  if (this.length < 2) return this;

  if (callback === undefined) {
    callback = callbackQuick;
  }

  const pivot = this[0];
  let left = this.slice(1).filter((ele) => callback(ele, pivot) === -1);
  let right = this.slice(1).filter((ele) => callback(ele, pivot) !== -1);
  left = left.quickSort(callback);
  right = right.quickSort(callback);

  return left.concat([pivot], right);
};
```

</details>

---

Write an `Array.prototype.bubbleSort(callback)` method, that bubble sorts an array. It should take an optional callback that compares two elements, returning -1 if the first element should appear before the second, 0 if they are equal, and 1 if the first element should appear after the second. Do NOT call the built-in `Array.prototype.sort` method in your implementation. Also, do NOT modify the original array. 
Here's a quick summary of the bubble sort algorithm: Iterate over the elements of the array. If the current element is unsorted with respect to the next element, swap them. If any swaps are made before reaching the end of the array, repeat the process. Otherwise, return the sorted array.

<details>
<summary>bubbleSort()</summary>

```JS
const callbackDefault = (num1, num2) => {  // practice this, not a funtion! fat!
  if (num1 < num2) {
    return -1;
  } else if (num1 === num2) {
    return 0;
  } else {
    return 1;
  }
};

Array.prototype.bubbleSort = function (callback) {

  if (callback === undefined) {
    callback = callbackDefault;
  }

  let arrDupe = this.slice();
  let sorted = false;
  while (!sorted) {
    sorted = true;

    for (let i = 0; i < arrDupe.length - 1; i++) { // remember length - 1
      if (callback(arrDupe[i], arrDupe[i + 1]) === 1) {
        [arrDupe[i], arrDupe[i + 1]] = [arrDupe[i + 1], arrDupe[i]];
        sorted = false;
      }
    }
  }
  return arrDupe;
};
```

</details>

---

Write an `Array.prototype.mergeSort` method that merge sorts an array. It
should take an optional callback that compares two elements, returning -1 if the first element should appear before the second, 0 if they are equal, and 1 if the first element should appear after the second. Define and use a helper method, `merge(left, right, comparator)`, to merge the halves. **IMPORTANT: Make sure to use a function declaration (`function merge`) as opposed to a function expression (`const merge = function`) for `merge`. Do NOT use the built-in `Array.prototype.sort` method in your implementation.** 
Here's a summary of the merge sort algorithm: Split the array into left and right halves, then merge sort them recursively until a base case is reached. Use a helper method, merge, to combine the halves in sorted order, and return the merged array. 

<details>
<summary>mergeSort()</summary>

```JS
const callbackMerge = (ele1, ele2) => {
  if (ele1 < ele2) {
    return -1;
  } else if (ele1 === ele2) {
    return 0;
  } else {
    return 1;
  }
};

function merge(left, right, comparator) {
  let merged = [];

  while (left.length > 0 && right.length > 0) {
    switch (comparator(left[0], right[0])) {
      case -1:
        merged.push(left.shift());
        break;
      case 0:
        merged.push(left.shift());
        break;
      case 1:
        merged.push(right.shift());
        break;
    }
  }
  merged = merged.concat(left, right);
  return merged;

}

Array.prototype.mergeSort = function (callback) {  // why not fat arrow?
  if (this.length <= 1) return this; // 1 or less already sorted

  if (callback === undefined) {
    callback = callbackMerge;
  }

  let mid = Math.floor(this.length / 2);
  let lsorted = this.slice(0, mid).mergeSort(callback);
  let rsorted = this.slice(mid).mergeSort(callback);

  return merge(lsorted, rsorted, callback);
};


```

</details>

---

Write a recursive function `recSum(numArr)` that returns the sum of all elements in an array. Assume all elements are numbers.
<details>
<summary>recSum()</summary>

```JS
function recSum(arr) {
  if (!arr.length) return 0;

  let num = arr[0];
  return num += recSum(arr.slice(1));
}
```

</details>

---
Write a function, `fibsSum(n)`, that finds the sum of the first n fibonacci numbers recursively. Assume n > 0. Note that for this problem, the fibonacci sequence starts with [1, 1]. 
<details>
<summary>fibsSum(n)</summary>

```JS
function fibsSum(n) {
  if (n === 1) return 1;
  if (n === 2) return 2;

  return fibsSum(n - 1) + fib(n);
}

// Helper Method to calculate nth fib
function fib(n) {
  if (n === 1) return 1;
  if (n === 2) return 1;
  return fib(n - 1) + fib(n - 2);
}
```

</details>

---

Write a recursive function, `factorialsRec(num)`, that returns the first `num` factorial numbers. Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial is 1!, the 3rd factorial is 2!, etc. 

<details>
<summary>factorialsRec()</summary>

```JS
function factorial(num) {
  if (num === 1) return num;
  return num * factorial(num - 1);
}


function factorialsRec(num) {
  if (num === 1) return [1];
  return factorialsRec(num - 1).concat([factorial(num - 1)]);
}
```

</details>

---

Write a function, `digitalRoot(num)`. It should sum the digits of a positive integer. If the result is greater than 9 (i.e. more than one digit), sum the digits of the resulting number. Keep repeating until there is only one digit in the result, called the "digital root". **Do not use string conversion within your method.** For further explanation on the digital root concept, refer here: https:n.wikipedia.org/wiki/Digital_root
You may wish to use a helper function, `digitalRootStep(num)` which performs one step of the process.

<details>
<summary>digitalRoot()</summary>

```JS
function digitalRoot(num) {
  if (num < 10) return num;

  return digitalRoot(digitalRoot(Math.floor(num / 10)) + (num % 10));
}
```

</details>

---

Write an `Array.prototype.median` method that returns the median of elements in an array. If the length is even, return the average of the middle two elements.
<details>
<summary>median()</summary>

```JS
Array.prototype.median = function () {
  if (this.length === 0) return null;
  let sorted = this.sort();
  let mid = Math.floor(this.length / 2);

  if (this.length % 2 === 0) {
    return (sorted[mid] + sorted[mid - 1]) / 2;
  } else {
    return sorted[mid];
  }
};
```

</details>

---

Write a function `myFind(array, callback)` that returns the first
element for which the callback returns true. If none is found, the 
function should return `undefined`. Do not use the built-in `Array.prototype.find` method.
<details>
<summary>myFind()</summary>

```JS
function myFind(arr, callback) {
  for (let i = 0; i < arr.length; i++) {
    if (callback(arr[i])) {
      return arr[i];
    }
  }
}

```

</details>

---

Write an `Array.prototype.myFlatten()` method which flattens a multi-dimensional array into a one-dimensional array. Example:
[["a"], "b", ["c", "d", ["e"]]].myFlatten() => ["a", "b", "c", "d", "e"]
<details>
<summary>myFlatten</summary>

```JS
Array.prototype.myFlatten = function () {
  let arr = this.slice(0);
  let flat = [];

  arr.forEach((ele) => {
    if (ele instanceof Array) {
      flat = flat.concat(ele.myFlatten());
    } else {
      flat.push(ele);
    }
  });
  return flat;
}
```

</details>

---

Write a `Function.prototype.myApply(context, argsArr)` method that accepts an object and an array of additional arguments. It should call the function with the passed-in object as `this`, also passing the arguments array. Do NOT use the built-in `Function.prototype.apply` or `Function.prototype.call` methods in your implementation.

<details>
<summary>myApply()</summary>

```JS
Function.prototype.myApply = function (context, args = []) {
  return this.bind(context)(...args);
};

// Also works (passing arguments at bind-time vs call-time)
Function.prototype.myApply = function (context, args = []) {
  return this.bind(context, ...args)();
};

```

</details>

---

Write a `Function.prototype.inherits(ParentClass)` method. It should extend the methods of `ParentClass.prototype` to `ChildClass.prototype`. **Do NOT use `Object.create`, `Object.assign`, `Object.setPrototypeOf`, or modify the `__proto__` property of any object directly.**
<details>
<summary>inherits()</summary>

```JS
Function.prototype.inherits = function(Parent) {
  function Surrogate() {}
  Surrogate.prototype = Parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};
```

</details>

---

Write a `Function.prototype.myCall(context)` method, that accepts an object, and any number of additional arguments. It should call the function with the passed-in object as `this`, also passing the remaining arguments. Do NOT use the built-in `Function.prototype.call` or `Function.prototype.apply` methods in your implementation.
<details>
<summary>myCall()</summary>

```JS
Function.prototype.myCall = function (context, ...args) {
  return this.bind(context)(...args);
};

// Also works (passing arguments at bind-time vs call-time)
Function.prototype.myCall = function (context, ...args) {
  return this.bind(context, ...args)();
};
```

</details>

---

Write a `Function.prototype.myBind(context)` method. It should return a copy of the original function, where `this` is set to `context`. It should allow arguments to the function to be passed both at bind-time and call-time. Note that you are NOT allowed to use ES6 arrow syntax for this problem.

<details>
<summary>myBind</summary>

```JS
Function.prototype.myBind = function (context, ...bindArgs) {
  const that = this;
  return function (...callArgs) {
    return that.apply(context, bindArgs.concat(callArgs));
  };
};

// Without ...bindArgs
Function.prototype.myBind = function (context) {
  let boundArg = Array.from(arguments).slice(1);
  let that = this;
  return function () {
    return that.apply(context, boundArg.concat(Array.from(arguments)));
  };
};

```

</details>

---

Write a `Function.prototype.myCurry(numArgs)` method that collects arguments until the number of arguments collected is equal to the original `numArgs` value and then invokes the curried function.

<details>
<summary>myCurry()</summary>

```JS
Function.prototype.myCurry = function (numArgs) {
  let nums = [];
  let thatFunction = this;

  return function _myCurry(el) {
    nums.push(el);
    if (nums.length < numArgs) {
      return _myCurry;
    } else {
      return thatFunction(...nums);
    }
  };
};
```

</details>

---

Write an `Array.prototype.myEach(callback)` method that invokes a callback for every element in an array and returns undefined. Do NOT use the built-in `Array.prototype.forEach`.

<details>
<summary>myEach()</summary>

```JS
Array.prototype.myEach = function (fxn) {
  for (let i = 0; i < this.length; i++) {
    fxn(this[i]);
  }
};
```

</details>

---

Write an `Array.prototype.myReduce(callback, acc)` method which takes a callback and an optional argument of a default accumulator. If myReduce only receives one argument, then use the first element of the array as the default accumulator. Use the `Array.prototype.myEach` method you defined above. Do NOT call in the built-in `Array.prototype.reduce` or `Array.prototype.forEach` methods.

<details>
<summary>myReduce</summary>

```JS
Array.prototype.myReduce = function (callback, acc) {
  let arr = this.slice();
  if (acc === undefined) {
    acc = arr.shift();
  }

  arr.myEach(el => {
    acc = callback(acc, el);
  });
  return acc;       // must return acc!!
}
```

</details>

---

Write an `Array.prototype.myReject(callback)` method. Return a new array, which contains only the elements for which the callback returns false. Use the `Array.prototype.myEach` method you defined above. Do NOT call the built-in `Array.prototype.filter` or `Array.prototype.forEach` methods. ex.
[1,2,3].myReject( (el) => el > 2 ) => [1, 2]

<details>
<summary>myReject()</summary>

```JS
Array.prototype.myReject = function (callback) {
  let res = [];
  this.myEach(el => {
    if (callback(el) === false) res.push(el);
  });
  return res;
}
```

</details>

---

Write an `Array.prototype.myFilter(callback)` that takes a callback and returns a new array which includes every element for which the callback returned true. Use the `Array.prototype.myEach` method you defined above. Do NOT call the built-in `Array.prototype.filter` or `Array.prototype.forEach` methods.

<details>
<summary>myFilter()</summary>

```JS
Array.prototype.myFilter = function (callback) {
  let res = [];
  this.myEach(el => {
    if (callback(el) === true) res.push(el);
  });
  return res;
}
```

</details>

---

Write an `Array.prototype.mySome(callback)` method which takes a callback and returns true if the callback returns true for ANY element in the array. Otherwise, return false. Use the `Array.prototype.myEach` method you defined above. Do NOT call the built-in `Array.prototype.some` or `Array.prototype.forEach` methods.

<details>
<summary>mySome()</summary>

```JS
Array.prototype.mySome = function (callback) {
  let res = [];
  this.myEach(el => {
    if (callback(el) === true) res.push(el);
  });
  if (res.length) { 
    return true; 
  } else {
    return false;
  }
}
```

</details>

---

Write an `Array.prototype.myEvery(callback)` method that returns true if the callback returns true for every element in the array, and otherwise returns false. Use the `Array.prototype.myEach` method you defined above. Do NOT call the built-in `Array.prototype.every` or `Array.prototype.forEach` methods.

<details>
<summary>myEvery()</summary>

```JS
Array.prototype.myEvery = function (callback) {
  let res = [];
  this.myEach(el => {
    if (callback(el) === true) res.push(el);
  });
  if (res.length === this.length) {
    return true;
  } else {
    return false;
  }
}
```

</details>

---



<details>
<summary></summary>

```JS

```

</details>

---





