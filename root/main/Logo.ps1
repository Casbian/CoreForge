function Logo(){
   $Width = 282
   $Height = 282
   $Root = New-Object System.Windows.Window
   $Root.WindowStyle = "None"
   $Root.AllowsTransparency = $true
   $Root.Background = "Transparent"
   $Root.ResizeMode = "NoResize"
   $Root.Topmost = $true
   $Root.Width = $Width
   $Root.Height = $Height
   $ScreenParameter = [System.Windows.SystemParameters]
   $Root.Left = ($ScreenParameter::PrimaryScreenWidth - $Width) / 2
   $Root.Top = ($ScreenParameter::PrimaryScreenHeight * 0.45) - ($Height / 2)
   $Logo = New-Object System.Windows.Controls.Image
   $Logo.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\LogoBig.png")))
   $Logo.Width = $Width
   $Logo.Height = $Height
   $Root.Content = $Logo
   $Root.Show()
   Start-Sleep -Seconds 2
   $Root.Close()
}