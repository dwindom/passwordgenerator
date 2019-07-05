# Simple Random Password Generator
# by Douglas Windom
# on 7/5/2019
# Adjust defaults as you see fit
param(
    [int]$Length = 15,
    [int]$MinLower = 3,
    [int]$MinUpper = 3,
    [int]$MinDigits = 3,
    [int]$MinSpecial = 3,
    [int]$Count = 1,
    [switch]$IncludeAllSpecial
)

$Remainder = $Length - $MinLower - $MinUpper - $MinDigits - $MinSpecial

if ( $Remainder -lt 0  ) {
	throw "Invalid number of minimum characters and length specified."
}


$alphalower = (97..122)
$alphaupper = (65..90)
$digits = (48..57)
if ($IncludeAllSpecial) {
	$special = '`~!@#$%^&*()-_=+{}[]\|;:"''<>,./?'.ToCharArray() | foreach {[int]$_}
} else {
	$special = ".-_".ToCharArray() | foreach {[int]$_}
}


for ($n = 0; $n -lt $Count; $n++) {

    $randomlower = @(for($i = 0; $i -lt $MinLower; $i++) {Get-Random -InputObject $alphalower})

    $randomupper = @(for($i = 0; $i -lt $MinUpper; $i++) {Get-Random -InputObject $alphaupper})

    $randomdigits = @(for($i = 0; $i -lt $MinDigits; $i++) {Get-Random -InputObject $digits})

    $randomspecial = @(for($i = 0; $i -lt $MinSpecial; $i++) {Get-Random -InputObject $special})

    if ($Remainder -gt 0) {
        $randomremainder = for($i = 0; $i -lt $Remainder; $i++) {Get-Random -InputObject ($alphalower + $alphaupper + $digits + $special)}
        $password = -join ($randomlower + $randomupper + $randomdigits + $randomspecial + $randomremainder | Get-Random -Count $Length | foreach {[char]$_})
    }
    else {
        $password = -join ($randomlower + $randomupper + $randomdigits + $randomspecial | Get-Random -Count $Length | foreach {[char]$_})
    }

    Write-Output $password
}
