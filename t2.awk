#!/usr/bin/awk -f
BEGIN { RS="\n\n"}
{
	print "processing: " $0;
}
END{print "nb records=" NR }
