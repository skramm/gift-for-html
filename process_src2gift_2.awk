# process file:
# 1-Replace inside blocks of code delimited by <code>
# - all "<" by "&lt;"
# - all ">" by "&gt;"
# 2 - Escape reserved Moodle/gift characters

# FS: Field Separator
# We define here as FS a regex that will match both <code> and </code>
BEGIN {	FS="[<][/]?[c][o][d][e][>]"; }
{
	gsub(">","\\&gt;",$2);
	gsub("<","\\&lt;",$2);
	if( NF >= 3 )
	{
		gsub("{","\\{",$2); # escape {, }, =
		gsub("}","\\}",$2);
		gsub("=","\\=",$2);
		print $1 "<code>" $2 "</code>" $3
	}
	else
		print $0
}
