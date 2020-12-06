#!/usr/bin/env awk
{
#	print "processing: " $0
	if( $0 !~ /[:]{2}/ ) # && $1 ~ /[:]*/ )  # if NOT :: AND :
	{                       # replace singles `:` by `\:`
#		print "MATCH 1: $0=" $0
		if( $0 ~ /[:]/ )
		{
#			print "MATCH 2"
			gsub(":","\\:")
		}
#		gsub("::","*-a*-a*-a"); # highly unlikely pattern !
#		gsub(":","\\:")
#		gsub("*-a*-a*-a","::");
	}
	print $0;
}
