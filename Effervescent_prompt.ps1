<#
    .SYNOPSIS
        Microsoft PowerShell - Custom Prompt Script
        'Effervescent_prompt.ps1'
#>


# ☰ ❭ ❯ ❱                           
function Prompt {

    
    $IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    $Reset = "`e[0m"

    if ((Split-Path $PWD -Qualifier) -eq 'C:') {
        $PathColor = "`e[38;5;228m"
        $PathIcon = ""
        $PathTag = "[$PathColor $PathIcon  $Reset]"
    } else {
        $PathColor = "`e[38;5;39m"
        $PathIcon = "󱊟'"
        $PathTag = "[$PathColor $PathIcon $Reset]"
    }

    if ($IsAdmin -eq $True) {
        $UserColor = "`e[38;5;3m"
    } else {
        $UserColor = "`e[38;5;246m"
    }
    

    $Location = Get-Location
    $Path = "$PathTag|$PathColor $Location$Reset "

    $UserTag = "$UserColor   $Reset " + $UserColor + $Env:USERNAME + $Reset + "\" + $Env:USERDOMAIN

    $Network = Get-NetConnectionProfile
    if ($Network.Name -gt '') {
        $WifiTag = "`e[38;5;2m  $($Network.Name) $($Network.Caption)$Reset"
    } else {
        $WifiTag = "`e[38;5;9m  $Reset No Internet Connection..."
    }
    
    $PromptTag = "`e[38;5;230m" + "❯ " + $Reset

    $Time = Get-Date -f 'hh:mm:ss'

    Write-Host "$UserTag | $WifiTag |`e[38;5;174m  $Reset $Time" 
    Write-Host $Path -NoNewline 
    return $PromptTag
}