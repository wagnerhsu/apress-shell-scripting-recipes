
    Shell Scripting Recipes: A Problem-Solution Approach
    by Chris F.A. Johnson
    Apress, 2005
    ISBN 1-59059-471-1


    This archive contains 108 files in 20 directories. Of these, 15
    are libraries containing functions that are required for many of
    the other scripts as well as many designed to be used at the
    command line.  For the scripts to work, these need to be installed
    in your PATH with the -sh suffixes removed.

    The easiest way to do this uses the script development system
    described in Chapter 20. The install.sh script in this directory
    will set up everything you need. Make the directory containing the
    script current (cd ssr-scripts) and invoke the script with:

          ./install.sh

    The script will first look for all POSIX-compliant shells in your
    PATH and ask you to select one. This will be used on the shebang
    line (#! /path/to/shell) of each script. If you make no selection,
    the first one found will be used. If you want to run these scripts
    with a shell that is not in your PATH, you may select OTHER, and
    enter the path to that shell.

    A few scripts require a Bash shell (version 2 or later); the
    install.sh script will look for your copy and use that to execute
    the scripts that need it. If you don't have bash, you will have to
    add the shebang after you have installed bash.

    After the shell has been selected, you will be asked where to
    place the scripts. By default, the scripts are placed in
    $HOME/scripts (for developemnt copies), and $HOME/bin (for
    production scripts).

    The development copies of scripts have the "-sh" suffix, so that
    you can test them while working on them, leaving the (working)
    production versions untouched. You can change the suffix at this
    point, if you like.

    Once the scripts are installed, you need to add the directories to
    your PATH variable, preferably in your shell initialization file
    (e.g., .profile or .bashrc, depending on your shell):

          PATH=$PATH:$HOME/bin:$HOME/scripts

    If you have any problems with the intall.sh script, or any other
    scripts in the book, please e-mail me at cfaj@freeshell.org with a
    description of the problem. Please include any error messages that
    are generated as well as the name and version of the shell you are
    using and the name of version of your operating system.


ssr-scripts
|
|-- Chapter01
|   |-- standard-funcs-sh
|   `-- standard-vars-sh
|-- Chapter02
|   |-- dos2mac-sh
|   |-- dos2unix-sh
|   |-- fed-sh
|   |-- finfo-sh
|   |-- lfreq-sh
|   |-- mac2dos-sh
|   |-- mac2unix-sh
|   |-- prn-sh
|   |-- prw-sh
|   |-- unix2dos-sh
|   |-- unix2mac-sh
|   |-- wbl-sh
|   `-- wfreq-sh
|-- Chapter03
|   |-- bash-funcs-sh
|   |-- char-funcs-sh
|   `-- string-funcs-sh
|-- Chapter04
|   |-- aminus-sh
|   |-- anagram-sh
|   |-- aplus-sh
|   |-- wf-clean-sh
|   |-- wf-compounds-sh
|   |-- wf-funcs-sh
|   |-- wf-setup-sh
|   |-- wf-sh
|   |-- wfb-sh
|   |-- wfc-sh
|   |-- wfe-sh
|   `-- wfit-sh
|-- Chapter05
|   |-- conversion-funcs-sh
|   |-- conversion-sh
|   |-- math-funcs-sh
|   |-- mean-sh
|   |-- median-sh
|   |-- mode-sh
|   |-- range-sh
|   |-- stdev-sh
|   `-- total-sh
|-- Chapter06
|   |-- filename-funcs-sh
|   `-- fixfname-sh
|-- Chapter07
|   `-- path-funcs-sh
|-- Chapter08
|   `-- date-funcs-sh
|-- Chapter09
|   |-- dfcmp-sh
|   |-- lsr-sh
|   |-- sym2file-sh
|   |-- symfix-sh
|   |-- undup-sh
|   `-- zrm-sh
|-- Chapter10
|   |-- pflog-sh
|   |-- pop3-funcs-sh
|   |-- pop3filter-sh
|   |-- pop3list-sh
|   |-- popcheck-sh
|   `-- viewlog-sh
|-- Chapter11
|   |-- ps-envelopes-sh
|   |-- ps-grid-sh
|   `-- ps-labels-sh
|-- Chapter12
|   |-- screen-demo-sh
|   |-- screen-funcs-sh
|   `-- screen-vars-sh
|-- Chapter13
|   |-- bin-pack-sh
|   |-- bu-sh
|   `-- unpack-sh
|-- Chapter14
|   |-- date-file-sh
|   |-- keepnewest-sh
|   `-- rmold-sh
|-- Chapter15
|   |-- db-demo-sh
|   |-- lookup-sh
|   |-- ph-sh
|   |-- phadd-sh
|   |-- phdel-sh
|   |-- phx-sh
|   `-- shdb-funcs-sh
|-- Chapter16
|   |-- cgi-funcs-sh
|   |-- demo.cgi
|   |-- html-funcs-sh
|   |-- mk-htmlindex-sh
|   |-- pretext-sh
|   `-- text2html-sh
|-- Chapter17
|   |-- gle-sh
|   `-- prcalc-sh
|-- Chapter18
|   |-- dice-sh
|   |-- rand-date-sh
|   |-- rand-funcs-sh
|   |-- randomword-sh
|   |-- randsort-sh
|   `-- throw-sh
|-- Chapter19
|   |-- cci-sh
|   |-- cwbw-sh
|   |-- flocate-sh
|   |-- intersperse-sh
|   |-- ipaddr-sh
|   |-- ipaddr.cgi
|   |-- iprev-sh
|   |-- ll-sh
|   |-- name-split-sh
|   |-- rot13-sh
|   |-- rot13a-sh
|   |-- showfstab-sh
|   |-- sus-sh
|   |-- topntail-sh
|   |-- unique-sh
|   `-- unshowfstab-sh
|-- Chapter20
|   |-- cpsh-sh
|   |-- script-setup-sh
|   |-- shcat-sh
|   `-- shgrep-sh
|-- README.txt
`-- install.sh

20 directories, 110 files
