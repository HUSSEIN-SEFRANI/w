# ============================================================
#  لوحة إعدادات ما بعد تنصيب ويندوز  —  v3  —  H.sefrani
#  التشغيل:  irm is.gd/Sefrani | iex
#  ملاحظة: مع RightToLeft = Yes يعكس ويندوز محاذاة النص، لذا Left تعني يمين الشاشة.
# ============================================================

$SelfUrl = 'https://raw.githubusercontent.com/HUSSEIN-SEFRANI/w/main/win.ps1'

function Start-WinPanel {

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName Microsoft.VisualBasic
[System.Windows.Forms.Application]::EnableVisualStyles()
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# برامج Ninite للمهمة الأساسية رقم 6
$NiniteApps = '7zip-sumatrapdf-vlc'

# قائمة البرامج القابلة للاختيار (winget)
$AppCatalog = [ordered]@{
    'Google Chrome'        = 'Google.Chrome'
    'Mozilla Firefox'      = 'Mozilla.Firefox'
    'Brave'                = 'Brave.Brave'
    'VLC'                  = 'VideoLAN.VLC'
    'K-Lite Codec Pack'    = 'CodecGuide.K-LiteCodecPack.Standard'
    '7-Zip'                = '7zip.7zip'
    'WinRAR'               = 'RARLab.WinRAR'
    'SumatraPDF'           = 'SumatraPDF.SumatraPDF'
    'Adobe Acrobat Reader' = 'Adobe.Acrobat.Reader.64-bit'
    'Notepad++'            = 'Notepad++.Notepad++'
    'LibreOffice'          = 'TheDocumentFoundation.LibreOffice'
    'AnyDesk'              = 'AnyDesk.AnyDesk'
    'TeamViewer'           = 'TeamViewer.TeamViewer'
    'Zoom'                 = 'Zoom.Zoom'
    'Telegram'             = 'Telegram.TelegramDesktop'
    'WhatsApp'             = 'msstore:9NKSQGP7F2NH'
    'Discord'              = 'Discord.Discord'
    'Spotify'              = 'Spotify.Spotify'
    'Steam'                = 'Valve.Steam'
    'VS Code'              = 'Microsoft.VisualStudioCode'
    'Python 3.12'          = 'Python.Python.3.12'
    'Paint.NET'            = 'dotPDN.PaintDotNet'
    'ShareX'               = 'ShareX.ShareX'
    'Everything'           = 'voidtools.Everything'
    'PowerToys'            = 'Microsoft.PowerToys'
    'CPU-Z'                = 'CPUID.CPU-Z'
    'CrystalDiskInfo'      = 'CrystalDewWorld.CrystalDiskInfo'
}

function Set-Reg($Path, $Name, $Value, $Type = 'DWord') {
    if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
}
function Clear-Path($pattern) {
    Get-ChildItem -Path $pattern -Force -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}
function Ask($prompt, $title, $default = '') {
    [Microsoft.VisualBasic.Interaction]::InputBox($prompt, $title, $default)
}
$Adv  = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$Srch = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search'

# ---------------- الأقسام ----------------
$Sections = [ordered]@{
    main  = @{ Name = 'المهام الأساسية — بالترتيب'; Tile = [Drawing.Color]::FromArgb(30, 64, 120);  Accent = [Drawing.Color]::FromArgb(96, 165, 250) }
    apps  = @{ Name = 'تنزيل البرامج';               Tile = [Drawing.Color]::FromArgb(22, 90, 60);   Accent = [Drawing.Color]::FromArgb(74, 222, 128) }
    clean = @{ Name = 'التنظيف والكاش';              Tile = [Drawing.Color]::FromArgb(120, 40, 60);  Accent = [Drawing.Color]::FromArgb(251, 113, 133) }
    look  = @{ Name = 'المظهر والمستكشف';            Tile = [Drawing.Color]::FromArgb(76, 45, 110);  Accent = [Drawing.Color]::FromArgb(192, 132, 252) }
    sys   = @{ Name = 'النظام والخصوصية والأداء';    Tile = [Drawing.Color]::FromArgb(20, 83, 85);   Accent = [Drawing.Color]::FromArgb(45, 212, 191) }
    lic   = @{ Name = 'التفعيل ونسخة ويندوز';        Tile = [Drawing.Color]::FromArgb(100, 80, 15);  Accent = [Drawing.Color]::FromArgb(250, 204, 21) }
    tools = @{ Name = 'أدوات';                       Tile = [Drawing.Color]::FromArgb(110, 60, 20);  Accent = [Drawing.Color]::FromArgb(251, 146, 60) }
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

    # ===== تنزيل البرامج =====
    @{ G = 'apps'; I = 0xE71D; T = 'اختيار برامج للتنزيل'; D = 'قائمة بمربعات اختيار (winget)'
       S = { Show-AppPicker } },

    @{ G = 'apps'; I = 0xE898; T = 'تحديث كل البرامج'; D = 'winget upgrade --all'
       S = { Start-Process powershell -ArgumentList '-NoExit', '-Command', 'winget upgrade --all --accept-source-agreements --accept-package-agreements' } },

    @{ G = 'apps'; I = 0xE719; T = 'متجر مايكروسوفت'; D = 'تحديث تطبيقات المتجر'
       S = { Start-Process 'ms-windows-store://downloadsandupdates' } },

    # ===== التنظيف =====
    @{ G = 'clean'; I = 0xE74D; T = 'الملفات المؤقتة'; D = 'Temp + Prefetch'
       S = { Clear-Path "$env:TEMP\*"; Clear-Path "$env:windir\Temp\*"; Clear-Path "$env:windir\Prefetch\*" } },

    @{ G = 'clean'; I = 0xE895; T = 'كاش التحديثات'; D = 'ملفات Windows Update المنزّلة'
       S = { Stop-Service wuauserv, bits -Force -ErrorAction SilentlyContinue
             Clear-Path "$env:windir\SoftwareDistribution\Download\*"
             Clear-Path "$env:ProgramData\Microsoft\Windows\DeliveryOptimization\Cache\*"
             Start-Service wuauserv, bits -ErrorAction SilentlyContinue } },

    @{ G = 'clean'; I = 0xE774; T = 'كاش المتصفحات'; D = 'Chrome · Edge · Firefox · Brave'
       S = { foreach ($b in 'Google\Chrome', 'Microsoft\Edge', 'BraveSoftware\Brave-Browser') {
                 foreach ($c in 'Cache', 'Code Cache', 'GPUCache') { Clear-Path "$env:LOCALAPPDATA\$b\User Data\*\$c\*" } }
             Clear-Path "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*\cache2\*" } },

    @{ G = 'clean'; I = 0xE91B; T = 'كاش الصور المصغّرة'; D = 'thumbcache + icon cache'
       S = { Clear-Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db"
             Clear-Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache_*.db" } },

    @{ G = 'clean'; I = 0xE74D; T = 'سلة المحذوفات'; D = 'إفراغ السلة نهائياً'
       S = { Clear-RecycleBin -Force -ErrorAction SilentlyContinue } },

    @{ G = 'clean'; I = 0xE968; T = 'كاش الشبكة DNS'; D = 'ipconfig /flushdns'
       S = { Clear-DnsClientCache } },

    @{ G = 'clean'; I = 0xEDA2; T = 'تنظيف القرص (Cleanmgr)'; D = 'كل الخيارات تلقائياً'
       S = { $vc = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches'
             Get-ChildItem $vc | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name 'StateFlags0099' -Value 2 -Type DWord -Force -ErrorAction SilentlyContinue }
             Start-Process cleanmgr -ArgumentList '/sagerun:99' } },

    @{ G = 'clean'; I = 0xE90F; T = 'تنظيف مكونات ويندوز'; D = 'DISM — يأخذ عدة دقائق'
       S = { Start-Process powershell -ArgumentList '-NoExit', '-Command', 'Dism /Online /Cleanup-Image /StartComponentCleanup' } },

    # ===== المظهر والمستكشف =====
    @{ G = 'look'; I = 0xE8C8; T = 'نسخ إلى · نقل إلى'; D = 'في القائمة اليمنى للملفات'
       S = { $h = 'Registry::HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers'
             New-Item -Path "$h\Copy To" -Value '{C2FBB630-2971-11D1-A18C-00C04FD75D13}' -Force | Out-Null
             New-Item -Path "$h\Move To" -Value '{C2FBB631-2971-11D1-A18C-00C04FD75D13}' -Force | Out-Null } },

    @{ G = 'look'; I = 0xE8A5; T = 'إظهار امتدادات الملفات'; D = '.pdf  .docx  .exe'
       S = { Set-Reg $Adv 'HideFileExt' 0 } },

    @{ G = 'look'; I = 0xE7B3; T = 'إظهار الملفات المخفية'; D = 'في مستكشف الملفات'
       S = { Set-Reg $Adv 'Hidden' 1 } },

    @{ G = 'look'; I = 0xEC50; T = 'المستكشف على "هذا الكمبيوتر"'; D = 'بدل "الصفحة الرئيسية"'
       S = { Set-Reg $Adv 'LaunchTo' 1 } },

    @{ G = 'look'; I = 0xE708; T = 'الوضع الداكن'; D = 'للنظام والتطبيقات'
       S = { $p = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
             Set-Reg $p 'AppsUseLightTheme' 0; Set-Reg $p 'SystemUsesLightTheme' 0 } },

    @{ G = 'look'; I = 0xE7C4; T = 'إخفاء زر عرض المهام'; D = 'Task View من الشريط'
       S = { Set-Reg $Adv 'ShowTaskViewButton' 0 } },

    @{ G = 'look'; I = 0xE7C3; T = 'إيقاف الأخبار والأدوات'; D = 'Widgets / الطقس في الشريط'
       S = { Set-Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Dsh' 'AllowNewsAndInterests' 0
             Set-Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' 'EnableFeeds' 0 } },

    @{ G = 'look'; I = 0xE711; T = 'زر "إنهاء المهمة"'; D = 'بالزر الأيمن في الشريط (ويندوز 11)'
       S = { Set-Reg "$Adv\TaskbarDeveloperSettings" 'TaskbarEndTask' 1 } },

    # ===== النظام =====
    @{ G = 'sys'; I = 0xE946; T = 'إيقاف الإعلانات'; D = 'والاقتراحات والتثبيت التلقائي'
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

    @{ G = 'sys'; I = 0xE8AF; T = 'سطح المكتب البعيد'; D = 'Remote Desktop + الجدار الناري'
       S = { Set-Reg 'HKLM:\System\CurrentControlSet\Control\Terminal Server' 'fDenyTSConnections' 0
             Enable-NetFirewallRule -Group '@FirewallAPI.dll,-28752' } },

    @{ G = 'sys'; I = 0xE81C; T = 'نقطة استعادة'; D = 'نسخة احتياطية للنظام'
       S = { Enable-ComputerRestore -Drive "$env:SystemDrive\"
             Set-Reg 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' 'SystemRestorePointCreationFrequency' 0
             Checkpoint-Computer -Description 'بعد تنصيب ويندوز' -RestorePointType MODIFY_SETTINGS } },

    # ===== التفعيل =====
    @{ G = 'lic'; I = 0xE946; T = 'حالة تفعيل ويندوز'; D = 'عرض النسخة وحالة الترخيص'
       S = { Start-Process wscript -ArgumentList "$env:windir\System32\slmgr.vbs", '/dli'
             Start-Process 'ms-settings:activation' } },

    @{ G = 'lic'; I = 0xE8D7; T = 'تفعيل ويندوز بمفتاح'; D = 'أدخل مفتاحك الأصلي'
       S = { $k = Ask 'أدخل مفتاح ويندوز (25 حرفاً):' 'تفعيل ويندوز'
             if (-not $k) { throw 'لم يُدخل مفتاح' }
             cscript //nologo "$env:windir\System32\slmgr.vbs" /ipk $k.Trim() | Out-Null
             $r = cscript //nologo "$env:windir\System32\slmgr.vbs" /ato | Out-String
             Write-Log $r.Trim()
             if ($r -match '0x[0-9A-Fa-f]{8}') { throw 'فشل التفعيل — راجع السجل' } } },

    @{ G = 'lic'; I = 0xE777; T = 'الترقية من Home إلى Pro'; D = 'بمفتاح Pro — يعيد التشغيل'
       S = { $k = Ask "أدخل مفتاح Windows Pro (25 حرفاً).`nسيُعاد تشغيل الجهاز بعد التغيير." 'تغيير نسخة ويندوز'
             if (-not $k) { throw 'لم يُدخل مفتاح' }
             Start-Process "$env:windir\System32\changepk.exe" -ArgumentList "/ProductKey $($k.Trim())" } },

    @{ G = 'lic'; I = 0xE8A5; T = 'تفعيل أوفيس بمفتاح'; D = 'Office 2016 / 2019 / 2021 / 2024'
       S = { $ospp = @("$env:ProgramFiles\Microsoft Office\Office16\OSPP.VBS",
                       "${env:ProgramFiles(x86)}\Microsoft Office\Office16\OSPP.VBS") | Where-Object { Test-Path $_ } | Select-Object -First 1
             $k = Ask 'أدخل مفتاح أوفيس (25 حرفاً):' 'تفعيل أوفيس'
             if (-not $k) { throw 'لم يُدخل مفتاح' }
             if ($ospp) {
                 cscript //nologo $ospp "/inpkey:$($k.Trim())" | Out-Null
                 $r = cscript //nologo $ospp /act | Out-String
                 Write-Log $r.Trim()
                 if ($r -notmatch 'SUCCESSFUL') { throw 'فشل التفعيل — راجع السجل' }
             } else {
                 Set-Clipboard $k.Trim()
                 Start-Process 'https://setup.office.com'
                 Write-Log 'أوفيس من نوع Microsoft 365 / Retail: نسخت المفتاح، الصقه في الصفحة التي فُتحت.'
             } } },

    # ===== أدوات =====
    @{ G = 'tools'; I = 0xE8AC; T = 'تغيير اسم الجهاز'; D = 'يُطبَّق بعد إعادة التشغيل'
       S = { $n = Ask 'اكتب الاسم الجديد للجهاز:' 'تغيير اسم الجهاز' $env:COMPUTERNAME
             if (-not $n -or $n -eq $env:COMPUTERNAME) { throw 'لم يتغيّر الاسم' }
             Rename-Computer -NewName $n -Force } },

    @{ G = 'tools'; I = 0xE823; T = 'ضبط الساعة'; D = 'مزامنة الوقت مع الإنترنت'
       S = { Set-Service w32time -StartupType Automatic; Start-Service w32time
             w32tm /resync /force | Out-Null } },

    @{ G = 'tools'; I = 0xE895; T = 'تحديثات ويندوز'; D = 'فتح Windows Update والبحث'
       S = { Start-Process 'ms-settings:windowsupdate'; Start-Process UsoClient -ArgumentList 'StartInteractiveScan' -WindowStyle Hidden } },

    @{ G = 'tools'; I = 0xE7F8; T = 'إدارة الأجهزة'; D = 'للتأكد من التعريفات'
       S = { Start-Process devmgmt.msc } },

    @{ G = 'tools'; I = 0xE90F; T = 'فحص ملفات النظام'; D = 'SFC + DISM RestoreHealth'
       S = { Start-Process powershell -ArgumentList '-NoExit', '-Command', 'sfc /scannow; Dism /Online /Cleanup-Image /RestoreHealth' } }
)

# ---------------- الألوان والخطوط ----------------
$cBg    = [Drawing.Color]::FromArgb(15, 23, 42)
$cHead  = [Drawing.Color]::FromArgb(30, 41, 59)
$cRun   = [Drawing.Color]::FromArgb(161, 98, 7)
$cOk    = [Drawing.Color]::FromArgb(21, 128, 61)
$cErr   = [Drawing.Color]::FromArgb(185, 28, 28)
$cText  = [Drawing.Color]::White
$cSub   = [Drawing.Color]::FromArgb(203, 213, 225)
$fIcon  = New-Object Drawing.Font('Segoe MDL2 Assets', 15)
$fTitle = New-Object Drawing.Font('Segoe UI', 9.5, [Drawing.FontStyle]::Bold)
$fDesc  = New-Object Drawing.Font('Segoe UI', 8)
$fBtn   = New-Object Drawing.Font('Segoe UI', 9.5, [Drawing.FontStyle]::Bold)

# ---------------- حجم النافذة حسب الشاشة ----------------
$wa = [Windows.Forms.Screen]::PrimaryScreen.WorkingArea
$W  = [Math]::Min(1500, [int]($wa.Width * 0.92))
$H  = [Math]::Min(950,  [int]($wa.Height * 0.92))

$form = New-Object Windows.Forms.Form
$form.Text = 'لوحة إعدادات ويندوز — H.sefrani'
$form.Size = New-Object Drawing.Size($W, $H)
$form.MinimumSize = New-Object Drawing.Size(640, 480)
$form.StartPosition = 'CenterScreen'
$form.BackColor = $cBg
$form.Font = New-Object Drawing.Font('Segoe UI', 9.5)
$form.RightToLeft = 'Yes'
$form.RightToLeftLayout = $true
$form.TopMost = $true

# --- الرأس ---
$head = New-Object Windows.Forms.Panel
$head.Dock = 'Top'; $head.Height = 62; $head.BackColor = $cHead
$head.Padding = New-Object Windows.Forms.Padding(20, 4, 20, 4)
$hTitle = New-Object Windows.Forms.Label
$hTitle.Text = 'لوحة إعدادات ويندوز'
$hTitle.Font = New-Object Drawing.Font('Segoe UI', 15, [Drawing.FontStyle]::Bold)
$hTitle.ForeColor = $cText; $hTitle.Dock = 'Top'; $hTitle.Height = 32; $hTitle.TextAlign = 'MiddleLeft'
$os = Get-CimInstance Win32_OperatingSystem
$hSub = New-Object Windows.Forms.Label
$hSub.Text = "$($os.Caption)  ·  Build $($os.BuildNumber)  ·  الجهاز: $env:COMPUTERNAME"
$hSub.ForeColor = $cSub; $hSub.Dock = 'Top'; $hSub.Height = 20; $hSub.TextAlign = 'MiddleLeft'
$hSign = New-Object Windows.Forms.Label
$hSign.Text = 'H.sefrani'
$hSign.Font = New-Object Drawing.Font('Segoe UI', 14, ([Drawing.FontStyle]::Bold -bor [Drawing.FontStyle]::Italic))
$hSign.ForeColor = [Drawing.Color]::FromArgb(96, 165, 250)
$hSign.AutoSize = $true; $hSign.RightToLeft = 'No'
$hSign.Location = New-Object Drawing.Point(22, 16)
$head.Controls.Add($hSign)
$head.Controls.Add($hSub)
$head.Controls.Add($hTitle)

# --- السجل ---
$log = New-Object Windows.Forms.TextBox
$log.Multiline = $true; $log.ReadOnly = $true; $log.ScrollBars = 'Vertical'
$log.Dock = 'Bottom'; $log.Height = 80; $log.BorderStyle = 'None'
$log.BackColor = [Drawing.Color]::FromArgb(2, 6, 23); $log.ForeColor = $cSub
$log.Font = New-Object Drawing.Font('Consolas', 9)
function Write-Log($msg) { $log.AppendText("[$(Get-Date -Format HH:mm:ss)] $msg`r`n") }

# --- الشريط السفلي (يتكيّف مع العرض) ---
$bar = New-Object Windows.Forms.FlowLayoutPanel
$bar.Dock = 'Bottom'; $bar.Height = 50; $bar.BackColor = $cHead
$bar.Padding = New-Object Windows.Forms.Padding(10, 8, 10, 0)
$bar.WrapContents = $false

# --- منطقة المربعات ---
$panel = New-Object Windows.Forms.FlowLayoutPanel
$panel.Dock = 'Fill'; $panel.AutoScroll = $true
$panel.Padding = New-Object Windows.Forms.Padding(12, 2, 12, 10)

$tiles   = New-Object System.Collections.ArrayList
$headers = New-Object System.Collections.ArrayList
$tip     = New-Object Windows.Forms.ToolTip

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

function Get-FreeMB { [Math]::Round((Get-PSDrive ($env:SystemDrive.TrimEnd(':'))).Free / 1MB) }

function Invoke-Tile($tile) {
    $task = $tile.Tag.Task
    Set-TileState $tile 'run'
    $before = Get-FreeMB
    try {
        & $task.S
        Set-TileState $tile 'ok'
        $msg = "✔ تم: $($task.T)"
        if ($task.G -eq 'clean') { $msg += "  —  تحرّر $([Math]::Max(0, (Get-FreeMB) - $before)) MB" }
        Write-Log $msg
    } catch {
        Set-TileState $tile 'err'
        Write-Log "✖ فشل: $($task.T) — $($_.Exception.Message)"
    }
    [Windows.Forms.Application]::DoEvents()
}

function Invoke-Group($group, $label) {
    $list = @($tiles | Where-Object { $_.Tag.Task.G -eq $group })
    $progress.Maximum = $list.Count; $progress.Value = 0
    $start = Get-FreeMB
    foreach ($x in $list) {
        if ($x.Tag.State -ne 'ok') { Invoke-Tile $x }
        $progress.Value++
    }
    $extra = ''
    if ($group -eq 'clean') { $extra = "  —  المجموع: $([Math]::Max(0, (Get-FreeMB) - $start)) MB" }
    Write-Log "انتهى: $label$extra"
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
    $h.AutoSize = $false; $h.Size = New-Object Drawing.Size(600, 28)
    $h.TextAlign = 'BottomLeft'
    $h.ForeColor = $sec.Accent
    $h.Font = New-Object Drawing.Font('Segoe UI', 11, [Drawing.FontStyle]::Bold)
    $h.Margin = New-Object Windows.Forms.Padding(4, 8, 4, 2)
    $panel.Controls.Add($h)
    $panel.SetFlowBreak($h, $true)
    [void]$headers.Add($h)
}

function New-Tile($task, $sec) {
    $tile = New-Object Windows.Forms.Panel
    $tile.Size = New-Object Drawing.Size(176, 78)
    $tile.Margin = New-Object Windows.Forms.Padding(4)
    $tile.Padding = New-Object Windows.Forms.Padding(8, 5, 8, 4)
    $tile.BackColor = $sec.Tile
    $tile.Cursor = 'Hand'

    $desc = New-Object Windows.Forms.Label
    $desc.Text = $task.D; $desc.Dock = 'Fill'; $desc.Font = $fDesc; $desc.ForeColor = $cSub
    $desc.BackColor = 'Transparent'; $desc.AutoEllipsis = $true

    $title = New-Object Windows.Forms.Label
    $title.Text = $task.T; $title.Dock = 'Top'; $title.Height = 22; $title.Font = $fTitle; $title.ForeColor = $cText
    $title.BackColor = 'Transparent'; $title.AutoEllipsis = $true

    $top = New-Object Windows.Forms.Panel
    $top.Dock = 'Top'; $top.Height = 24; $top.BackColor = 'Transparent'

    $icon = New-Object Windows.Forms.Label
    $icon.Text = [string][char]$task.I; $icon.Font = $fIcon; $icon.ForeColor = $sec.Accent
    $icon.Dock = 'Right'; $icon.Width = 30; $icon.TextAlign = 'MiddleLeft'; $icon.BackColor = 'Transparent'

    $mark = New-Object Windows.Forms.Label
    $mark.Text = ''; $mark.Font = New-Object Drawing.Font('Segoe UI', 12, [Drawing.FontStyle]::Bold)
    $mark.ForeColor = $cText; $mark.Dock = 'Left'; $mark.Width = 26; $mark.TextAlign = 'MiddleRight'; $mark.BackColor = 'Transparent'

    $top.Controls.Add($icon); $top.Controls.Add($mark)
    # ترتيب الإضافة مهم للـ Dock: الوصف ثم العنوان ثم الجزء العلوي
    $tile.Controls.Add($desc)
    $tile.Controls.Add($title)
    $tile.Controls.Add($top)

    $hover = [Drawing.Color]::FromArgb([Math]::Min(255, $sec.Tile.R + 28), [Math]::Min(255, $sec.Tile.G + 28), [Math]::Min(255, $sec.Tile.B + 28))
    $tile.Tag = @{ Task = $task; Base = $sec.Tile; Hover = $hover; State = 'idle'; Mark = $mark }

    foreach ($c in @($tile, $desc, $title, $top, $icon, $mark)) {
        $c.Add_Click($onClick); $c.Add_MouseEnter($onEnter); $c.Add_MouseLeave($onLeave)
        $tip.SetToolTip($c, "$($task.T)`n$($task.D)")
    }
    $tile
}

# ---------------- نافذة اختيار البرامج ----------------
function Show-AppPicker {
    $dlg = New-Object Windows.Forms.Form
    $dlg.Text = 'اختيار برامج للتنزيل'
    $dlg.Size = New-Object Drawing.Size(680, 520)
    $dlg.StartPosition = 'CenterParent'
    $dlg.BackColor = $cBg; $dlg.ForeColor = $cText
    $dlg.RightToLeft = 'Yes'; $dlg.RightToLeftLayout = $true
    $dlg.Font = New-Object Drawing.Font('Segoe UI', 10)

    $list = New-Object Windows.Forms.CheckedListBox
    $list.Dock = 'Fill'; $list.CheckOnClick = $true; $list.MultiColumn = $true; $list.ColumnWidth = 210
    $list.BackColor = $cHead; $list.ForeColor = $cText; $list.BorderStyle = 'None'
    $list.RightToLeft = 'No'
    foreach ($n in $AppCatalog.Keys) { [void]$list.Items.Add($n) }

    $pb = New-Object Windows.Forms.FlowLayoutPanel
    $pb.Dock = 'Bottom'; $pb.Height = 52; $pb.Padding = New-Object Windows.Forms.Padding(8)
    $ok = New-Object Windows.Forms.Button
    $ok.Text = 'تثبيت المحدّد'; $ok.Size = New-Object Drawing.Size(150, 34)
    $ok.FlatStyle = 'Flat'; $ok.BackColor = [Drawing.Color]::FromArgb(22, 163, 74); $ok.ForeColor = $cText
    $ok.DialogResult = 'OK'
    $all = New-Object Windows.Forms.Button
    $all.Text = 'تحديد الكل'; $all.Size = New-Object Drawing.Size(110, 34)
    $all.FlatStyle = 'Flat'; $all.BackColor = [Drawing.Color]::FromArgb(71, 85, 105); $all.ForeColor = $cText
    $all.Add_Click({ for ($i = 0; $i -lt $list.Items.Count; $i++) { $list.SetItemChecked($i, $true) } })
    $pb.Controls.Add($ok); $pb.Controls.Add($all)

    $dlg.Controls.Add($list); $dlg.Controls.Add($pb)
    $dlg.AcceptButton = $ok

    if ($dlg.ShowDialog($form) -ne 'OK' -or $list.CheckedItems.Count -eq 0) { throw 'لم يُختر أي برنامج' }

    $names = @($list.CheckedItems)
    $cmds = foreach ($n in $names) {
        $id = $AppCatalog[$n]
        if ($id -like 'msstore:*') { "winget install --id $($id.Substring(8)) -s msstore --accept-source-agreements --accept-package-agreements" }
        else { "winget install --id $id -e --accept-source-agreements --accept-package-agreements" }
    }
    Start-Process powershell -ArgumentList '-NoExit', '-Command', ($cmds -join '; ')
    Write-Log "بدأ تثبيت: $($names -join '، ')"
}

# ---------------- بناء الواجهة ----------------
foreach ($key in $Sections.Keys) {
    $sec = $Sections[$key]
    Add-Header $sec
    foreach ($t in ($Tasks | Where-Object { $_.G -eq $key })) {
        $tile = New-Tile $t $sec
        $panel.Controls.Add($tile)
        [void]$tiles.Add($tile)
    }
}
$panel.Add_Resize({ foreach ($h in $headers) { $h.Width = [Math]::Max(200, $panel.ClientSize.Width - 40) } })

function New-BarButton($text, $w, $color, $action) {
    $bb = New-Object Windows.Forms.Button
    $bb.Text = $text; $bb.Size = New-Object Drawing.Size($w, 34)
    $bb.Margin = New-Object Windows.Forms.Padding(4, 0, 4, 0)
    $bb.FlatStyle = 'Flat'; $bb.FlatAppearance.BorderSize = 0
    $bb.BackColor = $color; $bb.ForeColor = $cText; $bb.Font = $fBtn
    $bb.Cursor = 'Hand'
    $bb.Add_Click($action)
    $bar.Controls.Add($bb)
}

New-BarButton '▶  تطبيق الأساسية (1 → 7)' 210 ([Drawing.Color]::FromArgb(37, 99, 235)) { Invoke-Group 'main' 'المهام الأساسية' }
New-BarButton 'تنظيف شامل' 140 ([Drawing.Color]::FromArgb(190, 18, 60)) { Invoke-Group 'clean' 'التنظيف' }
New-BarButton 'إعادة تشغيل الكمبيوتر' 170 ([Drawing.Color]::FromArgb(71, 85, 105)) {
    if ([Windows.Forms.MessageBox]::Show('إعادة تشغيل الكمبيوتر الآن؟', 'تأكيد', 'YesNo', 'Question') -eq 'Yes') { Restart-Computer -Force }
}
$progress = New-Object Windows.Forms.ProgressBar
$progress.Size = New-Object Drawing.Size(220, 12); $progress.Margin = New-Object Windows.Forms.Padding(14, 11, 4, 0)
$progress.Style = 'Continuous'
$bar.Controls.Add($progress)

$form.Controls.Add($panel)
$form.Controls.Add($bar)
$form.Controls.Add($log)
$form.Controls.Add($head)
$form.Add_Shown({
    $form.TopMost = $false; $form.Activate()
    foreach ($h in $headers) { $h.Width = [Math]::Max(200, $panel.ClientSize.Width - 40) }
})
Write-Log 'جاهز. اضغط على أي مربع، أو استعمل الأزرار في الأسفل.'
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
