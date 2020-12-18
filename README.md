# gift-for-html

A Moodle/Gift format automatic formatter tool, useful for people authoring Web-related (HTML/CSS) Moodle quizzes.

 * Author: S. Kramm
 * Home: https://github.com/skramm/gift-for-html
 * Licence : GPL v3.0

Pull requests are welcome !

## Motivation

Lots of academics now use the well-known [Moodle](https://en.wikipedia.org/wiki/Moodle) platform to set up quizzes for students.
An easy way to do this is to import questions in some specific format, instead of editing this online.
I use the ["Gift"](https://en.wikipedia.org/wiki/GIFT_(file_format))
format
([Current reference on moodle.org](https://docs.moodle.org/38/en/GIFT_format)).
However, this file format has some pitfalls when building questions for web-related quizzes:
 * Source code can be formatted with the `<pre>` and `<code>` tags, but all the HTML tags will be understood at upload as "real" HTML, thus the tags will be removed by the Moodle uploader.
 * The Gift format has some reserved characters: entering code such as<br>
`body { color:gray; }`<br>
won't work.

Thus, when authoring questions, you would be required to write this:
```
<pre>
body \{ color\:gray; \}
</pre>
```
instead of:
```
<pre>
body { color:gray; }
</pre>
```
While this might sound not too hard, it can become much more cumbersome.
Say you need to insert this code in your question (so that it appears as such!):
```
<a href="p.html#z">text</a>
```
Then you would need to enter this:
```
<pre>
&lt;a href\="p.html\#z"&gt;text&lt;/a&gt;
</pre>
```

This is pretty much a [PITA](https://en.wiktionary.org/wiki/PITA), thus this script:
just type your questions in a file, as regular Gift questions, holding standard HTML/CSS code inside `<pre>` and `<code>` tags.
This script will process it for you and generate a conformant Gift file that you can directly upload into a Moodle instance.

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
Thus, for inline code, there must be only a **single pair** `<code></code>` per line.
For example, this question text will not be processed correctly:
```
What tag can be inside <code><h2></code> and <code></h2></code>.
```
You need to add a linebreak:
```
What tag can be inside <code><h2></code>
and <code></h2></code>.
```

For code blocks, the `<pre>` and `</pre>` tags must be **alone** on their line.

In the answer part of the question, HTML code must also be inserted
into a `<code></code>` (that must be alone on its line).


### 2 - Gift answer blocs
The characters `=` and `~` denoting good and bad answers in the answer part of the question **must** be the first character of the line.
But subsequent `=` and `~` characters will be correctly escaped.
It is also mandatory that the answer blocs identifiers (`{` and `}`) are the single characters of the line.
Thus, the following answer bloc will be correctly processed:
```
{
=some=good~answer
~some=bad~answer
~<code><a nother="b~a~d#">ans~wer:</a></code>
}
```
and will produce this valid Gift answer bloc:
```
{
=some\=good\~answer
~some\=bad\~answer
~<code><a nother="b~a~d#">ans~wer:</a></code>
}
```
While this one won't:
```
{ =good answer ~bad answer }
```

**Warning**: The "answer feedback" part of the Gift specification (identified by `#`) is not handled at present.

### 3 - Other limitations

"Multiple choice", "True-false", "Short answer", "Matching" and "Missing word" questions will be correctly processed, but
"Numerical" questions will fail.
"Multiple choice with multiple right answers" are not handled either.
(see Moodle/Gift reference).

## Testing

Some samples files holding some sample questions are included in repo.
To make sure you understand what this does, enter:
```
$ gift-for-html.sh sampleX.src
```
and checkout the produced file `sampleX.gift`.

If you are interested in this code, some heavy testing would really be helpful.
If you encounter some issue, please report it here.

## Related (?)
 * https://github.com/fuhrmanator/GIFT-grammar-PEG.js

## How does this thing work ?

The main bash script just calls 3 awk scripts, that do some regex-based string replacements:
 * the first one processes all the lines inside code blocs (`<pre>`,`</pre>` tags)
 * the second one processes inline code (`<code>`,`</code>` tags)
 * the third one processes all the reserved characters.

**Side note**: while angle bracket are indeed not a problem for the Gift file format, they are for Moodle, as the uploader will either remove them, either not (unclear at this point).
But if not removed, then they will not be rendered, as the browser will interpret them as "regular" HTML code.
So it is mandatory to escape HTML code into a `<code>`-`</code>` tag pair.
