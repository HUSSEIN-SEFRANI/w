# ============================================================
#  لوحة إعدادات ما بعد تنصيب ويندوز  —  v8  —  H.sefrani
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
    $ok.FlatStyle = 'Flat'; $ok.BackColor = [Drawing.Color]::FromArgb(0, 38, 12); $ok.ForeColor = $cText
    $ok.DialogResult = 'OK'
    $pb.Controls.Add($ok)
    if (-not $Single) {
        $all = New-Object Windows.Forms.Button
        $all.Text = 'تحديد الكل'; $all.Size = New-Object Drawing.Size(110, 34)
        $all.FlatStyle = 'Flat'; $all.BackColor = [Drawing.Color]::FromArgb(0, 32, 14); $all.ForeColor = $cText
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
    $cp.FlatStyle = 'Flat'; $cp.BackColor = [Drawing.Color]::FromArgb(0, 50, 16); $cp.ForeColor = $cText
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


function Confirm-Action($msg) {
    if ([Windows.Forms.MessageBox]::Show($msg, 'تأكيد', 'YesNo', 'Warning') -ne 'Yes') { throw 'أُلغي' }
}
function Get-UserFolders {
    $dl = (Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -ErrorAction SilentlyContinue).'{374DE290-123F-4565-9164-39C4925E467B}'
    if ($dl) { $dl = [Environment]::ExpandEnvironmentVariables($dl) } else { $dl = Join-Path $env:USERPROFILE 'Downloads' }
    [ordered]@{
        Desktop   = [Environment]::GetFolderPath('Desktop')
        Documents = [Environment]::GetFolderPath('MyDocuments')
        Downloads = $dl
        Pictures  = [Environment]::GetFolderPath('MyPictures')
        Videos    = [Environment]::GetFolderPath('MyVideos')
        Music     = [Environment]::GetFolderPath('MyMusic')
    }
}
function Start-Console($cmd) { Start-Process powershell -ArgumentList '-NoExit', '-Command', $cmd }


# ---------- مساعدات القائمة اليمنى ----------
$HSDir = "$env:ProgramData\HSefrani"
function Write-Helper($name, $body) {
    New-Item $HSDir -ItemType Directory -Force | Out-Null
    $p = Join-Path $HSDir $name
    Set-Content -Path $p -Value $body -Encoding UTF8
    $p
}
function Add-CtxMenu($sub, $text, $cmd, $icon = '', [switch]$Shield) {
    $k = [Microsoft.Win32.Registry]::ClassesRoot.CreateSubKey($sub)
    $k.SetValue('', $text); $k.SetValue('MUIVerb', $text)
    if ($icon)   { $k.SetValue('Icon', $icon) }
    if ($Shield) { $k.SetValue('HasLUAShield', '') }
    $c = $k.CreateSubKey('command'); $c.SetValue('', $cmd); $c.Close(); $k.Close()
}
function Remove-CtxMenu($sub) { try { [Microsoft.Win32.Registry]::ClassesRoot.DeleteSubKeyTree($sub, $false) } catch {} }
$CtxKeys = '*\shell\HS_TakeOwn', 'Directory\shell\HS_TakeOwn', 'Directory\shell\HS_PSAdmin', 'Directory\Background\shell\HS_PSAdmin',
           '*\shell\HS_CopyPath', 'Directory\shell\HS_CopyPath'

# ---------------- المفضلة ----------------
$FavFile = "$env:ProgramData\HSefrani\favorites.txt"
$Favs = New-Object System.Collections.Generic.HashSet[string]
if (Test-Path $FavFile) { Get-Content $FavFile -Encoding UTF8 | Where-Object { $_ } | ForEach-Object { [void]$Favs.Add($_) } }
function Save-Favs { New-Item (Split-Path $FavFile) -ItemType Directory -Force | Out-Null; $Favs | Set-Content $FavFile -Encoding UTF8 }

# ---------------- الأقسام ----------------
$Sections = [ordered]@{
    ext   = @{ Name = 'أدوات خارجية';                 Tile = [Drawing.Color]::FromArgb(0, 52, 18);   Accent = [Drawing.Color]::FromArgb(0, 255, 65) }
    main  = @{ Name = 'المهام الأساسية — بالترتيب'; Tile = [Drawing.Color]::FromArgb(0, 40, 12);  Accent = [Drawing.Color]::FromArgb(0, 255, 65) }
    bak   = @{ Name = 'النسخ الاحتياطي والنقل (قبل وبعد الفورمات)'; Tile = [Drawing.Color]::FromArgb(0, 34, 20); Accent = [Drawing.Color]::FromArgb(57, 255, 20) }
    prod  = @{ Name = 'الإنتاجية واختصار العمل';      Tile = [Drawing.Color]::FromArgb(4, 38, 8);  Accent = [Drawing.Color]::FromArgb(0, 230, 118) }
    apps  = @{ Name = 'تنزيل البرامج';               Tile = [Drawing.Color]::FromArgb(0, 44, 18);   Accent = [Drawing.Color]::FromArgb(124, 252, 0) }
    clean = @{ Name = 'التنظيف والكاش';              Tile = [Drawing.Color]::FromArgb(6, 36, 14);  Accent = [Drawing.Color]::FromArgb(0, 255, 127) }
    look  = @{ Name = 'المظهر والمستكشف';            Tile = [Drawing.Color]::FromArgb(0, 30, 10);  Accent = [Drawing.Color]::FromArgb(50, 205, 50) }
    sys   = @{ Name = 'النظام والخصوصية والأداء';    Tile = [Drawing.Color]::FromArgb(2, 42, 22);   Accent = [Drawing.Color]::FromArgb(0, 250, 154) }
    net   = @{ Name = 'الشبكة والإنترنت';            Tile = [Drawing.Color]::FromArgb(0, 38, 6);  Accent = [Drawing.Color]::FromArgb(173, 255, 47) }
    perf  = @{ Name = 'الأداء وبدء التشغيل والتحديثات'; Tile = [Drawing.Color]::FromArgb(8, 40, 16); Accent = [Drawing.Color]::FromArgb(0, 255, 65) }
    comf  = @{ Name = 'اللغة والوقت والدخول';         Tile = [Drawing.Color]::FromArgb(0, 36, 24);   Accent = [Drawing.Color]::FromArgb(57, 255, 20) }
    fix   = @{ Name = 'الصيانة والإصلاح';            Tile = [Drawing.Color]::FromArgb(4, 32, 12);  Accent = [Drawing.Color]::FromArgb(0, 230, 118) }
    boot  = @{ Name = 'إعادة التشغيل الخاصة';         Tile = [Drawing.Color]::FromArgb(0, 46, 14);   Accent = [Drawing.Color]::FromArgb(124, 252, 0) }
    feat  = @{ Name = 'ميزات ويندوز';                 Tile = [Drawing.Color]::FromArgb(6, 30, 18);  Accent = [Drawing.Color]::FromArgb(0, 255, 127) }
    quick = @{ Name = 'اختصارات سريعة';               Tile = [Drawing.Color]::FromArgb(0, 40, 20);   Accent = [Drawing.Color]::FromArgb(50, 205, 50) }
    kbd   = @{ Name = 'اختصارات وأوامر مفيدة';      Tile = [Drawing.Color]::FromArgb(2, 36, 10);   Accent = [Drawing.Color]::FromArgb(0, 250, 154) }
    lic   = @{ Name = 'التفعيل ونسخة ويندوز';        Tile = [Drawing.Color]::FromArgb(0, 34, 16);  Accent = [Drawing.Color]::FromArgb(173, 255, 47) }
    tools = @{ Name = 'أدوات الجهاز';                       Tile = [Drawing.Color]::FromArgb(4, 44, 10);  Accent = [Drawing.Color]::FromArgb(0, 255, 65) }
}

# ---------------- المهام ----------------
# G = القسم ، I = رمز (Segoe MDL2 Assets) ، T = العنوان ، D = الوصف ، S = الكود
$Tasks = @(
    # ===== أدوات خارجية =====
    @{ G = 'ext'; I = 0xE756; T = 'Chris Titus WinUtil'; D = 'irm christitus.com/win | iex'
       S = { Start-Console 'irm christitus.com/win | iex' } },

    @{ G = 'ext'; I = 0xE896; T = 'تنزيل ويندوز 11 (رسمي)'; D = 'ISO من موقع مايكروسوفت'
       S = { Start-Process 'https://www.microsoft.com/software-download/windows11' } },

    @{ G = 'ext'; I = 0xE896; T = 'تنزيل ويندوز 10 (رسمي)'; D = 'Media Creation Tool من مايكروسوفت'
       S = { Start-Process 'https://www.microsoft.com/software-download/windows10' } },

    @{ G = 'ext'; I = 0xE8A5; T = 'تنزيل وتثبيت أوفيس'; D = 'بدون تسجيل دخول — اختر النسخة واللغة'
       S = { $prod = [ordered]@{
                 'Microsoft 365 (Personal / Family)'  = 'O365HomePremRetail'
                 'Microsoft 365 (Business)'           = 'O365BusinessRetail'
                 'Microsoft 365 Apps (Enterprise)'    = 'O365ProPlusRetail'
                 'Office 2024 Pro Plus'        = 'ProPlus2024Retail'
                 'Office 2024 Home & Business' = 'HomeBusiness2024Retail'
                 'Office 2021 Pro Plus'        = 'ProPlus2021Retail'
                 'Office 2019 Pro Plus'        = 'ProPlus2019Retail'
             }
             $lang = [ordered]@{ 'العربية' = 'ar-sa'; 'Français' = 'fr-fr'; 'English' = 'en-us'; 'Nederlands' = 'nl-nl'; 'Deutsch' = 'de-de' }
             $p = (Show-Picker 'اختر نسخة أوفيس' ([string[]]@($prod.get_Keys())) 'التالي' -Single)[0]
             $l = (Show-Picker 'اختر لغة أوفيس' ([string[]]@($lang.get_Keys())) 'تنزيل وتثبيت' -Single)[0]
             $url = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=$($prod[$p])&platform=x64&language=$($lang[$l])&version=O16GA"
             $exe = Join-Path $env:TEMP 'OfficeSetup.exe'
             Invoke-WebRequest $url -OutFile $exe -UseBasicParsing
             Start-Process $exe
             Write-Log "  يُثبَّت: $p ($l). بعد التثبيت: افتح Word وسجّل الدخول بحساب صاحب الاشتراك." } },

    @{ G = 'ext'; I = 0xE88E; T = 'Rufus'; D = 'صنع فلاشة تنصيب من ملف ISO'
       S = { Start-Console 'winget install --id Rufus.Rufus -e --accept-source-agreements --accept-package-agreements' } },

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
             Write-Log '  في النافذة: أزل علامة "Users must enter a user name and password" ثم OK وأدخل كلمة السر مرة واحدة.' } },
    # ===== النسخ الاحتياطي والنقل =====
    @{ G = 'bak'; I = 0xE8F1; T = 'نسخ ملفاتي احتياطياً'; D = 'سطح المكتب · المستندات · التنزيلات · الصور'
       S = { $d = Pick-Folder 'اختر مكان النسخة الاحتياطية (مثلاً فلاشة أو هارد خارجي):'
             $root = Join-Path $d "Backup_$env:COMPUTERNAME"
             $f = Get-UserFolders
             $cmds = foreach ($k in $f.Keys) { "robocopy '$($f[$k])' '$root\$k' /E /R:1 /W:1 /XJ /MT:16 /NFL /NDL" }
             Start-Console (($cmds -join '; ') + "; Write-Host ''; Write-Host 'DONE: $root' -ForegroundColor Green") } },

    @{ G = 'bak'; I = 0xE777; T = 'إرجاع ملفاتي'; D = 'من مجلد Backup_… إلى أماكنها'
       S = { $src = Pick-Folder 'اختر مجلد النسخة الاحتياطية (Backup_…):'
             $f = Get-UserFolders
             $cmds = foreach ($k in $f.Keys) { if (Test-Path "$src\$k") { "robocopy '$src\$k' '$($f[$k])' /E /R:1 /W:1 /XJ /MT:16 /NFL /NDL" } }
             if (-not $cmds) { throw 'المجلد لا يحتوي على نسخة صالحة' }
             Start-Console (($cmds -join '; ') + "; Write-Host ''; Write-Host 'DONE' -ForegroundColor Green") } },

    @{ G = 'bak'; I = 0xE8F4; T = 'حفظ قائمة برامجي'; D = 'كل البرامج المثبّتة في ملف'
       S = { $sd = New-Object Windows.Forms.SaveFileDialog
             $sd.Filter = 'قائمة البرامج|*.json'; $sd.FileName = "Apps_$env:COMPUTERNAME.json"
             if ($sd.ShowDialog($form) -ne 'OK') { throw 'أُلغي' }
             Start-Console "winget export -o '$($sd.FileName)' --accept-source-agreements; Write-Host 'DONE' -ForegroundColor Green" } },

    @{ G = 'bak'; I = 0xE896; T = 'تثبيت برامجي من القائمة'; D = 'على الجهاز الجديد'
       S = { $od = New-Object Windows.Forms.OpenFileDialog
             $od.Filter = 'قائمة البرامج|*.json'
             if ($od.ShowDialog($form) -ne 'OK') { throw 'أُلغي' }
             Start-Console "winget import -i '$($od.FileName)' --accept-package-agreements --accept-source-agreements --ignore-unavailable" } },

    # ===== مكتبات التشغيل =====
    @{ G = 'apps'; I = 0xE943; T = '.NET Framework 3.5'; D = 'للبرامج والألعاب القديمة'
       S = { Start-Console 'DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart' } },

    @{ G = 'apps'; I = 0xE943; T = 'Visual C++ (كل النسخ)'; D = '2005 → 2015+ · x86 و x64'
       S = { $ids = 'Microsoft.VCRedist.2005.x86', 'Microsoft.VCRedist.2005.x64', 'Microsoft.VCRedist.2008.x86', 'Microsoft.VCRedist.2008.x64',
                    'Microsoft.VCRedist.2010.x86', 'Microsoft.VCRedist.2010.x64', 'Microsoft.VCRedist.2012.x86', 'Microsoft.VCRedist.2012.x64',
                    'Microsoft.VCRedist.2013.x86', 'Microsoft.VCRedist.2013.x64', 'Microsoft.VCRedist.2015+.x86', 'Microsoft.VCRedist.2015+.x64'
             Start-Console (($ids | ForEach-Object { "winget install --id $_ -e --accept-source-agreements --accept-package-agreements" }) -join '; ') } },

    @{ G = 'apps'; I = 0xE7FC; T = 'DirectX'; D = 'مكتبات الألعاب'
       S = { Start-Console 'winget install --id Microsoft.DirectX -e --accept-source-agreements --accept-package-agreements' } },

    # ===== الصيانة والإصلاح =====
    @{ G = 'fix'; I = 0xEBA7; T = 'تقرير البطارية'; D = 'تاريخ الشحن ونسبة التآكل'
       S = { $out = Join-Path ([Environment]::GetFolderPath('Desktop')) 'battery-report.html'
             powercfg /batteryreport /output "$out" | Out-Null
             if ($LASTEXITCODE -or -not (Test-Path $out)) { throw 'لا توجد بطارية في هذا الجهاز' }
             Start-Process $out } },

    @{ G = 'fix'; I = 0xEDA2; T = 'فحص الهارد (CHKDSK)'; D = 'يعمل عند إعادة التشغيل القادمة'
       S = { cmd /c "echo Y| chkdsk $env:SystemDrive /f /r" | Out-Null
             Write-Log '  سيُفحص القرص عند إعادة التشغيل القادمة (قد يستغرق وقتاً طويلاً).' } },

    @{ G = 'fix'; I = 0xE749; T = 'إصلاح الطابعة العالقة'; D = 'مسح أوامر الطباعة المتوقفة'
       S = { Stop-Service Spooler -Force
             Clear-Path "$env:windir\System32\spool\PRINTERS\*"
             Start-Service Spooler } },

    @{ G = 'fix'; I = 0xE719; T = 'إصلاح متجر مايكروسوفت'; D = 'إعادة ضبط الكاش (wsreset)'
       S = { Start-Process wsreset.exe } },

    @{ G = 'fix'; I = 0xE83D; T = 'فحص فيروسات سريع'; D = 'Windows Defender'
       S = { Start-Console 'Update-MpSignature; Start-MpScan -ScanType QuickScan; Get-MpThreatDetection | Format-List' } },

    @{ G = 'fix'; I = 0xE83D; T = 'فحص فيروسات كامل'; D = 'قد يستغرق ساعة أو أكثر'
       S = { Start-Console 'Update-MpSignature; Start-MpScan -ScanType FullScan; Get-MpThreatDetection | Format-List' } },

    # ===== إعادة التشغيل الخاصة =====
    @{ G = 'boot'; I = 0xE7E8; T = 'إعادة التشغيل إلى BIOS'; D = 'UEFI — الآن مباشرة'
       S = { Confirm-Action 'سيُعاد تشغيل الجهاز الآن والدخول إلى BIOS/UEFI. احفظ عملك أولاً. متابعة؟'
             shutdown /r /fw /t 0
             if ($LASTEXITCODE) { throw 'الجهاز لا يدعم الدخول المباشر (ليس UEFI) — استعمل F2 / Del عند التشغيل' } } },

    @{ G = 'boot'; I = 0xE7BA; T = 'الدخول إلى الوضع الآمن'; D = 'Safe Mode — يعيد التشغيل الآن'
       S = { Confirm-Action "سيُعاد تشغيل الجهاز إلى الوضع الآمن.`nللخروج منه شغّل اللوحة من جديد واضغط 'الخروج من الوضع الآمن'. متابعة؟"
             bcdedit /set '{current}' safeboot minimal | Out-Null
             shutdown /r /t 0 } },

    @{ G = 'boot'; I = 0xE72C; T = 'الخروج من الوضع الآمن'; D = 'العودة إلى التشغيل العادي'
       S = { bcdedit /deletevalue '{current}' safeboot | Out-Null
             Confirm-Action 'تم. إعادة التشغيل الآن إلى الوضع العادي؟'
             shutdown /r /t 0 } },

    @{ G = 'boot'; I = 0xE90F; T = 'خيارات الإقلاع المتقدمة'; D = 'استعادة · إصلاح · سطر أوامر'
       S = { Confirm-Action 'سيُعاد تشغيل الجهاز إلى شاشة الخيارات المتقدمة. متابعة؟'
             shutdown /r /o /t 0 } },

    # ===== ميزات ويندوز =====
    @{ G = 'feat'; I = 0xE7EF; T = 'Windows Sandbox'; D = 'ويندوز معزول للتجربة (Pro فقط)'
       S = { Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM' -All -NoRestart | Out-Null
             Write-Log '  أعد التشغيل ثم ابحث عن Windows Sandbox في قائمة ابدأ.' } },

    @{ G = 'feat'; I = 0xE756; T = 'WSL (لينكس)'; D = 'يثبّت Ubuntu'
       S = { Start-Console 'wsl --install' } },

    @{ G = 'feat'; I = 0xE7F4; T = 'Hyper-V'; D = 'الأجهزة الافتراضية (Pro فقط)'
       S = { Enable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V' -All -NoRestart | Out-Null
             Write-Log '  أعد التشغيل لتفعيل Hyper-V.' } },

    @{ G = 'feat'; I = 0xE945; T = 'Ultimate Performance'; D = 'أقوى خطة طاقة'
       S = { $o = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-String
             if ($o -match '([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})') { powercfg -setactive $Matches[1] }
             else { throw 'الخطة غير متوفرة في هذه النسخة' } } },

    # ===== لمسات صغيرة =====
    @{ G = 'look'; I = 0xE823; T = 'الثواني في الساعة'; D = 'في شريط المهام'
       S = { Set-Reg $Adv 'ShowSecondsInSystemClock' 1 } },

    @{ G = 'comf'; I = 0xE765; T = 'إيقاف Sticky Keys'; D = 'رسالة Shift خمس مرات'
       S = { Set-Reg 'HKCU:\Control Panel\Accessibility\StickyKeys' 'Flags' '506' 'String'
             Set-Reg 'HKCU:\Control Panel\Accessibility\ToggleKeys' 'Flags' '58' 'String'
             Set-Reg 'HKCU:\Control Panel\Accessibility\Keyboard Response' 'Flags' '122' 'String' } },

    @{ G = 'comf'; I = 0xE962; T = 'إيقاف تسريع الماوس'; D = 'حركة أدق للرسم والألعاب'
       S = { $m = 'HKCU:\Control Panel\Mouse'
             Set-Reg $m 'MouseSpeed' '0' 'String'; Set-Reg $m 'MouseThreshold1' '0' 'String'; Set-Reg $m 'MouseThreshold2' '0' 'String' } },

    @{ G = 'look'; I = 0xE713; T = 'مجلد God Mode'; D = 'كل الإعدادات على سطح المكتب'
       S = { New-Item -ItemType Directory -Path (Join-Path ([Environment]::GetFolderPath('Desktop')) 'GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}') -Force | Out-Null } },

    # ===== اختصارات سريعة =====
    @{ G = 'quick'; I = 0xE7EF; T = 'محرر السجل'; D = 'regedit'; S = { Start-Process regedit } },
    @{ G = 'quick'; I = 0xE713; T = 'إعدادات الإقلاع'; D = 'msconfig'; S = { Start-Process msconfig } },
    @{ G = 'quick'; I = 0xE912; T = 'الخدمات'; D = 'services.msc'; S = { Start-Process services.msc } },
    @{ G = 'quick'; I = 0xEDA2; T = 'إدارة الأقراص'; D = 'diskmgmt.msc'; S = { Start-Process diskmgmt.msc } },
    @{ G = 'quick'; I = 0xE7F4; T = 'إدارة الكمبيوتر'; D = 'compmgmt.msc'; S = { Start-Process compmgmt.msc } },
    @{ G = 'quick'; I = 0xE9D9; T = 'مدير المهام'; D = 'taskmgr'; S = { Start-Process taskmgr } },
    @{ G = 'quick'; I = 0xE71D; T = 'البرامج المثبّتة'; D = 'appwiz.cpl'; S = { Start-Process appwiz.cpl } },
    @{ G = 'quick'; I = 0xE968; T = 'اتصالات الشبكة'; D = 'ncpa.cpl'; S = { Start-Process ncpa.cpl } },
    @{ G = 'quick'; I = 0xE770; T = 'خصائص النظام'; D = 'sysdm.cpl'; S = { Start-Process sysdm.cpl } },
    @{ G = 'quick'; I = 0xE80F; T = 'لوحة التحكم'; D = 'control'; S = { Start-Process control } },
    @{ G = 'quick'; I = 0xE8F1; T = 'سياسات المجموعة'; D = 'gpedit.msc (Pro)'; S = { Start-Process gpedit.msc } },
    @{ G = 'quick'; I = 0xE81C; T = 'عارض الأحداث'; D = 'eventvwr.msc'; S = { Start-Process eventvwr.msc } },
    @{ G = 'quick'; I = 0xE946; T = 'معلومات النظام'; D = 'msinfo32'; S = { Start-Process msinfo32 } },
    @{ G = 'quick'; I = 0xE9D2; T = 'مراقب الموارد'; D = 'resmon'; S = { Start-Process resmon } },
    @{ G = 'quick'; I = 0xE756; T = 'موجه الأوامر (مسؤول)'; D = 'cmd'; S = { Start-Process cmd -Verb RunAs } },
    # ===== اختصارات وأوامر =====
    @{ G = 'kbd'; I = 0xE765; T = 'ورقة اختصارات الكيبورد'; D = 'Win + X · Win + V · Win + Shift + S …'
       S = { Show-Text 'اختصارات لوحة المفاتيح' (@(
               'Win + X                 قائمة سريعة (مدير الأجهزة، الأقراص، PowerShell كمسؤول)'
               'Win + I                 الإعدادات'
               'Win + E                 مستكشف الملفات'
               'Win + V                 سجل الحافظة'
               'Win + Shift + S         لقطة شاشة لجزء من الشاشة'
               'Win + .                 الإيموجي والرموز'
               'Win + Ctrl + Shift + B  إعادة تشغيل كرت الشاشة عند التجمّد'
               'Ctrl + Shift + Esc      مدير المهام مباشرة'
               'Win + Pause             معلومات الجهاز'
               'Win + L                 قفل الجهاز'
               'Win + D                 إظهار سطح المكتب'
               'Win + Tab               كل النوافذ وأسطح المكتب'
               'Win + Ctrl + D          سطح مكتب افتراضي جديد'
               'Win + ← / →             تقسيم الشاشة بين نافذتين'
               'Win + ↑                 تكبير النافذة'
               'Win + Shift + ← / →     نقل النافذة إلى الشاشة الأخرى'
               'Win + P                 وضع الشاشة الثانية / البروجكتور'
               'Win + K                 الاتصال بشاشة لاسلكية'
               'Win + H                 الكتابة بالصوت'
               'Win + Alt + R           تسجيل فيديو للشاشة (Game Bar)'
               'Ctrl + Shift + T        إعادة فتح آخر تبويب مغلق في المتصفح'
               'Alt + F4                إغلاق النافذة / إيقاف التشغيل من سطح المكتب'
             ) -join "`r`n") } },

    @{ G = 'kbd'; I = 0xE756; T = 'ورقة أوامر Run'; D = 'Win + R ثم اكتب الأمر'
       S = { Show-Text 'أوامر Run  (Win + R)' (@(
               'appwiz.cpl        البرامج المثبّتة'
               'ncpa.cpl          اتصالات الشبكة'
               'sysdm.cpl         خصائص النظام'
               'devmgmt.msc       إدارة الأجهزة والتعريفات'
               'diskmgmt.msc      إدارة الأقراص'
               'services.msc      الخدمات'
               'msconfig          إعدادات الإقلاع'
               'shell:startup     مجلد بدء التشغيل'
               'shell:sendto      قائمة "إرسال إلى"'
               '%temp%            الملفات المؤقتة'
               '%appdata%         بيانات البرامج'
               'winver            نسخة ويندوز'
               'control printers  الطابعات'
               'netplwiz          حسابات المستخدمين'
               'mmsys.cpl         أجهزة الصوت'
               'powercfg.cpl      خيارات الطاقة'
               'firewall.cpl      الجدار الناري'
               'cleanmgr          تنظيف القرص'
               'dxdiag            معلومات DirectX وكرت الشاشة'
               'osk               لوحة المفاتيح على الشاشة'
             ) -join "`r`n") } },

    @{ G = 'kbd'; I = 0xE756; T = 'ورقة أوامر CMD'; D = 'sfc · DISM · winget · ipconfig …'
       S = { Show-Text 'أوامر CMD / PowerShell (كمسؤول)' (@(
               'sfc /scannow                                    فحص ملفات النظام وإصلاحها'
               'DISM /Online /Cleanup-Image /RestoreHealth      إصلاح صورة ويندوز'
               'winget upgrade --all                            تحديث كل البرامج'
               'winget search <اسم>                             البحث عن برنامج'
               'winget install <id>                             تثبيت برنامج'
               'ipconfig /all                                   كل معلومات الشبكة'
               'ipconfig /flushdns                              مسح كاش DNS'
               'ping 8.8.8.8 -t                                 اختبار الاتصال المستمر'
               'netsh wlan show profile name="X" key=clear      كلمة سر شبكة واي فاي'
               'powercfg /batteryreport                         تقرير البطارية'
               'slmgr /xpr                                      حالة تفعيل ويندوز'
               'wmic bios get serialnumber                      الرقم التسلسلي'
               'systeminfo                                      ملخّص النظام وتاريخ التنصيب'
               'chkdsk C: /f /r                                 فحص الهارد'
               'shutdown /r /fw /t 0                            إعادة التشغيل إلى BIOS'
               'shutdown /r /o /t 0                             خيارات الإقلاع المتقدمة'
               'shutdown /s /t 3600                             إيقاف التشغيل بعد ساعة'
               'shutdown /a                                     إلغاء الإيقاف المجدول'
               'tasklist / taskkill /im name.exe /f             عرض وإغلاق البرامج'
               'netstat -ano                                    الاتصالات المفتوحة'
             ) -join "`r`n") } },

    @{ G = 'kbd'; I = 0xE8F4; T = 'تفعيل سجل الحافظة'; D = 'Win + V لكل ما نسخته'
       S = { Set-Reg 'HKCU:\Software\Microsoft\Clipboard' 'EnableClipboardHistory' 1 } },

    @{ G = 'kbd'; I = 0xE7E8; T = 'مجلد بدء التشغيل'; D = 'shell:startup'
       S = { Start-Process explorer 'shell:startup' } },

    @{ G = 'kbd'; I = 0xE74D; T = 'مجلد الملفات المؤقتة'; D = '%temp%'
       S = { Start-Process explorer $env:TEMP } },

    @{ G = 'kbd'; I = 0xE946; T = 'نسخة ويندوز'; D = 'winver'
       S = { Start-Process winver } },

    @{ G = 'kbd'; I = 0xE7F8; T = 'ملخّص النظام'; D = 'systeminfo + تاريخ التنصيب'
       S = { Show-Text 'systeminfo' ((systeminfo | Out-String).Trim()) } },

    @{ G = 'kbd'; I = 0xE749; T = 'الطابعات'; D = 'control printers'
       S = { Start-Process control 'printers' } },

    @{ G = 'kbd'; I = 0xE767; T = 'أجهزة الصوت'; D = 'mmsys.cpl'
       S = { Start-Process mmsys.cpl } },

    @{ G = 'kbd'; I = 0xE7FC; T = 'معلومات كرت الشاشة'; D = 'dxdiag'
       S = { Start-Process dxdiag } },

    @{ G = 'kbd'; I = 0xE823; T = 'إيقاف التشغيل بعد مدة'; D = 'مؤقت بالدقائق'
       S = { $m = Ask 'بعد كم دقيقة يُطفأ الجهاز؟ (0 = إلغاء مؤقت سابق)' 'إيقاف التشغيل المجدول' '60'
             if ($m -eq '') { throw 'أُلغي' }
             if ([int]$m -eq 0) { shutdown /a | Out-Null; Write-Log '  أُلغي الإيقاف المجدول.' }
             else { shutdown /s /t ([int]$m * 60) | Out-Null; Write-Log "  سيُطفأ الجهاز بعد $m دقيقة." } } },
    # ===== الإنتاجية =====
    @{ G = 'prod'; I = 0xE896; T = 'حزمة أدوات الإنتاجية'; D = 'PowerToys · Everything · Ditto · ShareX'
       S = { $ids = 'Microsoft.PowerToys', 'voidtools.Everything', 'Ditto.Ditto', 'ShareX.ShareX'
             Start-Console (($ids | ForEach-Object { "winget install --id $_ -e --accept-source-agreements --accept-package-agreements" }) -join '; ')
             Write-Log '  بعد التثبيت: Alt+Space = بحث PowerToys · Win+Shift+T = نسخ نص من صورة · Win+Ctrl+T = نافذة فوق الكل' } },

    @{ G = 'prod'; I = 0xE765; T = 'اختصارات نصية (AutoHotkey)'; D = ';adr ← عنوانك الكامل …'
       S = { $ahk = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'HSefrani-shortcuts.ahk'
             if (-not (Test-Path $ahk)) {
                 $body = @(
                     '#Requires AutoHotkey v2.0'
                     '; ===== اختصارات نصية: اكتب الاختصار ثم مسافة أو Enter ====='
                     '; غيّر النص بعد :: الثانية كما تريد، ثم احفظ وأعد تشغيل الملف'
                     '::;adr::اكتب عنوانك الكامل هنا'
                     '::;mail::example@mail.com'
                     '::;tel::+32 000 00 00 00'
                     '::;sig::مع التحية،`nالاسم'
                     ''
                     '; ===== اختصارات برامج  (^ = Ctrl  ! = Alt  # = Win  + = Shift) ====='
                     '^!c::Run "calc.exe"'
                     '^!n::Run "notepad.exe"'
                     '^!e::Run "explorer.exe"'
                     '^!t::Run "taskmgr.exe"'
                     ''
                     '; ;now يكتب التاريخ والوقت الحالي'
                     ':*:;now::'
                     '{'
                     '    SendText FormatTime(, "dd/MM/yyyy HH:mm")'
                     '}'
                 ) -join "`r`n"
                 [IO.File]::WriteAllText($ahk, $body, (New-Object Text.UTF8Encoding $true))
             }
             $lnk = Join-Path ([Environment]::GetFolderPath('Startup')) 'HSefrani-shortcuts.lnk'
             $ws = New-Object -ComObject WScript.Shell
             $s = $ws.CreateShortcut($lnk); $s.TargetPath = $ahk; $s.Save()
             Start-Console "winget install --id AutoHotkey.AutoHotkey -e --accept-source-agreements --accept-package-agreements; Start-Process '$ahk'"
             Start-Process notepad $ahk
             Write-Log "  عدّل النصوص في الملف المفتوح ثم احفظ. يعمل تلقائياً مع ويندوز." } },

    @{ G = 'prod'; I = 0xE756; T = 'PowerShell هنا كمسؤول'; D = 'في القائمة اليمنى لأي مجلد'
       S = { $h = Write-Helper 'psadmin.ps1' @'
param($p)
Start-Process powershell -Verb RunAs -ArgumentList '-NoExit', '-Command', ("Set-Location -LiteralPath '" + $p.Replace("'", "''") + "'")
'@
             $cmd = "powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$h`""
             Add-CtxMenu 'Directory\shell\HS_PSAdmin' 'فتح PowerShell هنا كمسؤول' "$cmd `"%1`"" 'powershell.exe' -Shield
             Add-CtxMenu 'Directory\Background\shell\HS_PSAdmin' 'فتح PowerShell هنا كمسؤول' "$cmd `"%V`"" 'powershell.exe' -Shield } },

    @{ G = 'prod'; I = 0xE72E; T = 'امتلاك الملف (Take Ownership)'; D = 'للملفات التي يرفض ويندوز حذفها'
       S = { $h = Write-Helper 'takeown.ps1' @'
param($p)
$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $admin) { Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" `"$p`""; exit }
if (Test-Path -LiteralPath $p -PathType Container) { takeown /f "$p" /r /d y | Out-Null; icacls "$p" /grant '*S-1-5-32-544:F' /t /c /q | Out-Null }
else { takeown /f "$p" | Out-Null; icacls "$p" /grant '*S-1-5-32-544:F' /c /q | Out-Null }
'@
             $cmd = "powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$h`" `"%1`""
             Add-CtxMenu '*\shell\HS_TakeOwn' 'امتلاك الملف' $cmd 'imageres.dll,-78' -Shield
             Add-CtxMenu 'Directory\shell\HS_TakeOwn' 'امتلاك المجلد' $cmd 'imageres.dll,-78' -Shield } },

    @{ G = 'prod'; I = 0xE8C8; T = 'نسخ المسار'; D = 'في القائمة اليمنى لأي ملف أو مجلد'
       S = { $h = Write-Helper 'copypath.ps1' 'param($p) Set-Clipboard -Value $p'
             $cmd = "powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$h`" `"%1`""
             Add-CtxMenu '*\shell\HS_CopyPath' 'نسخ المسار' $cmd 'shell32.dll,-16763'
             Add-CtxMenu 'Directory\shell\HS_CopyPath' 'نسخ المسار' $cmd 'shell32.dll,-16763' } },

    @{ G = 'prod'; I = 0xE724; T = 'تخصيص "إرسال إلى"'; D = 'أضف مجلداتك المفضلة'
       S = { Start-Process explorer 'shell:sendto'
             Write-Log '  ضع في هذا المجلد اختصاراً لأي مجلد تستعمله كثيراً، فيظهر في: زر أيمن ← إرسال إلى.' } },

    @{ G = 'prod'; I = 0xE711; T = 'إزالة إضافات القائمة اليمنى'; D = 'إلغاء ما أضافته اللوحة'
       S = { foreach ($k in $CtxKeys) { Remove-CtxMenu $k } } },

    @{ G = 'prod'; I = 0xE74D; T = 'التنظيف التلقائي (Storage Sense)'; D = 'كل أسبوع: Temp + السلة بعد 30 يوماً'
       S = { $p = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy'
             Set-Reg $p '01' 1; Set-Reg $p '2048' 7; Set-Reg $p '04' 1; Set-Reg $p '08' 1; Set-Reg $p '256' 30 } },

    @{ G = 'prod'; I = 0xE81C; T = 'نسخة احتياطية أسبوعية'; D = 'كل جمعة 20:00 — تلقائياً'
       S = { $d = Pick-Folder 'اختر مكان النسخة الأسبوعية (هارد خارجي أو مجلد شبكة):'
             $root = Join-Path $d "Backup_$env:COMPUTERNAME"
             $f = Get-UserFolders
             $lines = foreach ($k in $f.Keys) { "robocopy '$($f[$k])' '$root\$k' /E /R:1 /W:1 /XJ /MT:16 /NFL /NDL /NP" }
             $h = Write-Helper 'weekly-backup.ps1' ($lines -join "`r`n")
             $act = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$h`""
             $trg = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Friday -At '20:00'
             $set = New-ScheduledTaskSettingsSet -StartWhenAvailable -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries
             Register-ScheduledTask -TaskName 'HSefrani Weekly Backup' -Action $act -Trigger $trg -Settings $set -User $env:USERNAME -Force | Out-Null
             Write-Log "  كل جمعة 20:00 → $root  (إن كان الجهاز مطفأً تُنفَّذ عند التشغيل التالي)" } },

    @{ G = 'prod'; I = 0xE711; T = 'إلغاء النسخة الأسبوعية'; D = 'حذف المهمة المجدولة'
       S = { Unregister-ScheduledTask -TaskName 'HSefrani Weekly Backup' -Confirm:$false } }



)

# ---------------- الألوان والخطوط ----------------
$cBg    = [Drawing.Color]::FromArgb(0, 0, 0)
$cHead  = [Drawing.Color]::FromArgb(0, 18, 6)
$cRun   = [Drawing.Color]::FromArgb(110, 110, 0)
$cOk    = [Drawing.Color]::FromArgb(0, 120, 40)
$cErr   = [Drawing.Color]::FromArgb(130, 0, 0)
$cText  = [Drawing.Color]::FromArgb(0, 255, 65)
$cSub   = [Drawing.Color]::FromArgb(0, 175, 50)
$fIcon  = New-Object Drawing.Font('Segoe MDL2 Assets', 15)
$fTitle = New-Object Drawing.Font('Segoe UI', 9.5, [Drawing.FontStyle]::Bold)
$fDesc  = New-Object Drawing.Font('Segoe UI', 8)
$fBtn   = New-Object Drawing.Font('Segoe UI', 9.5, [Drawing.FontStyle]::Bold)

# ---------------- حجم النافذة حسب الشاشة ----------------
$wa = [Windows.Forms.Screen]::PrimaryScreen.WorkingArea
$W  = [Math]::Min(1800, [int]($wa.Width * 0.95))
$H  = [Math]::Min([int]($wa.Height * 0.88), [int]($W * 0.56))

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
$head.Dock = 'Top'; $head.Height = 80; $head.BackColor = $cHead
$head.Padding = New-Object Windows.Forms.Padding(20, 4, 20, 4)
$hTitle = New-Object Windows.Forms.Label
$hTitle.Text = 'لوحة إعدادات ويندوز'
$hTitle.Font = New-Object Drawing.Font('Segoe UI', 16, [Drawing.FontStyle]::Bold)
$hTitle.ForeColor = $cText; $hTitle.Dock = 'Top'; $hTitle.Height = 40; $hTitle.TextAlign = 'MiddleLeft'
$os = Get-CimInstance Win32_OperatingSystem
$hSub = New-Object Windows.Forms.Label
$hSub.Text = "$($os.Caption)  ·  Build $($os.BuildNumber)  ·  الجهاز: $env:COMPUTERNAME"
$hSub.ForeColor = $cSub; $hSub.Dock = 'Top'; $hSub.Height = 26; $hSub.TextAlign = 'MiddleLeft'
$sig = @(
    @{ T = 'H.sefrani';            F = (New-Object Drawing.Font('Consolas', 15, [Drawing.FontStyle]::Bold)); C = [Drawing.Color]::FromArgb(0, 255, 65); Y = 4 }
    @{ T = 'حسين سفراني · ابو كرمو'; F = (New-Object Drawing.Font('Segoe UI', 10, [Drawing.FontStyle]::Bold));  C = [Drawing.Color]::FromArgb(0, 210, 60); Y = 32 }
    @{ T = 'hosean1989@msn.com';   F = (New-Object Drawing.Font('Consolas', 9.5));                            C = [Drawing.Color]::FromArgb(0, 170, 50); Y = 56 }
)
foreach ($x in $sig) {
    $l = New-Object Windows.Forms.Label
    $l.Text = $x.T; $l.Font = $x.F; $l.ForeColor = $x.C; $l.AutoSize = $true
    $l.RightToLeft = 'No'; $l.Location = New-Object Drawing.Point(22, $x.Y)
    if ($x.T -like '*@*') { $l.Cursor = 'Hand'; $l.Add_Click({ Start-Process 'mailto:hosean1989@msn.com' }) }
    $head.Controls.Add($l)
}
$head.Controls.Add($hSub)
$head.Controls.Add($hTitle)

# --- السجل ---
$log = New-Object Windows.Forms.TextBox
$log.Multiline = $true; $log.ReadOnly = $true; $log.ScrollBars = 'Vertical'
$log.Dock = 'Bottom'; $log.Height = 80; $log.BorderStyle = 'None'
$log.BackColor = [Drawing.Color]::FromArgb(0, 8, 2); $log.ForeColor = $cSub
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
foreach ($key in @($Sections.get_Keys())) {
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
    $bb.FlatStyle = 'Flat'; $bb.FlatAppearance.BorderSize = 1; $bb.FlatAppearance.BorderColor = $cSub
    $bb.BackColor = $color; $bb.ForeColor = $cText; $bb.Font = $fBtn
    $bb.Cursor = 'Hand'
    $bb.Add_Click($action)
    $bar.Controls.Add($bb)
}

New-BarButton '▶  تطبيق الأساسية (1 → 7)' 210 ([Drawing.Color]::FromArgb(0, 38, 12)) { Invoke-Group 'main' 'المهام الأساسية' }
New-BarButton 'تنظيف شامل' 140 ([Drawing.Color]::FromArgb(10, 40, 10)) { Invoke-Group 'clean' 'التنظيف' }
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
New-BarButton '★  المفضلة ▾' 130 ([Drawing.Color]::FromArgb(10, 40, 10)) { $favMenu.Show($this, 0, $this.Height) }
New-BarButton 'إعادة تشغيل الكمبيوتر' 170 ([Drawing.Color]::FromArgb(0, 50, 16)) {
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
