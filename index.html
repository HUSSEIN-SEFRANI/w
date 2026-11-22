# ملاحظة: مع RightToLeft = Yes يعكس ويندوز محاذاة النص، لذا Left تعني يمين الشاشة.
# ============================================================
#  لوحة إعدادات ما بعد تنصيب ويندوز  —  v2
#  التشغيل:  irm is.gd/Sefrani | iex
# ============================================================

$SelfUrl = 'https://raw.githubusercontent.com/HUSSEIN-SEFRANI/w/main/win.ps1'

function Start-WinPanel {

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName Microsoft.VisualBasic
[System.Windows.Forms.Application]::EnableVisualStyles()
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# برامج Ninite (أسماء ninite.com مفصولة بـ -)
$NiniteApps = '7zip-sumatrapdf-vlc'

function Set-Reg($Path, $Name, $Value, $Type = 'DWord') {
    if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
}
$Adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$Srch = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search'

# ---------------- الأقسام والألوان ----------------
$Sections = [ordered]@{
    main  = @{ Name = 'المهام الأساسية — بالترتيب'; Tile = [Drawing.Color]::FromArgb(30, 64, 120);  Accent = [Drawing.Color]::FromArgb(96, 165, 250) }
    look  = @{ Name = 'المظهر والمستكشف';            Tile = [Drawing.Color]::FromArgb(76, 45, 110);  Accent = [Drawing.Color]::FromArgb(192, 132, 252) }
    sys   = @{ Name = 'النظام والخصوصية والأداء';    Tile = [Drawing.Color]::FromArgb(20, 83, 85);   Accent = [Drawing.Color]::FromArgb(45, 212, 191) }
    tools = @{ Name = 'أدوات وصيانة';                Tile = [Drawing.Color]::FromArgb(110, 60, 20);  Accent = [Drawing.Color]::FromArgb(251, 146, 60) }
}

# ---------------- المهام ----------------
# G = القسم ، I = رمز (Segoe MDL2 Assets) ، T = العنوان ، D = الوصف ، S = الكود
$Tasks = @(
    # ===== الأساسية =====
    @{ G = 'main'; I = 0xE7F4; T = '1- أيقونات سطح المكتب'; D = 'الكمبيوتر · الشبكة · لوحة التحكم'
       S = { $icons = '{20D04FE0-3AEA-1069-A2D8-08002B30309D}', '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}', '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}'
             foreach ($k in 'NewStartPanel', 'ClassicStartMenu') {
                 foreach ($i in $icons) { Set-Reg "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\$k" $i 0 } } } },

    @{ G = 'main'; I = 0xE8A9; T = '2- شريط المهام'; D = 'بدون بحث · ابدأ يساراً · كل الرموز'
       S = { Set-Reg $Srch 'SearchboxTaskbarMode' 0
             Set-Reg $Adv 'TaskbarAl' 0
             Set-Reg 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' 'EnableAutoTray' 0
             $n = 'HKCU:\Control Panel\NotifyIconSettings'
             if (Test-Path $n) { Get-ChildItem $n | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name 'IsPromoted' -Value 1 -Type DWord -Force } } } },

    @{ G = 'main'; I = 0xE753; T = '3- حذف OneDrive من الجذور'; D = 'من الشريط الجانبي للمستكشف'
       S = { foreach ($p in 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}',
                            'HKCU:\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}') {
                 Set-Reg $p 'System.IsPinnedToNameSpaceTree' 0 } } },

    @{ G = 'main'; I = 0xE712; T = '4- القائمة اليمنى القديمة'; D = 'النقر بالزر الأيمن (ويندوز 11)'
       S = { New-Item -Path 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' -Value '' -Force | Out-Null } },

    @{ G = 'main'; I = 0xE774; T = '5- منع البحث في الإنترنت'; D = 'من قائمة ابدأ (Bing)'
       S = { Set-Reg 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' 'DisableSearchBoxSuggestions' 1
             Set-Reg $Srch 'BingSearchEnabled' 0
             Set-Reg $Srch 'CortanaConsent' 0 } },

    @{ G = 'main'; I = 0xE896; T = '6- تثبيت البرامج (Ninite)'; D = 'VLC · 7-Zip · SumatraPDF'
       S = { $exe = "$env:TEMP\ninite.exe"
             Invoke-WebRequest "https://ninite.com/$NiniteApps/ninite.exe" -OutFile $exe -UseBasicParsing
             Start-Process $exe } },

    @{ G = 'main'; I = 0xE72C; T = '7- تطبيق التغييرات'; D = 'إعادة تشغيل المستكشف'
       S = { Stop-Process -Name explorer -Force } },

    # ===== المظهر والمستكشف =====
    @{ G = 'look'; I = 0xE8A5; T = 'إظهار امتدادات الملفات'; D = '.pdf  .docx  .exe'
       S = { Set-Reg $Adv 'HideFileExt' 0 } },

    @{ G = 'look'; I = 0xE7B3; T = 'إظهار الملفات المخفية'; D = 'في مستكشف الملفات'
       S = { Set-Reg $Adv 'Hidden' 1 } },

    @{ G = 'look'; I = 0xEC50; T = 'المستكشف يفتح على "هذا الكمبيوتر"'; D = 'بدل "الصفحة الرئيسية"'
       S = { Set-Reg $Adv 'LaunchTo' 1 } },

    @{ G = 'look'; I = 0xE708; T = 'الوضع الداكن'; D = 'للنظام والتطبيقات'
       S = { $p = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
             Set-Reg $p 'AppsUseLightTheme' 0; Set-Reg $p 'SystemUsesLightTheme' 0 } },

    @{ G = 'look'; I = 0xE7C4; T = 'إخفاء زر عرض المهام'; D = 'Task View من الشريط'
       S = { Set-Reg $Adv 'ShowTaskViewButton' 0 } },

    @{ G = 'look'; I = 0xE7C3; T = 'إيقاف الأخبار والأدوات'; D = 'Widgets / الطقس في الشريط'
       S = { Set-Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Dsh' 'AllowNewsAndInterests' 0
             Set-Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' 'EnableFeeds' 0 } },

    @{ G = 'look'; I = 0xE711; T = 'زر "إنهاء المهمة" في الشريط'; D = 'بالزر الأيمن على أي برنامج (ويندوز 11)'
       S = { Set-Reg "$Adv\TaskbarDeveloperSettings" 'TaskbarEndTask' 1 } },

    # ===== النظام والخصوصية =====
    @{ G = 'sys'; I = 0xE946; T = 'إيقاف الإعلانات والاقتراحات'; D = 'وتثبيت التطبيقات تلقائياً'
       S = { $c = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
             foreach ($n in 'SilentInstalledAppsEnabled', 'SystemPaneSuggestionsEnabled', 'SoftLandingEnabled',
                            'SubscribedContent-338388Enabled', 'SubscribedContent-338389Enabled',
                            'SubscribedContent-353694Enabled', 'SubscribedContent-353696Enabled') { Set-Reg $c $n 0 }
             Set-Reg $Adv 'Start_IrisRecommendations' 0 } },

    @{ G = 'sys'; I = 0xE99A; T = 'إيقاف Copilot'; D = 'وإخفاء زره'
       S = { Set-Reg 'HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot' 'TurnOffWindowsCopilot' 1
             Set-Reg $Adv 'ShowCopilotButton' 0 } },

    @{ G = 'sys'; I = 0xE72E; T = 'تقليل جمع البيانات'; D = 'Telemetry'
       S = { Set-Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' 'AllowTelemetry' 0 } },

    @{ G = 'sys'; I = 0xE945; T = 'طاقة عالية الأداء'; D = 'High Performance'
       S = { powercfg -setactive SCHEME_MIN; if ($LASTEXITCODE) { throw 'خطة الطاقة غير متوفرة' } } },

    @{ G = 'sys'; I = 0xE7E8; T = 'إيقاف الإسبات'; D = 'يوفّر مساحة ويُلغي البدء السريع'
       S = { powercfg /hibernate off } },

    @{ G = 'sys'; I = 0xE8AF; T = 'تفعيل سطح المكتب البعيد'; D = 'Remote Desktop + الجدار الناري'
       S = { Set-Reg 'HKLM:\System\CurrentControlSet\Control\Terminal Server' 'fDenyTSConnections' 0
             Enable-NetFirewallRule -Group '@FirewallAPI.dll,-28752' } },

    @{ G = 'sys'; I = 0xE81C; T = 'إنشاء نقطة استعادة'; D = 'نسخة احتياطية للنظام'
       S = { Enable-ComputerRestore -Drive "$env:SystemDrive\"
             Set-Reg 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' 'SystemRestorePointCreationFrequency' 0
             Checkpoint-Computer -Description 'بعد تنصيب ويندوز' -RestorePointType MODIFY_SETTINGS } },

    # ===== أدوات =====
    @{ G = 'tools'; I = 0xE8AC; T = 'تغيير اسم الجهاز'; D = 'يُطبَّق بعد إعادة التشغيل'
       S = { $n = [Microsoft.VisualBasic.Interaction]::InputBox('اكتب الاسم الجديد للجهاز:', 'تغيير اسم الجهاز', $env:COMPUTERNAME)
             if (-not $n -or $n -eq $env:COMPUTERNAME) { throw 'لم يتغيّر الاسم' }
             Rename-Computer -NewName $n -Force } },

    @{ G = 'tools'; I = 0xE823; T = 'ضبط الساعة'; D = 'مزامنة الوقت مع الإنترنت'
       S = { Set-Service w32time -StartupType Automatic; Start-Service w32time
             w32tm /resync /force | Out-Null } },

    @{ G = 'tools'; I = 0xE74D; T = 'حذف الملفات المؤقتة'; D = 'Temp للمستخدم والنظام'
       S = { Remove-Item "$env:TEMP\*", "$env:windir\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue } },

    @{ G = 'tools'; I = 0xE898; T = 'تحديث كل البرامج'; D = 'winget upgrade --all'
       S = { Start-Process powershell -ArgumentList '-NoExit', '-Command', 'winget upgrade --all --accept-source-agreements --accept-package-agreements' } },

    @{ G = 'tools'; I = 0xE895; T = 'تحديثات ويندوز'; D = 'فتح Windows Update والبحث'
       S = { Start-Process 'ms-settings:windowsupdate'; Start-Process UsoClient -ArgumentList 'StartInteractiveScan' -WindowStyle Hidden } },

    @{ G = 'tools'; I = 0xE7F8; T = 'إدارة الأجهزة'; D = 'للتأكد من التعريفات'
       S = { Start-Process devmgmt.msc } }
)

# ---------------- الألوان العامة ----------------
$cBg    = [Drawing.Color]::FromArgb(15, 23, 42)
$cHead  = [Drawing.Color]::FromArgb(30, 41, 59)
$cRun   = [Drawing.Color]::FromArgb(161, 98, 7)
$cOk    = [Drawing.Color]::FromArgb(21, 128, 61)
$cErr   = [Drawing.Color]::FromArgb(185, 28, 28)
$cText  = [Drawing.Color]::White
$cSub   = [Drawing.Color]::FromArgb(203, 213, 225)
$fIcon  = New-Object Drawing.Font('Segoe MDL2 Assets', 20)
$fTitle = New-Object Drawing.Font('Segoe UI', 10.5, [Drawing.FontStyle]::Bold)
$fDesc  = New-Object Drawing.Font('Segoe UI', 8.5)

# ---------------- النافذة ----------------
$form = New-Object Windows.Forms.Form
$form.Text = 'لوحة إعدادات ويندوز — H.sefrani'
$form.ClientSize = New-Object Drawing.Size(965, 760)
$form.StartPosition = 'CenterScreen'
$form.BackColor = $cBg
$form.Font = New-Object Drawing.Font('Segoe UI', 10)
$form.RightToLeft = 'Yes'
$form.RightToLeftLayout = $true
$form.MaximizeBox = $false
$form.FormBorderStyle = 'FixedSingle'
$form.TopMost = $true

# --- الرأس ---
$head = New-Object Windows.Forms.Panel
$head.Dock = 'Top'; $head.Height = 74; $head.BackColor = $cHead
$head.Padding = New-Object Windows.Forms.Padding(20, 6, 22, 4)
$hTitle = New-Object Windows.Forms.Label
$hTitle.Text = 'لوحة إعدادات ويندوز'
$hTitle.Font = New-Object Drawing.Font('Segoe UI', 17, [Drawing.FontStyle]::Bold)
$hTitle.ForeColor = $cText; $hTitle.Dock = 'Top'; $hTitle.Height = 38; $hTitle.TextAlign = 'MiddleLeft'
$os = Get-CimInstance Win32_OperatingSystem
$hSub = New-Object Windows.Forms.Label
$hSub.Text = "$($os.Caption)  ·  Build $($os.BuildNumber)  ·  الجهاز: $env:COMPUTERNAME"
$hSub.ForeColor = $cSub; $hSub.Dock = 'Top'; $hSub.Height = 24; $hSub.TextAlign = 'MiddleLeft'
$hSign = New-Object Windows.Forms.Label
$hSign.Text = 'H.sefrani'
$hSign.Font = New-Object Drawing.Font('Segoe UI', 15, [Drawing.FontStyle]::Bold -bor [Drawing.FontStyle]::Italic)
$hSign.ForeColor = [Drawing.Color]::FromArgb(96, 165, 250)
$hSign.AutoSize = $true; $hSign.RightToLeft = 'No'
$hSign.Location = New-Object Drawing.Point(24, 22)
$head.Controls.Add($hSign)
$head.Controls.Add($hSub)
$head.Controls.Add($hTitle)

# --- السجل ---
$log = New-Object Windows.Forms.TextBox
$log.Multiline = $true; $log.ReadOnly = $true; $log.ScrollBars = 'Vertical'
$log.Dock = 'Bottom'; $log.Height = 95; $log.BorderStyle = 'None'
$log.BackColor = [Drawing.Color]::FromArgb(2, 6, 23); $log.ForeColor = $cSub
$log.Font = New-Object Drawing.Font('Consolas', 9)
function Write-Log($msg) { $log.AppendText("[$(Get-Date -Format HH:mm:ss)] $msg`r`n") }

# --- الشريط السفلي ---
$bar = New-Object Windows.Forms.Panel
$bar.Dock = 'Bottom'; $bar.Height = 56; $bar.BackColor = $cHead
$progress = New-Object Windows.Forms.ProgressBar
$progress.Size = New-Object Drawing.Size(330, 14); $progress.Location = New-Object Drawing.Point(18, 21)
$progress.Style = 'Continuous'
$bar.Controls.Add($progress)

# --- منطقة المربعات ---
$panel = New-Object Windows.Forms.FlowLayoutPanel
$panel.Dock = 'Fill'; $panel.AutoScroll = $true
$panel.Padding = New-Object Windows.Forms.Padding(14, 6, 14, 10)

$tiles = @()

function Set-TileState($tile, $state) {
    $info = $tile.Tag
    $info.State = $state
    switch ($state) {
        'run' { $tile.BackColor = $cRun; $info.Mark.Text = '…' }
        'ok'  { $tile.BackColor = $cOk;  $info.Mark.Text = '✔' }
        'err' { $tile.BackColor = $cErr; $info.Mark.Text = '✖' }
    }
    $tile.Refresh()
}

function Invoke-Tile($tile) {
    $task = $tile.Tag.Task
    Set-TileState $tile 'run'
    try {
        & $task.S
        Set-TileState $tile 'ok'
        Write-Log "✔ تم: $($task.T)"
    } catch {
        Set-TileState $tile 'err'
        Write-Log "✖ فشل: $($task.T) — $($_.Exception.Message)"
    }
    [Windows.Forms.Application]::DoEvents()
}

function Get-Tile($ctl) {
    while ($ctl -and -not (($ctl.Tag -is [hashtable]) -and $ctl.Tag.Task)) { $ctl = $ctl.Parent }
    $ctl
}

$onClick = { Invoke-Tile (Get-Tile $this) }
$onEnter = { $t = Get-Tile $this; if ($t.Tag.State -eq 'idle') { $t.BackColor = $t.Tag.Hover } }
$onLeave = {
    $t = Get-Tile $this
    if ($t.Tag.State -eq 'idle' -and -not $t.ClientRectangle.Contains($t.PointToClient([Windows.Forms.Cursor]::Position))) { $t.BackColor = $t.Tag.Base }
}

function Add-Header($sec) {
    if ($panel.Controls.Count) { $panel.SetFlowBreak($panel.Controls[$panel.Controls.Count - 1], $true) }
    $h = New-Object Windows.Forms.Label
    $h.Text = "▍ $($sec.Name)"
    $h.AutoSize = $false; $h.Size = New-Object Drawing.Size(910, 34)
    $h.TextAlign = 'BottomLeft'
    $h.ForeColor = $sec.Accent
    $h.Font = New-Object Drawing.Font('Segoe UI', 12, [Drawing.FontStyle]::Bold)
    $h.Margin = New-Object Windows.Forms.Padding(6, 12, 6, 4)
    $panel.Controls.Add($h)
    $panel.SetFlowBreak($h, $true)
}

function New-Tile($task, $sec) {
    $tile = New-Object Windows.Forms.Panel
    $tile.Size = New-Object Drawing.Size(212, 108)
    $tile.Margin = New-Object Windows.Forms.Padding(5)
    $tile.Padding = New-Object Windows.Forms.Padding(10, 8, 10, 6)
    $tile.BackColor = $sec.Tile
    $tile.Cursor = 'Hand'

    $desc = New-Object Windows.Forms.Label
    $desc.Text = $task.D; $desc.Dock = 'Fill'; $desc.Font = $fDesc; $desc.ForeColor = $cSub
    $desc.BackColor = 'Transparent'

    $title = New-Object Windows.Forms.Label
    $title.Text = $task.T; $title.Dock = 'Top'; $title.Height = 26; $title.Font = $fTitle; $title.ForeColor = $cText
    $title.BackColor = 'Transparent'; $title.AutoEllipsis = $true

    $top = New-Object Windows.Forms.Panel
    $top.Dock = 'Top'; $top.Height = 34; $top.BackColor = 'Transparent'

    $icon = New-Object Windows.Forms.Label
    $icon.Text = [string][char]$task.I; $icon.Font = $fIcon; $icon.ForeColor = $sec.Accent
    $icon.Dock = 'Right'; $icon.Width = 40; $icon.TextAlign = 'MiddleLeft'; $icon.BackColor = 'Transparent'

    $mark = New-Object Windows.Forms.Label
    $mark.Text = ''; $mark.Font = New-Object Drawing.Font('Segoe UI', 14, [Drawing.FontStyle]::Bold)
    $mark.ForeColor = $cText; $mark.Dock = 'Left'; $mark.Width = 30; $mark.TextAlign = 'MiddleRight'; $mark.BackColor = 'Transparent'

    $top.Controls.AddRange(@($icon, $mark))
    # ترتيب الإضافة مهم للـ Dock: الوصف أولاً ثم العنوان ثم الجزء العلوي
    $tile.Controls.Add($desc)
    $tile.Controls.Add($title)
    $tile.Controls.Add($top)

    $hover = [Drawing.Color]::FromArgb([Math]::Min(255, $sec.Tile.R + 25), [Math]::Min(255, $sec.Tile.G + 25), [Math]::Min(255, $sec.Tile.B + 25))
    $tile.Tag = @{ Task = $task; Base = $sec.Tile; Hover = $hover; State = 'idle'; Mark = $mark }
    foreach ($c in @($tile, $desc, $title, $top, $icon, $mark)) {
        $c.Add_Click($onClick); $c.Add_MouseEnter($onEnter); $c.Add_MouseLeave($onLeave)
    }
    $tile
}

foreach ($key in $Sections.Keys) {
    $sec = $Sections[$key]
    Add-Header $sec
    foreach ($t in ($Tasks | Where-Object { $_.G -eq $key })) {
        $tile = New-Tile $t $sec
        $panel.Controls.Add($tile)
        $tiles += $tile
    }
}

function New-BarButton($text, $x, $w, $color, $action) {
    $bb = New-Object Windows.Forms.Button
    $bb.Text = $text; $bb.Size = New-Object Drawing.Size($w, 38); $bb.Location = New-Object Drawing.Point($x, 9)
    $bb.FlatStyle = 'Flat'; $bb.FlatAppearance.BorderSize = 0
    $bb.BackColor = $color; $bb.ForeColor = $cText
    $bb.Font = New-Object Drawing.Font('Segoe UI', 10, [Drawing.FontStyle]::Bold)
    $bb.Cursor = 'Hand'
    $bb.Add_Click($action)
    $bar.Controls.Add($bb)
}

New-BarButton '▶  تطبيق الأساسية (1 → 7)' 721 230 ([Drawing.Color]::FromArgb(37, 99, 235)) {
    $main = @($tiles | Where-Object { $_.Tag.Task.G -eq 'main' })
    $progress.Maximum = $main.Count; $progress.Value = 0
    foreach ($x in $main) {
        if ($x.Tag.State -ne 'ok') { Invoke-Tile $x }
        $progress.Value++
    }
    Write-Log 'انتهت المهام الأساسية.'
}
New-BarButton '⟳  إعادة تشغيل الكمبيوتر' 511 200 ([Drawing.Color]::FromArgb(71, 85, 105)) {
    if ([Windows.Forms.MessageBox]::Show('إعادة تشغيل الكمبيوتر الآن؟', 'تأكيد', 'YesNo', 'Question') -eq 'Yes') { Restart-Computer -Force }
}

$form.Controls.Add($panel)
$form.Controls.Add($bar)
$form.Controls.Add($log)
$form.Controls.Add($head)
$form.Add_Shown({ $form.TopMost = $false; $form.Activate() })
Write-Log 'جاهز. اضغط على أي مربع، أو "تطبيق الأساسية".'
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
