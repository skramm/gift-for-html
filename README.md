# gift-for-html

 * author: S. Kramm
 * home: https://github.com/skramm/gift-for-html

## Motivation

Lots of academics now use the well-known Moodle program to set up quizzes.
An easy way to to this is to import questions in some specific format, instead of editing this online.
I use the "gift" format (see ref. below).
However, this format has some pitfalls when building questions for web-related quizzes.
 * HTML code can be formatted with the html `<pre>` and `<code>` tags, but all the HTML tags will be parsed as "real" HTML.
 * The GIFT format has some reserved characters, thus entering code such as<br>
`body { color:gray; }`<br>
won't work.


## Usage
This program will take as input a text file (.src extension, but this can be changed)
holding gift questions 
and generate a .gift file, that can be directly imported into Moodle.

All it does is some text replacement.

## Reference
https://docs.moodle.org/38/en/GIFT_format
