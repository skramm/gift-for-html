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

	print "NR=" NR " NF_A=" NF " line=" $0
	if( NF == 2 )
	{
		print "NF_B=" NF " arg1=*" $1 "* arg2=*" $2 "*"
		print "line:" $0 > "/dev/stderr"
#		exit 1
	}

}
