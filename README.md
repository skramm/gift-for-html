# gift-for-html

 * author: S. Kramm
 * home: https://github.com/skramm/gift-for-html
 * licence : GPL v3.0

Pull requests are welcome !

## Motivation

Lots of academics now use the well-known [Moodle](https://en.wikipedia.org/wiki/Moodle) platform to set up quizzes for students.
An easy way to do this is to import questions in some specific format, instead of editing this online.
I use the ["gift"](https://docs.moodle.org/38/en/GIFT_format)
format.
However, this file format has some pitfalls when building questions for web-related quizzes:
 * Source code can be formatted with the `<pre>` and `<code>` tags, but all the HTML tags will be parsed as "real" HTML.
 * The GIFT format has some reserved characters, thus entering code such as<br>
`body { color:gray; }`<br>
won't work.

Thus, when authoring questions, you would be required to write this:
```
body \{ color:gray; \}
```
instead of:
```
body { color:gray; }
```
and this:
```
&lt;a href\="p.html"&gt;text&lt;/a&gt;
```
instead of this
```
<a href="p.html">text</a>
```

This is pretty much a PITA, thus this script:
just type your questions as regular gift questions, holding standard HTML/CSS code inside `<pre>` and `<code>` tags, and the script will process for you and generate acceptable gift file.

## Usage
This program will take as input a text file (.src extension, but this can be changed)
holding gift questions
and generate a .gift file, that can be directly imported into Moodle.

Usage:
```
$ ./gift-for-html my_input_file.src
```

All it does is some text replacement.

To install (4 files), just clone the repo and run `sudo ./install.sh`.
Should work out of the box on any standard Linux platform.

## Limitations

### 1 - One pair of inline code tags per line
This does a "per-line" text replacement (awk based).
Thus, for inline code, there must be only a single `<code></code>` per line.

### 2 - Gift special characters in answer blocs
Another (present) limitation is that the gift-special characters `=` and `~` **cannot** be used in answer fields.
For the latter, it is barely used in HTML/CSS code, but the first one is regularly used.

This is because these 2 characters are used as "good/bad" answers designators.

Thus, if you expect as (good) answer this:
```
<tag attrib="value">
```
you will need to type this as "answer bloc":
```
{
=<tag attrib\="value">
}
```

Related: although the gift specification does not require this, it is mandatory that the answer blocs are identified by a `{` and `}` that are the single characters of the line.

## Testing

A sample question is included.
To make sure to understand what it does, enter:
```
$ ./gift-for-html.sh sample1.src
```
and checkout the produced file `sample1.gift`.
