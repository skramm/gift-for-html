# This file is part of: gift-for-html
# Author: S. Kramm, 2020
# Home: https://github.com/skramm/gift-for-html


# Step 2: replace inside code snippets delimited by `<code>` and `</code>`
# - all "<" by "&lt;"
# - all ">" by "&gt;"

# FS: Field Separator
# We define here as FS a regex that will match both <code> and </code>
BEGIN {	FS="[<][/]?[c][o][d][e][>]"; }
{
	gsub(">","\\&gt;",$2);
	gsub("<","\\&lt;",$2);
	if( NF >= 3 )        # only if we have exactly 3 fields
	{
		print $1 "<code>" $2 "</code>" $3
	}
	else
		print $0
}
