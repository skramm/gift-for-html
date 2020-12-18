# This file is part of: gift-for-html
# Author: S. Kramm, 2020
# Home: https://github.com/skramm/gift-for-html


# Step 3: replace inside gift answer blocks of code delimited by `{` and `}`
# and escape reserved Moodle/gift characters

{
	if( $1=="{" ) # opening an answer block
	{
		ablock=1;
		print $0;
#		print "ANSWER BLOCK OPEN"
	}
	else
	{
		if( $1=="}" ) # closing an answer block
		{
			ablock=0;
			print $0;
#			print "ANSWER BLOCK CLOSE"
		}
		else            # not closing nor opening an answer block
		{
			printLine=1;
			if( ablock==0 )                  # if not an answer block, process all `:`
			{
#				print "NOT ANSWER BLOCK"
				if( !($0 ~ /^[$].+/) )       # if '$' is NOT the first char of line ("category" line)
				{
					if( $0 !~ /[:]{2}/ )     # if line does NOT hold `::` (question title)
					{
						{
							gsub(":","\\:"); # THEN escape reserved characters
							gsub("{","\\{");
							gsub("}","\\}");
							gsub("#","\\#");
							gsub("=","\\=");
							gsub("~","\\~");
						}
					}
				}
				print $0;
			}
			else
			{                         # if answer block, escape reserved characters
#				print "ANSWER BLOCK"
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
						print "~" line
						printLine=0;
					}
				}
				if( printLine )
					print $0;
			}
		}
	}
}
