#!/usr/bin/env bash

## Load functions
. cgi-funcs

## The content-type header must be followed by a blank line
printf "Content-type: text/html\n\n"

## Print page head element
printf "%s\n" "<html>" " <head>" "<title>Welcome</title>" \
              " </head>" " <body>"
printf "%s\n" " <center>"

## Print various bits of information
date
printf "<h3>You are connected from: %s</h3>\n" "$REMOTE_ADDR"
printf "Your browser is:<br>%s<br>\n" "$HTTP_USER_AGENT"
printf "<br>You have appended the following QUERY_STRING:<br>\n"
printf "<br>%s:\n" "$QUERY_STRING"

printf "<br><br>%s\n" "<table><th>VARIABLE<th>VALUE"

## Parse the QUERY_STRING
## Elements of QUERY_STRING are separated by ampersands
IFS='&'
set -- $QUERY_STRING
for arg    ## Loop through the elements
do
   _dehex "$arg"
   case $_DEHEX in
	        *=*) ## Split into VARIABLE and VALUE
             var=${_DEHEX%%=*}
             val=${_DEHEX#*=}
             ;;
        *) var=; val=$_DEHEX ;;
   esac
   printf "<tr><td>%s</td><td>%s</td></tr>\n" "${var:---}" "$val"
done
printf "%s\n" "</table>"

## Tidy up
printf "</body>\n</html>"

