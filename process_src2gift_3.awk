# process file:
# 1-Replace inside blocks of code delimited by <code>
# - all "<" by "&lt;"
# - all ">" by "&gt;"
# 2 - Escape reserved Moodle/gift characters


#BEGIN { print "// THIS IS A GENERATED FILE, DO NOT EDIT !" }
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
		{ # if answer block, escape {,},=
			if( ablock==1 )
			{
				gsub(">","\\&gt;");
				gsub("<","\\&lt;");
				gsub("{","\\{");
				gsub("}","\\}");
				gsub("#","\\#");
#				gsub("=","\\=");
			}
			print $0;
		}
	}
}
