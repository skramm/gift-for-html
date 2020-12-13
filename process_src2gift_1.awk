# This file is part of: gift-for-html
# Author: S. Kramm, 2020
# Home: https://github.com/skramm/gift-for-html


# Step 1: replace inside blocks of code delimited by <pre>
# - all "<" by "&lt;"
# - all ">" by "&gt;"
# and escape reserved Moodle/gift characters

BEGIN { print "// THIS IS A GENERATED FILE, DO NOT EDIT !" }
{
# replace tabs with spaces
	gsub("\t","     ");

	if( $1=="<pre>" ) # opening a "code" block
	{
		code=1;
		print $0;
	}
	else
	{
		if( $1=="</pre>" ) # closing a "code" block
		{
			code=0;
			print $0;
		}
		else
		{ # if "code block", replace < > by html entities and escape Gift reserved characters
			if( code==1 )
			{
				gsub(">","\\&gt;");
				gsub("<","\\&lt;");
#				gsub("{","\\{");
#				gsub("}","\\}");
#				gsub("=","\\=");
#				gsub("#","\\#");
#				gsub(":","\\:"); # colon is processed in step 3
#				gsub("~","\\~");
			}
			print $0;
		}
	}
}

END { print "// END" }
