# ============================================================
#  لوحة إعدادات ما بعد تنصيب ويندوز
#  التشغيل:  irm <الرابط> | iex      (في PowerShell)
#  اضغط على أي مربع لتنفيذه. الأخضر = تم، الأحمر = فشل.
# ============================================================

$SelfUrl = 'hussein-sefrani.github.io/w'

function Start-WinPanel {

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# --- برامج Ninite (أسماء ninite.com مفصولة بـ -) ---
$NiniteApps = '7zip-sumatrapdf-vlc'

function Set-Reg($Path, $Name, $Value, $Type = 'DWord') {
    if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
}

$Adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

# M = $true  => من المهام الأساسية (ينفّذها زر "تطبيق الكل")
$Tasks = @(
    @{ M = $true; T = '1- أيقونات سطح المكتب'; D = 'الكمبيوتر + الشبكة + لوحة التحكم'
       S = { $icons = '{20D04FE0-3AEA-1069-A2D8-08002B30309D}',   # هذا الكمبيوتر
                      '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}',   # الشبكة
                      '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}'    # لوحة التحكم
             foreach ($k in 'NewStartPanel', 'ClassicStartMenu') {
                 foreach ($i in $icons) { Set-Reg "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\$k" $i 0 }
             } } },

    @{ M = $true; T = '2- شريط المهام'; D = 'بدون بحث + ابدأ يساراً + كل الرموز'
       S = { Set-Reg 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' 'SearchboxTaskbarMode' 0
             Set-Reg $Adv 'TaskbarAl' 0
             Set-Reg 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' 'EnableAutoTray' 0
             $n = 'HKCU:\Control Panel\NotifyIconSettings'
             if (Test-Path $n) { Get-ChildItem $n | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name 'IsPromoted' -Value 1 -Type DWord -Force } } } },

    @{ M = $true; T = '3- حذف OneDrive من الجذور'; D = 'من الشريط الجانبي للمستكشف'
       S = { foreach ($p in 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}',
                            'HKCU:\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}') {
                 Set-Reg $p 'System.IsPinnedToNameSpaceTree' 0 } } },

    @{ M = $true; T = '4- القائمة اليمنى القديمة'; D = 'النقر بالزر الأيمن (ويندوز 11)'
       S = { New-Item -Path 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' -Value '' -Force | Out-Null } },

    @{ M = $true; T = '5- منع البحث في الإنترنت'; D = 'من قائمة ابدأ (Bing)'
       S = { Set-Reg 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' 'DisableSearchBoxSuggestions' 1
             Set-Reg 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' 'BingSearchEnabled' 0
             Set-Reg 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' 'CortanaConsent' 0 } },

    @{ M = $true; T = '6- تثبيت البرامج (Ninite)'; D = 'VLC + 7-Zip + SumatraPDF'
       S = { $exe = "$env:TEMP\ninite.exe"
             Invoke-WebRequest "https://ninite.com/$NiniteApps/ninite.exe" -OutFile $exe -UseBasicParsing
             Start-Process $exe } },

    @{ M = $true; T = '7- تطبيق التغييرات'; D = 'إعادة تشغيل المستكشف'
       S = { Stop-Process -Name explorer -Force } },

    # ======== إعدادات إضافية (اختيارية) ========
    @{ T = 'إظهار امتدادات الملفات'; D = '.pdf  .docx  .exe'
       S = { Set-Reg $Adv 'HideFileExt' 0 } },

    @{ T = 'إظهار الملفات المخفية'; D = 'في مستكشف الملفات'
       S = { Set-Reg $Adv 'Hidden' 1 } },

    @{ T = 'الوضع الداكن'; D = 'للنظام والتطبيقات'
       S = { $p = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
             Set-Reg $p 'AppsUseLightTheme' 0; Set-Reg $p 'SystemUsesLightTheme' 0 } },

    @{ T = 'تقليل جمع البيانات'; D = 'Telemetry'
       S = { Set-Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' 'AllowTelemetry' 0 } },

    @{ T = 'طاقة عالية الأداء'; D = 'High Performance'
       S = { powercfg -setactive SCHEME_MIN; if ($LASTEXITCODE) { throw 'خطة الطاقة غير متوفرة' } } },

    @{ T = 'إيقاف الإسبات'; D = 'يوفّر مساحة ويُلغي البدء السريع'
       S = { powercfg /hibernate off } },

    @{ T = 'تفعيل سطح المكتب البعيد'; D = 'Remote Desktop + الجدار الناري'
       S = { Set-Reg 'HKLM:\System\CurrentControlSet\Control\Terminal Server' 'fDenyTSConnections' 0
             Enable-NetFirewallRule -Group '@FirewallAPI.dll,-28752' } },

    @{ T = 'إنشاء نقطة استعادة'; D = 'نسخة احتياطية للنظام'
       S = { Enable-ComputerRestore -Drive "$env:SystemDrive\"
             Set-Reg 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' 'SystemRestorePointCreationFrequency' 0
             Checkpoint-Computer -Description 'بعد تنصيب ويندوز' -RestorePointType MODIFY_SETTINGS } },

    @{ T = 'تحديث كل البرامج'; D = 'winget upgrade --all'
       S = { Start-Process powershell -ArgumentList '-NoExit', '-Command', 'winget upgrade --all --accept-source-agreements --accept-package-agreements' } },

    @{ T = 'تحديثات ويندوز'; D = 'فتح Windows Update والبحث'
       S = { Start-Process 'ms-settings:windowsupdate'; Start-Process UsoClient -ArgumentList 'StartInteractiveScan' -WindowStyle Hidden } }
)

$cIdle = [Drawing.Color]::FromArgb(45, 55, 72)
$cMain = [Drawing.Color]::FromArgb(43, 108, 176)
$cRun  = [Drawing.Color]::FromArgb(214, 158, 46)
$cOk   = [Drawing.Color]::FromArgb(56, 161, 105)
$cErr  = [Drawing.Color]::FromArgb(197, 48, 48)

$form = New-Object Windows.Forms.Form
$form.Text = 'لوحة إعدادات ويندوز'
$form.Size = New-Object Drawing.Size(940, 760)
$form.StartPosition = 'CenterScreen'
$form.BackColor = [Drawing.Color]::FromArgb(26, 32, 44)
$form.Font = New-Object Drawing.Font('Segoe UI', 10)
$form.RightToLeft = 'Yes'
$form.RightToLeftLayout = $true
$form.TopMost = $true

$log = New-Object Windows.Forms.TextBox
$log.Multiline = $true; $log.ReadOnly = $true; $log.ScrollBars = 'Vertical'
$log.Dock = 'Bottom'; $log.Height = 120
$log.BackColor = [Drawing.Color]::FromArgb(17, 24, 39); $log.ForeColor = [Drawing.Color]::Gainsboro
$log.Font = New-Object Drawing.Font('Consolas', 9)
$log.RightToLeft = 'No'
function Write-Log($msg) { $log.AppendText("[$(Get-Date -Format HH:mm:ss)] $msg`r`n") }

$bar = New-Object Windows.Forms.Panel
$bar.Dock = 'Bottom'; $bar.Height = 50

$panel = New-Object Windows.Forms.FlowLayoutPanel
$panel.Dock = 'Fill'; $panel.AutoScroll = $true; $panel.Padding = New-Object Windows.Forms.Padding(12)

function Invoke-Tile($btn) {
    $task = $btn.Tag
    $btn.BackColor = $cRun; $btn.Refresh()
    try {
        & $task.S
        $btn.BackColor = $cOk
        $btn.Text = "✔  $($task.T)`n$($task.D)"
        Write-Log "تم: $($task.T)"
    } catch {
        $btn.BackColor = $cErr
        $btn.Text = "✖  $($task.T)`n$($task.D)"
        Write-Log "فشل: $($task.T) — $($_.Exception.Message)"
    }
    [Windows.Forms.Application]::DoEvents()
}

function Add-Header($text) {
    $h = New-Object Windows.Forms.Label
    $h.Text = $text; $h.AutoSize = $true
    $h.ForeColor = [Drawing.Color]::FromArgb(160, 174, 192)
    $h.Font = New-Object Drawing.Font('Segoe UI', 11, [Drawing.FontStyle]::Bold)
    $h.Margin = New-Object Windows.Forms.Padding(6, 10, 6, 2)
    $panel.Controls.Add($h)
    $panel.SetFlowBreak($h, $true)
}

$buttons = @()
$lastMain = $null
$extrasShown = $false
Add-Header 'المهام الأساسية (بالترتيب)'
foreach ($t in $Tasks) {
    if (-not $t.M -and -not $extrasShown) {
        if ($lastMain) { $panel.SetFlowBreak($lastMain, $true) }
        Add-Header 'إعدادات إضافية'
        $extrasShown = $true
    }
    $b = New-Object Windows.Forms.Button
    $b.Size = New-Object Drawing.Size(210, 95)
    $b.Margin = New-Object Windows.Forms.Padding(6)
    $b.FlatStyle = 'Flat'; $b.FlatAppearance.BorderSize = 0
    $b.BackColor = $(if ($t.M) { $cMain } else { $cIdle }); $b.ForeColor = [Drawing.Color]::White
    $b.Font = New-Object Drawing.Font('Segoe UI', 10, [Drawing.FontStyle]::Bold)
    $b.Text = "$($t.T)`n$($t.D)"
    $b.Tag = $t
    $b.Cursor = 'Hand'
    $b.Add_Click({ Invoke-Tile $this })
    $panel.Controls.Add($b)
    $buttons += $b
    if ($t.M) { $lastMain = $b }
}

function New-BarButton($text, $x, $color, $action) {
    $bb = New-Object Windows.Forms.Button
    $bb.Text = $text; $bb.Size = New-Object Drawing.Size(200, 36); $bb.Location = New-Object Drawing.Point($x, 7)
    $bb.FlatStyle = 'Flat'; $bb.FlatAppearance.BorderSize = 0
    $bb.BackColor = $color; $bb.ForeColor = [Drawing.Color]::White
    $bb.Add_Click($action)
    $bar.Controls.Add($bb)
}

New-BarButton 'تطبيق الكل (1 → 7)' 12 ([Drawing.Color]::FromArgb(49, 130, 206)) {
    foreach ($x in $buttons) { if ($x.Tag.M -and $x.BackColor -ne $cOk) { Invoke-Tile $x } }
    Write-Log 'انتهت المهام الأساسية.'
}
New-BarButton 'إعادة تشغيل الكمبيوتر' 224 ([Drawing.Color]::FromArgb(113, 128, 150)) {
    if ([Windows.Forms.MessageBox]::Show('إعادة تشغيل الكمبيوتر الآن؟', 'تأكيد', 'YesNo', 'Question') -eq 'Yes') { Restart-Computer -Force }
}

$form.Controls.Add($panel)
$form.Controls.Add($bar)
$form.Controls.Add($log)
$form.Add_Shown({ $form.TopMost = $false; $form.Activate() })
Write-Log 'جاهز. اضغط على أي مربع، أو "تطبيق الكل".'
[void]$form.ShowDialog()
}

# --- التشغيل كمسؤول ---
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Start-WinPanel
} elseif ($PSCommandPath) {
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
} else {
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm $SelfUrl | iex`""
}
