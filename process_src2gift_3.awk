# This file is part of: gift-for-html
# Author: S. Kramm, 2020
# Home: https://github.com/skramm/gift-for-html


# Step 3 : replace inside gift answer blocks of code delimited by { and }
# - all "<" by "&lt;"
# - all ">" by "&gt;"
# and escape reserved Moodle/gift characters

{
	if( $1=="{" ) # opening an answer block
	{
		ablock=1;
		print $0;
	}
	else
	{
		if( $1=="}" ) # closing an answer block
		{
			ablock=0;
			print $0;
		}
		else
		{                     # if answer block, escape reserved characters
			if( ablock==1 )
			{
				gsub(">","\\&gt;");
				gsub("<","\\&lt;");
				gsub("{","\\{");
				gsub("}","\\}");
				gsub("#","\\#");
				gsub(":","\\:");
#				gsub("=","\\=");
#				gsub("~","\\~");
			}
			print $0;
		}
	}
}
