function Ensure-Dir () {
	local $path=$1 ; shift
	if [ ! -d "${path}" ]; then
		mkdir "${path}"
	fi
}

. ./config/common-setup.scr

