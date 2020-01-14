# gift-for-html

 * author: S. Kramm
 * home: https://github.com/skramm/gift-for-html
 * licence : GPL v3.0

Pull requests are welcome !

## Motivation

Lots of academics now use the well-known [Moodle](https://en.wikipedia.org/wiki/Moodle) platform to set up quizzes for students.
An easy way to do this is to import questions in some specific format, instead of editing this online.
I use the ["Gift"](https://en.wikipedia.org/wiki/GIFT_(file_format))
format
([Current reference on moodle.org](https://docs.moodle.org/38/en/GIFT_format)).
However, this file format has some pitfalls when building questions for web-related quizzes:
 * Source code can be formatted with the `<pre>` and `<code>` tags, but all the HTML tags will be understood at upload as "real" HTML, thus the tags will be removed.
 * The Gift format has some reserved characters: entering code such as<br>
`body { color:gray; }`<br>
won't work.

Thus, when authoring questions, you would be required to write this:
```
<pre>
body \{ color:gray; \}
</pre>
```
instead of:
```
<pre>
body { color:gray; }
</pre>
```
and this:
```
<pre>
&lt;a href\="p.html"&gt;text&lt;/a&gt;
</pre>
```
instead of this
```
<pre>
<a href="p.html">text</a>
</pre>
```

This is pretty much a PITA, thus this script:
just type your questions as regular Gift questions, holding standard HTML/CSS code inside `<pre>` and `<code>` tags, this script will process it for you and generate a conformant Gift file.

## Usage
This program will take as input a text file (.src extension, but this can be changed)
holding gift questions
and generate a .gift file, that can be directly imported into Moodle.

Usage:
```
$ gift-for-html my_input_file.src
```

All it does is some text replacement.

To install (4 files), just clone the repo and run `sudo ./install.sh`.
Should work out of the box on any standard Linux platform (requires Bash and Awk only).

## Features and limitations

### 1 - HTML code tags
This does a "per-line" text replacement.
Thus, for inline code, there must be only a single pair `<code></code>` per line.
For code blocks, the `<pre>` and `</pre>` tags must be alone on their line.

In the answer part of the question, HTML code can be given "as-is" and will be correctly escaped.

### 2 - Gift answer blocs

The characters `=` and `~` denoting good and bad answers in the answer part of the question MUST be the first character of the line.
But subsequent `=` and `~` characters will be correctly escaped.
It is also mandatory that the answer blocs identifiers (`{` and `}`) are the single characters of the line.
Thus, the following answer bloc will be correctly processed:
```
{
=some=good~answer
~some=bad~answer
~<a nother="bad#">answer:</a>
}
```
and will produce this valid Gift answer bloc:
```
{
=some\=good\~answer
~some\=bad\~answer
~&lt;a nother\="bad\#"&gt;answer\:&lt;/a&gt;
}
```
While this one won't:
```
{ =good answer ~bad answer }
```
**Warning**: The "answer feedback" part of the Gift specification  (identified by `#`) is not handled at present.

## Testing

A sample file holding a single question is included in repo.
To make sure you understand what it does, enter:
```
$ gift-for-html.sh sample1.src
```
and checkout the produced file `sample1.gift`.
