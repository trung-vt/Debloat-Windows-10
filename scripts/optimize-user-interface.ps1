#   Description
# This script will:
#   (1) change mouse and keyboard settings
#   (2) disable Game DVR and Game Bar, plus some stuff
#   (3) restore old volume slider
#   (4)*** set Explorer options
#   (5) remove user folders under This PC


Import-Module -DisableNameChecking $PSScriptRoot\..\lib\New-FolderForced.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1

Write-Output "Elevating priviledges for this process"
do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)


#   (1) change mouse and keyboard settings
Write-Output "Change mouse and keyboard settings"
& "optimize-user-interface\mouse-keyboard.ps1"  # CHECK THE FILE!


#   (2) disable Game DVR and Game Bar
Write-Output "Disable Game DVR and Game Bar"
New-FolderForced -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowgameDVR" 0


#   (3) restore old volume slider
Write-Output "Restoring old volume slider"
New-FolderForced -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC"
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" "EnableMtcUvc" 0


#   (4)*** set Explorer options
Write-Output "Setting Explorer options (folder view, Aero-Shake...)"
& "optimize-user-interface\set-explorer-options.ps1"  # CHECK THE FILE!


# #   (5) remove user folders under This PC
# Write-Output "Removing user folders (Desktop, Documents, Downloads, Music, Pictures, Videos, 3D Objects) under This PC"
# & "optimize-user-interface\remove-folders.ps1"  # CHECK THE FILE!


#echo "Disabling tile push notification"
#New-FolderForced -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
#sp "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" "NoTileApplicationNotification" 1
