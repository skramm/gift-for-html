# name: gift-for-html
# author: S. Kramm
# home: https://github.com/skramm/gift-for-html


# Replace inside blocks of code delimited by <pre>
# - all "<" by "&lt;"
# - all ">" by "&gt;"

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
		{ # if "code block", replace < > by html entities and escape { and } (Gift reserved characters)
			if( code==1 )
			{
				gsub(">","\\&gt;");
				gsub("<","\\&lt;");
				gsub("{","\\{");
				gsub("}","\\}");
				gsub("=","\\=");
			}
			print $0;
		}
	}
}

END { print "// END" }
