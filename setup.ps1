Function Ensure-Dir {
	Param([Parameter(Mandatory = $true)][String] $Path)

	if (!(Test-Path $Path)) {
		$dir = mkdir $Path
	}
}

$scriptSrc = "./config/common-setup.scr"
$scriptPs1 = "./config/common-setup.ps1"

mv $scriptSrc $scriptPs1
& $scriptPs1
mv $scriptPs1 $scriptSrc
