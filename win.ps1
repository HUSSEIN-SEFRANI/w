# H.sefrani — مُشغّل لوحة إعدادات ويندوز
# يحمّل دائماً آخر نسخة من panel.ps1 (بدون كاش)
$Panel = 'https://raw.githubusercontent.com/HUSSEIN-SEFRANI/w/main/panel.ps1'
$Self  = 'https://raw.githubusercontent.com/HUSSEIN-SEFRANI/w/main/win.ps1'
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
if ($isAdmin) {
    irm "$Panel`?v=$(Get-Random)" -Headers @{ 'Cache-Control' = 'no-cache' } | iex
} else {
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm '$Self`?v=$(Get-Random)' | iex`""
}
