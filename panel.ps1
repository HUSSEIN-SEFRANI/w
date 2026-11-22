# ============================================================
#  لوحة إعدادات ما بعد تنصيب ويندوز  —  v4  —  H.sefrani
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


# ---------------- نوافذ مساعدة ----------------
function Show-Picker($title, [string[]]$items, $okText = 'تنفيذ', [switch]$Single, [string[]]$checked = @()) {
    if (-not $items -or $items.Count -eq 0) { throw 'لا توجد عناصر لعرضها' }
    $dlg = New-Object Windows.Forms.Form
    $dlg.Text = $title
    $dlg.Size = New-Object Drawing.Size(700, 540)
    $dlg.StartPosition = 'CenterParent'
    $dlg.BackColor = $cBg; $dlg.ForeColor = $cText
    $dlg.RightToLeft = 'Yes'; $dlg.RightToLeftLayout = $true
    $dlg.Font = New-Object Drawing.Font('Segoe UI', 10)
    if ($Single) {
        $list = New-Object Windows.Forms.ListBox
    } else {
        $list = New-Object Windows.Forms.CheckedListBox
        $list.CheckOnClick = $true; $list.MultiColumn = $true; $list.ColumnWidth = 220
    }
    $list.Dock = 'Fill'; $list.BackColor = $cHead; $list.ForeColor = $cText; $list.BorderStyle = 'None'
    $list.RightToLeft = 'No'
    foreach ($n in $items) {
        $i = $list.Items.Add($n)
        if (-not $Single -and $checked -contains $n) { $list.SetItemChecked($i, $true) }
    }
    $pb = New-Object Windows.Forms.FlowLayoutPanel
    $pb.Dock = 'Bottom'; $pb.Height = 52; $pb.Padding = New-Object Windows.Forms.Padding(8)
    $ok = New-Object Windows.Forms.Button
    $ok.Text = $okText; $ok.Size = New-Object Drawing.Size(160, 34)
    $ok.FlatStyle = 'Flat'; $ok.BackColor = [Drawing.Color]::FromArgb(22, 163, 74); $ok.ForeColor = $cText
    $ok.DialogResult = 'OK'
    $pb.Controls.Add($ok)
    if (-not $Single) {
        $all = New-Object Windows.Forms.Button
        $all.Text = 'تحديد الكل'; $all.Size = New-Object Drawing.Size(110, 34)
        $all.FlatStyle = 'Flat'; $all.BackColor = [Drawing.Color]::FromArgb(71, 85, 105); $all.ForeColor = $cText
        $all.Add_Click({ for ($i = 0; $i -lt $list.Items.Count; $i++) { $list.SetItemChecked($i, $true) } })
        $pb.Controls.Add($all)
    }
    $dlg.Controls.Add($list); $dlg.Controls.Add($pb)
    $dlg.AcceptButton = $ok
    if ($dlg.ShowDialog($form) -ne 'OK') { throw 'أُلغي' }
    if ($Single) { $sel = @($list.SelectedItem) | Where-Object { $_ } } else { $sel = @($list.CheckedItems) }
    if (-not $sel -or @($sel).Count -eq 0) { throw 'لم يُختر شيء' }
    [string[]]$sel
}

function Show-Text($title, $text) {
    $dlg = New-Object Windows.Forms.Form
    $dlg.Text = $title
    $dlg.Size = New-Object Drawing.Size(760, 560)
    $dlg.StartPosition = 'CenterParent'
    $dlg.BackColor = $cBg
    $tb = New-Object Windows.Forms.TextBox
    $tb.Multiline = $true; $tb.ReadOnly = $true; $tb.ScrollBars = 'Both'; $tb.WordWrap = $false
    $tb.Dock = 'Fill'; $tb.BorderStyle = 'None'
    $tb.BackColor = $cHead; $tb.ForeColor = $cText
    $tb.Font = New-Object Drawing.Font('Consolas', 10)
    $tb.Text = $text
    $cp = New-Object Windows.Forms.Button
    $cp.Text = 'نسخ الكل'; $cp.Dock = 'Bottom'; $cp.Height = 38
    $cp.FlatStyle = 'Flat'; $cp.BackColor = [Drawing.Color]::FromArgb(37, 99, 235); $cp.ForeColor = $cText
    $cp.Add_Click({ Set-Clipboard $tb.Text; $cp.Text = '✔ تم النسخ' })
    $dlg.Controls.Add($tb); $dlg.Controls.Add($cp)
    [void]$dlg.ShowDialog($form)
}

function Pick-Folder($desc) {
    $fb = New-Object Windows.Forms.FolderBrowserDialog
    $fb.Description = $desc
    if ($fb.ShowDialog($form) -ne 'OK') { throw 'لم يُختر مجلد' }
    $fb.SelectedPath
}

function Get-DeviceReport {
    $cs  = Get-CimInstance Win32_ComputerSystem
    $bio = Get-CimInstance Win32_BIOS
    $bb  = Get-CimInstance Win32_BaseBoard
    $os  = Get-CimInstance Win32_OperatingSystem
    $L = New-Object System.Collections.Generic.List[string]
    $L.Add("== الجهاز ==")
    $L.Add("الشركة/الموديل : $($cs.Manufacturer) $($cs.Model)")
    $L.Add("الرقم التسلسلي : $($bio.SerialNumber)")
    $L.Add("اللوحة الأم    : $($bb.Manufacturer) $($bb.Product)")
    $L.Add("BIOS           : $($bio.SMBIOSBIOSVersion)  ($($bio.ReleaseDate))")
    $L.Add("النظام         : $($os.Caption)  Build $($os.BuildNumber)  ($($os.OSArchitecture))")
    $L.Add("اسم الجهاز     : $env:COMPUTERNAME")
    $L.Add("")
    $L.Add("== المعالج ==")
    Get-CimInstance Win32_Processor | ForEach-Object { $L.Add("$($_.Name.Trim())  —  $($_.NumberOfCores) أنوية / $($_.NumberOfLogicalProcessors) خيوط") }
    $L.Add("")
    $L.Add("== الذاكرة (RAM) ==")
    $L.Add("المجموع: $([Math]::Round($cs.TotalPhysicalMemory / 1GB, 1)) GB")
    Get-CimInstance Win32_PhysicalMemory | ForEach-Object { $L.Add("  $($_.BankLabel) $($_.DeviceLocator): $([Math]::Round($_.Capacity / 1GB)) GB  $($_.Speed) MHz  $($_.Manufacturer) $($_.PartNumber.Trim())") }
    $L.Add("")
    $L.Add("== كرت الشاشة ==")
    Get-CimInstance Win32_VideoController | ForEach-Object { $L.Add("$($_.Name)  —  تعريف $($_.DriverVersion)") }
    $L.Add("")
    $L.Add("== الأقراص ==")
    try {
        Get-PhysicalDisk | ForEach-Object { $L.Add("$($_.FriendlyName)  —  $($_.MediaType)  $([Math]::Round($_.Size / 1GB)) GB  —  الصحة: $($_.HealthStatus)") }
    } catch { Get-CimInstance Win32_DiskDrive | ForEach-Object { $L.Add("$($_.Model)  $([Math]::Round($_.Size / 1GB)) GB  —  $($_.Status)") } }
    Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | ForEach-Object { $L.Add("  $($_.DeviceID)  فارغ $([Math]::Round($_.FreeSpace / 1GB)) من $([Math]::Round($_.Size / 1GB)) GB") }
    $bat = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue
    if ($bat) {
        $L.Add("")
        $L.Add("== البطارية ==")
        $L.Add("الشحن الحالي: $($bat.EstimatedChargeRemaining)%")
        try {
            $design = (Get-CimInstance -Namespace root\wmi -ClassName BatteryStaticData -ErrorAction Stop | Select-Object -First 1).DesignedCapacity
            $full   = (Get-CimInstance -Namespace root\wmi -ClassName BatteryFullChargedCapacity -ErrorAction Stop | Select-Object -First 1).FullChargedCapacity
            if ($design -gt 0) { $L.Add("صحة البطارية: $([Math]::Round($full * 100 / $design))%  ($full من $design mWh)") }
        } catch {}
    }
    $L.Add("")
    $L.Add("== الشبكة ==")
    Get-NetAdapter -Physical -ErrorAction SilentlyContinue | ForEach-Object { $L.Add("$($_.Name): $($_.InterfaceDescription)  —  $($_.Status)  MAC $($_.MacAddress)") }
    $L -join "`r`n"
}

# التطبيقات المثبّتة مسبقاً التي يمكن إزالتها
$BloatCatalog = [ordered]@{
    'الأخبار (Bing News)'       = 'Microsoft.BingNews'
    'الطقس (Bing Weather)'      = 'Microsoft.BingWeather'
    'Get Help'                  = 'Microsoft.GetHelp'
    'Get Started / Tips'        = 'Microsoft.Getstarted'
    'Solitaire'                 = 'Microsoft.MicrosoftSolitaireCollection'
    'Office Hub'                = 'Microsoft.MicrosoftOfficeHub'
    'People'                    = 'Microsoft.People'
    'Feedback Hub'              = 'Microsoft.WindowsFeedbackHub'
    'Groove Music / Media'      = 'Microsoft.ZuneMusic'
    'Movies & TV'               = 'Microsoft.ZuneVideo'
    'Xbox App'                  = 'Microsoft.GamingApp'
    'Xbox Game Bar'             = 'Microsoft.XboxGamingOverlay'
    'Xbox (قديم)'               = 'Microsoft.XboxApp'
    'Xbox TCUI'                 = 'Microsoft.Xbox.TCUI'
    'Phone Link'                = 'Microsoft.YourPhone'
    'Maps'                      = 'Microsoft.WindowsMaps'
    'Mixed Reality Portal'      = 'Microsoft.MixedReality.Portal'
    'Skype'                     = 'Microsoft.SkypeApp'
    'To Do'                     = 'Microsoft.Todos'
    'Clipchamp'                 = 'Clipchamp.Clipchamp'
    'Power Automate'            = 'Microsoft.PowerAutomateDesktop'
    'Teams (شخصي)'              = 'MicrosoftTeams'
    'Teams (جديد)'              = 'MSTeams'
    'Cortana'                   = 'Microsoft.549981C3F5F10'
    'Copilot'                   = 'Microsoft.Copilot'
    'Bing Search'               = 'Microsoft.BingSearch'
    'Candy Crush'               = '*CandyCrush*'
    'TikTok'                    = '*TikTok*'
    'Disney+'                   = '*Disney*'
    'Facebook / Instagram'      = '*Facebook*'
    'LinkedIn'                  = '*LinkedIn*'
}

# خدمات يمكن تعطيلها
$ServiceCatalog = [ordered]@{
    'الفاكس (Fax)'                     = 'Fax'
    'Xbox Auth'                         = 'XblAuthManager'
    'Xbox Game Save'                    = 'XblGameSave'
    'Xbox Networking'                   = 'XboxNetApiSvc'
    'Xbox Accessories'                  = 'XboxGipSvc'
    'الطباعة (إن لم تكن لديك طابعة)'    = 'Spooler'
    'الخرائط المحمّلة'                  = 'MapsBroker'
    'وضع العرض في المتاجر'              = 'RetailDemo'
    'جمع بيانات الاستخدام'              = 'DiagTrack'
    'الوصول البعيد للسجل'               = 'RemoteRegistry'
    'خدمة الهاتف'                       = 'PhoneSvc'
    'بطاقات Smart Card'                 = 'SCardSvr'
    'الموقع الجغرافي'                   = 'lfsvc'
    'فهرسة البحث (يبطئ الأجهزة الضعيفة)' = 'WSearch'
}

# ---------------- المفضلة ----------------
$FavFile = "$env:ProgramData\HSefrani\favorites.txt"
$Favs = New-Object System.Collections.Generic.HashSet[string]
if (Test-Path $FavFile) { Get-Content $FavFile -Encoding UTF8 | Where-Object { $_ } | ForEach-Object { [void]$Favs.Add($_) } }
function Save-Favs { New-Item (Split-Path $FavFile) -ItemType Directory -Force | Out-Null; $Favs | Set-Content $FavFile -Encoding UTF8 }

# ---------------- الأقسام ----------------
$Sections = [ordered]@{
    main  = @{ Name = 'المهام الأساسية — بالترتيب'; Tile = [Drawing.Color]::FromArgb(30, 64, 120);  Accent = [Drawing.Color]::FromArgb(96, 165, 250) }
    apps  = @{ Name = 'تنزيل البرامج';               Tile = [Drawing.Color]::FromArgb(22, 90, 60);   Accent = [Drawing.Color]::FromArgb(74, 222, 128) }
    clean = @{ Name = 'التنظيف والكاش';              Tile = [Drawing.Color]::FromArgb(120, 40, 60);  Accent = [Drawing.Color]::FromArgb(251, 113, 133) }
    look  = @{ Name = 'المظهر والمستكشف';            Tile = [Drawing.Color]::FromArgb(76, 45, 110);  Accent = [Drawing.Color]::FromArgb(192, 132, 252) }
    sys   = @{ Name = 'النظام والخصوصية والأداء';    Tile = [Drawing.Color]::FromArgb(20, 83, 85);   Accent = [Drawing.Color]::FromArgb(45, 212, 191) }
    net   = @{ Name = 'الشبكة والإنترنت';            Tile = [Drawing.Color]::FromArgb(15, 70, 110);  Accent = [Drawing.Color]::FromArgb(56, 189, 248) }
    perf  = @{ Name = 'الأداء وبدء التشغيل والتحديثات'; Tile = [Drawing.Color]::FromArgb(80, 30, 100); Accent = [Drawing.Color]::FromArgb(232, 121, 249) }
    comf  = @{ Name = 'اللغة والوقت والدخول';         Tile = [Drawing.Color]::FromArgb(60, 70, 25);   Accent = [Drawing.Color]::FromArgb(163, 230, 53) }
    lic   = @{ Name = 'التفعيل ونسخة ويندوز';        Tile = [Drawing.Color]::FromArgb(100, 80, 15);  Accent = [Drawing.Color]::FromArgb(250, 204, 21) }
    tools = @{ Name = 'أدوات الجهاز';                       Tile = [Drawing.Color]::FromArgb(110, 60, 20);  Accent = [Drawing.Color]::FromArgb(251, 146, 60) }
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
       S = { Start-Process powershell -ArgumentList '-NoExit', '-Command', 'sfc /scannow; Dism /Online /Cleanup-Image /RestoreHealth' } },
    # ===== أدوات الجهاز (جديد) =====
    @{ G = 'tools'; I = 0xE7F8; T = 'تقرير الجهاز'; D = 'معالج · رام · كرت · أقراص · بطارية'
       S = { Show-Text 'تقرير الجهاز' (Get-DeviceReport) } },

    @{ G = 'tools'; I = 0xE8D7; T = 'مفتاح ويندوز من BIOS'; D = 'المفتاح الأصلي المخزّن في الجهاز'
       S = { $k = (Get-CimInstance SoftwareLicensingService).OA3xOriginalProductKey
             if (-not $k) { throw 'لا يوجد مفتاح مخزّن في BIOS لهذا الجهاز' }
             Set-Clipboard $k
             [void][Windows.Forms.MessageBox]::Show("$k`n`n(تم نسخه)", 'مفتاح ويندوز الأصلي') } },

    @{ G = 'tools'; I = 0xE78C; T = 'نسخ التعريفات احتياطياً'; D = 'قبل الفورمات — إلى فلاشة مثلاً'
       S = { $d = Pick-Folder 'اختر مكان حفظ التعريفات (مثلاً فلاشة):'
             $dest = Join-Path $d "Drivers_$env:COMPUTERNAME"
             New-Item $dest -ItemType Directory -Force | Out-Null
             Start-Process powershell -ArgumentList '-NoExit', '-Command', "dism /online /export-driver /destination:'$dest'; Write-Host ''; Write-Host 'DONE: $dest' -ForegroundColor Green" } },

    @{ G = 'tools'; I = 0xE777; T = 'استرجاع التعريفات'; D = 'من مجلد النسخة الاحتياطية'
       S = { $d = Pick-Folder 'اختر مجلد التعريفات (Drivers_...):'
             Start-Process powershell -ArgumentList '-NoExit', '-Command', "pnputil /add-driver '$d\*.inf' /subdirs /install" } },

    @{ G = 'apps'; I = 0xE74D; T = 'إزالة التطبيقات غير الضرورية'; D = 'Candy Crush · Xbox · TikTok …'
       S = { $installed = Get-AppxPackage -AllUsers -ErrorAction SilentlyContinue
             $avail = @($BloatCatalog.Keys | Where-Object { $p = $BloatCatalog[$_]; $installed | Where-Object { $_.Name -like $p } | Select-Object -First 1 })
             if (-not $avail) { throw 'لا توجد تطبيقات من القائمة مثبّتة' }
             $sel = Show-Picker 'اختر التطبيقات لإزالتها' $avail 'إزالة المحدّد'
             $prov = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
             foreach ($n in $sel) {
                 $p = $BloatCatalog[$n]
                 $installed | Where-Object { $_.Name -like $p } | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }
                 $prov | Where-Object { $_.DisplayName -like $p } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue | Out-Null }
                 Write-Log "  أُزيل: $n"
                 [Windows.Forms.Application]::DoEvents()
             } } },

    # ===== الشبكة =====
    @{ G = 'net'; I = 0xE968; T = 'DNS كلاودفلير'; D = '1.1.1.1 — سريع وخاص'
       S = { Get-NetAdapter | Where-Object Status -eq 'Up' | Set-DnsClientServerAddress -ServerAddresses '1.1.1.1', '1.0.0.1'
             Clear-DnsClientCache } },

    @{ G = 'net'; I = 0xE968; T = 'DNS جوجل'; D = '8.8.8.8'
       S = { Get-NetAdapter | Where-Object Status -eq 'Up' | Set-DnsClientServerAddress -ServerAddresses '8.8.8.8', '8.8.4.4'
             Clear-DnsClientCache } },

    @{ G = 'net'; I = 0xE72C; T = 'DNS تلقائي'; D = 'العودة إلى DNS الراوتر'
       S = { Get-NetAdapter | Where-Object Status -eq 'Up' | Set-DnsClientServerAddress -ResetServerAddresses
             Clear-DnsClientCache } },

    @{ G = 'net'; I = 0xE701; T = 'كلمات سر الواي فاي'; D = 'المحفوظة على هذا الجهاز'
       S = { $tmp = Join-Path $env:TEMP "wifi_$(Get-Random)"
             New-Item $tmp -ItemType Directory -Force | Out-Null
             netsh wlan export profile key=clear folder="$tmp" | Out-Null
             $rows = foreach ($f in Get-ChildItem $tmp -Filter *.xml) {
                 [xml]$x = Get-Content $f.FullName -Encoding UTF8
                 $key = $x.WLANProfile.MSM.security.sharedKey.keyMaterial
                 '{0,-35} {1}' -f $x.WLANProfile.name, $(if ($key) { $key } else { '(بدون كلمة سر)' })
             }
             Remove-Item $tmp -Recurse -Force
             if (-not $rows) { throw 'لا توجد شبكات واي فاي محفوظة' }
             Show-Text 'كلمات سر الواي فاي' ((@('الشبكة                              كلمة السر', ('-' * 60)) + $rows) -join "`r`n") } },

    @{ G = 'net'; I = 0xE90F; T = 'إصلاح الإنترنت'; D = 'Winsock · IP · DNS — ثم أعد التشغيل'
       S = { netsh winsock reset | Out-Null
             netsh int ip reset | Out-Null
             ipconfig /flushdns | Out-Null
             ipconfig /release | Out-Null
             ipconfig /renew | Out-Null
             Write-Log '  أعد تشغيل الكمبيوتر ليكتمل الإصلاح.' } },

    @{ G = 'net'; I = 0xE749; T = 'مشاركة الطابعة والمجلدات'; D = 'في الشبكة المحلية'
       S = { Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
             Enable-NetFirewallRule -Group '@FirewallAPI.dll,-32752'   # اكتشاف الشبكة
             Enable-NetFirewallRule -Group '@FirewallAPI.dll,-28502' } }, # مشاركة الملفات والطابعات

    # ===== الأداء =====
    @{ G = 'perf'; I = 0xE7E8; T = 'برامج بدء التشغيل'; D = 'اختر ما تريد تعطيله'
       S = { $map = [ordered]@{}
             $keys = @{ 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run'
                        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run' = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run'
                        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run' = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32' }
             foreach ($k in $keys.Keys) {
                 if (Test-Path $k) {
                     (Get-Item $k).Property | ForEach-Object { $map["$_"] = @{ Approved = $keys[$k]; Name = $_ } }
                 }
             }
             if ($map.Count -eq 0) { throw 'لا توجد برامج في بدء التشغيل' }
             $sel = Show-Picker 'اختر البرامج لتعطيلها عند بدء التشغيل' ([string[]]$map.Keys) 'تعطيل المحدّد'
             foreach ($n in $sel) {
                 $e = $map[$n]
                 if (-not (Test-Path $e.Approved)) { New-Item $e.Approved -Force | Out-Null }
                 Set-ItemProperty -Path $e.Approved -Name $e.Name -Value ([byte[]](3,0,0,0,0,0,0,0,0,0,0,0)) -Type Binary -Force
                 Write-Log "  عُطّل: $n"
             } } },

    @{ G = 'perf'; I = 0xE713; T = 'تعطيل خدمات غير ضرورية'; D = 'Fax · Xbox · الطباعة …'
       S = { $avail = @($ServiceCatalog.Keys | Where-Object { Get-Service $ServiceCatalog[$_] -ErrorAction SilentlyContinue })
             $sel = Show-Picker 'اختر الخدمات لتعطيلها' $avail 'تعطيل المحدّد'
             foreach ($n in $sel) {
                 $s = $ServiceCatalog[$n]
                 Stop-Service $s -Force -ErrorAction SilentlyContinue
                 Set-Service $s -StartupType Disabled -ErrorAction SilentlyContinue
                 Write-Log "  عُطّلت: $n"
             } } },

    @{ G = 'perf'; I = 0xE769; T = 'إيقاف التحديثات 35 يوماً'; D = 'إيقاف مؤقت لتحديثات ويندوز'
       S = { $u = 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'
             $now = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
             $end = (Get-Date).AddDays(35).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
             Set-Reg $u 'PauseUpdatesStartTime' $now 'String'
             Set-Reg $u 'PauseUpdatesExpiryTime' $end 'String'
             foreach ($t in 'Feature', 'Quality') {
                 Set-Reg $u "Pause$($t)UpdatesStartTime" $now 'String'
                 Set-Reg $u "Pause$($t)UpdatesEndTime" $end 'String'
             }
             Write-Log "  التحديثات متوقفة حتى $((Get-Date).AddDays(35).ToString('yyyy-MM-dd'))" } },

    @{ G = 'perf'; I = 0xE768; T = 'استئناف التحديثات'; D = 'إلغاء الإيقاف المؤقت'
       S = { $u = 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'
             foreach ($n in 'PauseUpdatesStartTime', 'PauseUpdatesExpiryTime', 'PauseFeatureUpdatesStartTime', 'PauseFeatureUpdatesEndTime', 'PauseQualityUpdatesStartTime', 'PauseQualityUpdatesEndTime') {
                 Remove-ItemProperty -Path $u -Name $n -ErrorAction SilentlyContinue } } },

    @{ G = 'perf'; I = 0xE7F8; T = 'منع تحديث التعريفات'; D = 'ويندوز لا يستبدل تعريفاتك'
       S = { Set-Reg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' 'ExcludeWUDriversInQualityUpdate' 1
             Set-Reg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' 'SearchOrderConfig' 0 } },

    # ===== اللغة والوقت والدخول =====
    @{ G = 'comf'; I = 0xE765; T = 'إضافة لوحة المفاتيح العربية'; D = 'Arabic (101)'
       S = { $l = Get-WinUserLanguageList
             if (-not ($l | Where-Object LanguageTag -like 'ar*')) { $l.Add('ar-SA'); Set-WinUserLanguageList $l -Force }
             else { Write-Log '  العربية موجودة مسبقاً' } } },

    @{ G = 'comf'; I = 0xE765; T = 'التبديل بين اللغات'; D = 'Alt + Shift'
       S = { $t = 'HKCU:\Keyboard Layout\Toggle'
             Set-Reg $t 'Language Hotkey' '1' 'String'
             Set-Reg $t 'Hotkey' '1' 'String'
             Set-Reg $t 'Layout Hotkey' '3' 'String' } },

    @{ G = 'comf'; I = 0xE775; T = 'المنطقة الزمنية'; D = 'اختيار من القائمة'
       S = { $zones = [TimeZoneInfo]::GetSystemTimeZones()
             $sel = Show-Picker 'اختر المنطقة الزمنية' ([string[]]($zones | ForEach-Object DisplayName)) 'تطبيق' -Single
             $z = $zones | Where-Object DisplayName -eq $sel[0] | Select-Object -First 1
             Set-TimeZone -Id $z.Id
             Write-Log "  المنطقة: $($z.DisplayName)" } },

    @{ G = 'comf'; I = 0xE787; T = 'تنسيق التاريخ'; D = 'يوم/شهر/سنة · 24 ساعة'
       S = { $i = 'HKCU:\Control Panel\International'
             Set-Reg $i 'sShortDate' 'dd/MM/yyyy' 'String'
             Set-Reg $i 'sShortTime' 'HH:mm' 'String'
             Set-Reg $i 'sTimeFormat' 'HH:mm:ss' 'String'
             Set-Reg $i 'iFirstDayOfWeek' '0' 'String' } },

    @{ G = 'comf'; I = 0xE72E; T = 'الدخول بدون كلمة سر'; D = 'يفتح netplwiz — أزل علامة الاختيار'
       S = { Set-Reg 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device' 'DevicePasswordLessBuildVersion' 0
             Start-Process netplwiz
             Write-Log '  في النافذة: أزل علامة "Users must enter a user name and password" ثم OK وأدخل كلمة السر مرة واحدة.' } }

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

function Update-FavMark($tile) {
    $t = $tile.Tag
    $t.TitleLbl.Text = $(if ($Favs.Contains($t.Task.T)) { "★ $($t.Task.T)" } else { $t.Task.T })
}
$onClick = {
    $tile = Get-Tile $this
    if ($_.Button -eq 'Right') {
        $name = $tile.Tag.Task.T
        if ($Favs.Contains($name)) { [void]$Favs.Remove($name) } else { [void]$Favs.Add($name) }
        Save-Favs
        Update-FavMark $tile
    } elseif ($_.Button -eq 'Left') {
        Invoke-Tile $tile
    }
}
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
    $tile.Tag = @{ Task = $task; Base = $sec.Tile; Hover = $hover; State = 'idle'; Mark = $mark; TitleLbl = $title }
    Update-FavMark $tile

    foreach ($c in @($tile, $desc, $title, $top, $icon, $mark)) {
        $c.Add_MouseUp($onClick); $c.Add_MouseEnter($onEnter); $c.Add_MouseLeave($onLeave)
        $tip.SetToolTip($c, "$($task.T)`n$($task.D)")
    }
    $tile
}

# ---------------- نافذة اختيار البرامج ----------------
function Show-AppPicker {
    $names = Show-Picker 'اختيار برامج للتنزيل' ([string[]]$AppCatalog.Keys) 'تثبيت المحدّد'
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
$favMenu = New-Object Windows.Forms.ContextMenuStrip
$favMenu.RightToLeft = 'Yes'
[void]$favMenu.Items.Add('تنفيذ المفضلة', $null, {
    $list = @($tiles | Where-Object { $Favs.Contains($_.Tag.Task.T) })
    if (-not $list) { Write-Log 'لا توجد مفضلة. اضغط بالزر الأيمن على أي مربع لإضافته.'; return }
    $progress.Maximum = $list.Count; $progress.Value = 0
    foreach ($x in $list) { if ($x.Tag.State -ne 'ok') { Invoke-Tile $x }; $progress.Value++ }
    Write-Log "انتهت المفضلة ($($list.Count))."
})
[void]$favMenu.Items.Add('حفظ المفضلة في ملف (فلاشة)…', $null, {
    $sd = New-Object Windows.Forms.SaveFileDialog
    $sd.Filter = 'ملف المفضلة|*.txt'; $sd.FileName = 'HSefrani-favorites.txt'
    if ($sd.ShowDialog($form) -eq 'OK') { $Favs | Set-Content $sd.FileName -Encoding UTF8; Write-Log "حُفظت المفضلة في $($sd.FileName)" }
})
[void]$favMenu.Items.Add('تحميل المفضلة من ملف…', $null, {
    $od = New-Object Windows.Forms.OpenFileDialog
    $od.Filter = 'ملف المفضلة|*.txt'
    if ($od.ShowDialog($form) -eq 'OK') {
        $Favs.Clear()
        Get-Content $od.FileName -Encoding UTF8 | Where-Object { $_ } | ForEach-Object { [void]$Favs.Add($_) }
        Save-Favs
        foreach ($x in $tiles) { Update-FavMark $x }
        Write-Log "حُمّلت $($Favs.Count) مهمة مفضلة."
    }
})
[void]$favMenu.Items.Add('مسح المفضلة', $null, { $Favs.Clear(); Save-Favs; foreach ($x in $tiles) { Update-FavMark $x }; Write-Log 'مُسحت المفضلة.' })
New-BarButton '★  المفضلة ▾' 130 ([Drawing.Color]::FromArgb(202, 138, 4)) { $favMenu.Show($this, 0, $this.Height) }
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
Write-Log 'جاهز. زر أيسر = تنفيذ المربع · زر أيمن = إضافته إلى المفضلة ★'
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
