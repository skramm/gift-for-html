# name: gift-for-html
# author: S. Kramm
# home: https://github.com/skramm/gift-for-html


# Replace inside blocks of code delimited by <pre>
# - all "<" by "&lt;"
# - all ">" by "&gt;"

BEGIN { print "// THIS IS A GENERATED FILE !" }
{
# replace tabs with spaces
	gsub("\t","     ");

	if( $1=="<pre>" || $1 == "<code>" ) # opening a "code" block
#	if( /<pre>/ || /<code>/ )
	{
		code=1;
		print $0;
	}
	else
	{
		if( $1=="</pre>" || $1=="</code>" ) # closing a "code" block
#		if( $/<\/pre>/ || /<\/code>/ ) # closing a "code" block
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
