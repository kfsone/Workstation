# Library of common shell functions


FAIL=-1
SUCCESS=0


# -----------------------------------------------------------------------------
# Set (-o) or clear (+o) good behavior flags.
#
function set_behavior() {
  set $1 nounset errexit pipefail
  hash -r
}


# -----------------------------------------------------------------------------
# sets flags that will cause errors to invoke 'exit'.
#
function exit_on_errors ()
{
  set -o errexit
  ERRORS_FATAL=1
}


# -----------------------------------------------------------------------------
# if ERRORS_FATAL is set or 'errexit' shell options, then we call exit
# with ${1} as an exit code, otherwise we return it as a value.
#
function _return_or_exit ()
{
  local ec=${1}; shift

  if [ -n "${ERRORS_FATAL}" -o -n "$(set -o | grep errexit.*on)" ]; then
    exit ${ec}
  fi
  return ${ec}
}


# -----------------------------------------------------------------------------
# usage "<usage string>" ["<description>"]
# Prints a single usage line prefixed with 'Usage:' and the script name,
# if description is supplied it is printed as an escape-parsed string
# on the next line(s).
# 
function give_usage ()
{
  local usage="${1}"; shift
  local desc="${1}"

  echo Usage: ${0} ${usage}
  if [ -n "${desc}" ]; then echo -e "${desc}"; fi

  _return_or_exit 1
}


# -----------------------------------------------------------------------------
# takes the first argument as an error/return code and the remaining
# parameters as an error message to display prefixed by 'ERROR:'.
# returns the error code unless FATAL_ERRRORS is set, in which case
# exit is called.
#
function die_with ()
{
  local ec=${1}; shift

  echo >&2 ERROR: $@

  _return_or_exit ${ec}
}


# -----------------------------------------------------------------------------
# die with a default error code of 1
#
function die ()
{
  die_with 1 ${*}
  return ${?}
}

# -----------------------------------------------------------------------------
# if DEBUG environment variable is set, writes the given parameters to
# stdout prefixed by a '#' to indicate a comment.
#
function debug_info ()
{
  if [ -n "${DEBUG:-}" ]; then echo '#' ${*}; fi
}


# -----------------------------------------------------------------------------
# Status message
#
function status ()
{
  echo "-- $@"
}


# -----------------------------------------------------------------------------
# if DEBUG environment variable is set, writes the given parameters to
# stdout prefixed by 'WARNING:' to indicate a warning.
#
function warn_info ()
{
  if [ -n "${DEBUG:-}" ]; then echo WARNING: ${*}; fi
}

# -----------------------------------------------------------------------------
# checks that all given arguments meet the given test or reports
# the given error. Assumes files unless the first path is "--dir"
#
function require_stat ()
{
  local check="${1}" ; shift
  local error="${2}" ; shift
  local type="file"

  if [ -n "${1}" -a "${1}" = "--dir" ]; then type="directory"; shift; fi

  for path in "$@"
  do
    if [ ! "${check}" "${path}" ]; then die "${error} ${type}: ${path}"; fi
  done
}

# -----------------------------------------------------------------------------
# terminates the script if any of the given files (or --dir for directories)
# already exist
#
function require_exists ()
{
  local type="file"
  local typecheck="-f"
  local not=false

  while [[ -n "${1}" && "${1}" =~ '--' ]]
  do
    if [ "${1}" = "--dir" ]
    then
      type="directory"; typecheck="-d"; shift
    elif [ "${1}" = "--not" ]
    then
      not=:; shift
    else
      die "Unrecognized argument: $1"
    fi
  done

  for path in "$@"
  do
    if [ -e "${path}" ]
    then
      if ${not}; then die "'${path}': ${type} already exists."; fi
      if [ ! ${typecheck} "${path}" ]
      then
        die "'${path}' exists but is not a ${type}."
      fi
    else
      if ! ${not}; then die "'${path}': ${type} does not exist."; fi
    fi
  done
}

# -----------------------------------------------------------------------------
# tries to change directory to ${1}. If it fails, it reports the problem
# and terminates. If $2 is specified, it is annotated as a source for
# the error.
#
function cd_or_die ()
{
  local dir=${1}; shift
  local src=${1:-}

  if ! cd "${dir}"
  then
    if [ -n "${src}" ]
    then
      die "Could not cd to ${dir} (${src})."
    else
      die "Could not cd to ${dir}."
    fi
    return ${?}
  fi
  if [ -n "${src}" ]
  then
    debug_info "Changed directory to ${dir} (${src})."
  else
    debug_info "Changed directory to ${dir}."
  fi
  return ${SUCCESS}
}

# -----------------------------------------------------------------------------
# treats arguments as a commandline to be executed.
# if the command returns a non-zero exit code, it will be
# considered a critical failure and the script will be
# terminated with error code 2.
#
function execute_or_die ()
{
  debug_info Attempting: ${@}

  eval ${@}
  local ec=$?
  if [ ! ${ec} ]; then
    die_with ${ec} Got ${ec} from ${@}
    return ${ec}
  fi

  return ${SUCCESS}
}

# -----------------------------------------------------------------------------
# Add one or more paths to the PATH variable and export the result,
# unless '-x' is specified.
#
function add_paths ()
{
  local added=0
  local do_export=1

  while [ -n "${1}" ]
  do
    local path="${1}"; shift
    if [ "${path}" = "-x" ]
    then
      do_export=0
    elif [[ ! "${PATH}" =~ "(^|:)${path}(:|\$)" ]]
    then
      if [ -n "${PATH}" ]; then PATH+=":"; fi
      PATH+="${path}"
      added=$((added + 1))
    fi
  done

  # My reason for doing this is lost in the annals of time,
  # but avoid exporting the path when it hasn't changed.
  if [ ${do_export} -a ${added} ]; then export PATH; fi

  return ${SUCCESS}
}


# -----------------------------------------------------------------------------
# Print a colorized message to the console.
#
function color_message() {
  local color=$1 ; shift
  if [ -z "${TERM}" ]; then tput setaf ${color} ; fi
  echo "* $@"
  if [ -z "${TERM}" ]; then tput sgr0 ; fi
}


# -----------------------------------------------------------------------------
# Source a script file, but if it doesn't exist, don't consider it an error
function source_if_exists() {
  local file=$1 ; shift
  if [ -e "${file}" ]; then
	  debug_info "Sourcing ${file}"
	  . "${file}"
  fi
}


# -----------------------------------------------------------------------------
# Activate a virtualenv.
#
function activate_venv () {
  color_message 6 "activating ${1}"
  set_behavior +o
  . "${1}"/bin/activate
}

