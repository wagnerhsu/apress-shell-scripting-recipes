#! /bin/sh

die() {
    result=$1
    shift
    echo ": $*" >&2
    exit $result
}

_filename()
{
    case "$1" in
        */*)
            oldIFS=$IFS
            IFS=/
            set -- $1
            IFS=$oldIFS
            while [ $# -gt 9 ]
            do
              shift 9
            done
            eval "_FILENAME=\$$#"
            ;;
        *) _FILENAME=$1
            ;;
    esac
}

filename()
{
    _filename "$@" && printf "%s\n" "$_FILENAME"
}

cmdpath()
{
    _filename "$1"
    _CMD=$_FILENAME
    oldIFS=$IFS
    IFS=:
    set -- $PATH
    IFS=$oldIFS
    cmd=
    for _DIR
    do
      if [ -x "$_DIR/$_CMD" ]
      then
        cmd="$cmd "$_DIR/$_CMD
      fi
    done
}

echoset()
{
    case `echo " \c"` in
        *\\c) _BSC=
              _DN=-n
              ;;
        *)  _BSC="\c"
            _DN=
           ;;
    esac
}

prompt()
{
    [ -n "$_DN$_BSC" ] || echoset
    echo $_DN "${TAB}$*: ${_BSC}"
}

_bashv()
{
    oldIFS=$IFS
    IFS=.
    set -- `echo 'echo $BASH_VERSION' | ${1:-$SHELL}`
    IFS=$oldIFS
    _BASHV=${1:-0}
}

bashv()
{
    _bashv "$@" && printf "%s\n" "$_BASHV"
}

selectshell()
{
    shells="bash sh bash1 bash2 bash3 ash ksh ksh88 ksh93 pdksh dash"
    echo  "${NL}$eq_bar${NL}"
    echo "${TAB}The following shells appear to be POSIX compliant."
    echo "${TAB}Please select one.${NL}"

    DefaultShell=
    shift $#
    for shell in $shells
    do
      cmdpath "$shell"
      if [ -n "$cmd" ]
      then
        for s in $cmd
        do
          echo 'echo "${HOME##*/}" >/dev/null ' | "$s" 2>/dev/null || continue
          _bashv $s
          DefaultShell=${DefaultShell:-$s}
          if [ "$_BASHV" -gt "${_BASHVERSION:-1}" ]
          then
            _BASHVERSION=$_BASHV
            _BASH=$s
          fi
          set -- ${1+"$@"} $s
          case $# in ?) n=\ $# ;; *) n=$# ;; esac  ## pad number to 2 digits
          echo "${TAB}$n.  $s"
        done
      fi
    done
    set -- ${1+"$@"} ""
    echo "${TAB}$#.  OTHER${NL}${NL}$eq_bar${NL}"
    while :
    do
      prompt "Select from 1 to $#"
      read s
      case $s in
          *[!0-9]*) continue ;;
          "") SELECTSHELL=$DefaultShell
	      break ;;
          $#) prompt "Enter the full path to your POSIX shell"
              read s
              [ -x "$s" ] && SELECTSHELL=$s || continue
              break
              ;;
          *) [ "$s" -gt "$#" ] && continue
             set -- x "$@"
             shift $s
             eval "SELECTSHELL=\$1"
             break
          ;;
      esac
    done
    export SELECTSHELL _BASH _BASHV
    $SELECTSHELL ./install.sh
    exit
}

eq_bar==========================================================================
NL='
'
TAB="   "

echo SELECTSHELL=$SELECTSHELL _BASH=$_BASH
[ -n "$SELECTSHELL" ] || selectshell

[ -d "$HOME/.config" ] || mkdir "$HOME/.config"
configfile=$HOME/.config/script-setup.cfg ## Configuration file

[ -f "$configfile" ] ||
  if [ -x "./Chapter20/script-setup-sh" ]
  then
    ./Chapter20/script-setup-sh || exit 5
  fi

. "$configfile" || die 5 "$configfile not found"

printf "\n\n\n%s\n%s\n\n" "$eq_bar" "Installing scripts"

numscripts=0
totscripts=0
numlines=0
for ch in Chapter??
do
  set -- $ch/*
  totscripts=$(( $totscripts + $# ))

  (
      cd "$ch" || die 5 "Could not change directory to $ch"
      num=${ch#Chapter}
      printf "%s\n    Chapter %d\n\n" "$eq_bar" "${num#0}"
      for script in *
      do
        lines=$(wc -l < "$script")
        numscripts=$(( $numscripts + 1 ))
        numlines=$(( $numlines + $lines ))
        binfile=$InstalDir/${script%-sh}$bin_suffix
        shebang=
        line=
        case $script in
            *-funcs-sh ) scriptname=${script%-sh}$devel_suffix ;;
            *-sh ) scriptname=${script%-sh}$devel_suffix
                   read line < "$script"
                   case $line in
                       */bash*) shebang="#! $_BASH" ;;
                       \#!*) ;;
                       *) shebang="#! $SELECTSHELL" ;;
                   esac
                   ;;
            *.cgi ) scriptname=$script ;;
        esac
        printf "\t%s (%s)\t- %3d lines\n"  "$script" "$shebang" $lines
        {
            [ -n "$shebang" ] && {
              echo "$shebang"
	      case $line in
		  \#!*)
	              tail +2 "$script" ;;
                   *)
                      cat "$script" ;;
              esac
	      } || cat "$script"
        } > "$ScriptDir/$scriptname"
        cp "$ScriptDir/$scriptname" "$binfile"
      done
      printf "\n\t%d scripts installed (%s lines)\n\n" $numscripts $numlines
  )
done

chmod +x $ScriptDir/* $InstalDir/*

printf "\n%s\n\t%d scripts installed\n\n" "$eq_bar" $totscripts

echo "

    To test the scripts, execute the following command at the shell
    prompt:

          PATH=\$PATH:$ScriptDir:$InstalDir

    Put the line it in your shell initialization file so that it will
    be in effect for all future shells.


    Please report problems to Chris F.A. Johnson <cfaj@freeshell.org>.
"
