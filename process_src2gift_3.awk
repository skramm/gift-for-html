# This file is part of: gift-for-html
# Author: S. Kramm, 2020
# Home: https://github.com/skramm/gift-for-html


# Step 3: replace inside gift answer blocks of code delimited by `{` and `}`
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
		{
			printLine=1;
			if( ablock==0 )                  # if not an answer block, process `:`
			{
				if( !($0 ~ /^[$].+/) )       # if '$' is NOT the first char of line
				{
					if( $0 !~ /[:]{2}/ )     # if line does NOT hold `::`
					{
						if( $0 ~ /[:]/ )     # if line holds `:`
							gsub(":","\\:"); # THEN replace singles `:` by `\:`
					}
				}
				print $0;
			}
			else
			{                         # if answer block, escape reserved characters and HTML < and >
#				gsub(">","\\&gt;");
				gsub("<","\\&lt;");
				gsub("{","\\{");
				gsub("}","\\}");
				gsub("#","\\#");
				gsub(":","\\:");
# This part will process answer lines, that MUST start with '=' (good answer) or '~' (bad answer)
				if( $0 ~ /^[=].+/ )        # if '=' is first char of line
				{
					line=substr($0,2)      # fetch all but first char
					gsub("=","\\=",line);  # replace
					gsub("~","\\~",line);

					if( $line !~ /->/ )            # if line does not hold "match" answers
						gsub(">","\\&gt;",line);   # then, replace
					print "=" line
					printLine=0;
				}
				else
				{
					if( $0 ~ /^[~].+/ )        # if '~' is first char of line
					{
						line=substr($0,2)
						gsub("=","\\=",line);
						gsub("~","\\~",line);
						if( $line !~ /->/ )            # if line does not hold "match" answers
							gsub(">","\\&gt;",line);   # then, replace
						print "~" line
						printLine=0;
					}
					else
						gsub(">","\\&gt;");
				}
				if( printLine )
					print $0;
			}
		}
	}
}
