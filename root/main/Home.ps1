function Home(){
   $Root = New-Object System.Windows.Window
   $Root.WindowStyle = "None"
   $Root.AllowsTransparency = $true
   $Root.Background = "Transparent"
   $Root.ResizeMode = "NoResize"
   $Root.Topmost = $false
   $Root.Width = 900
   $Root.Height = 500
   $ScreenParameter = [System.Windows.SystemParameters]
   $Root.Left = ($ScreenParameter::PrimaryScreenWidth - $Width) / 2
   $Root.Top = ($ScreenParameter::PrimaryScreenHeight * 0.45) - ($Height / 2)
   $Root.Icon = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Icon.ico")))


   $Background = New-Object System.Windows.Controls.Image
   $Background.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Background.png")))
   $Background.Width = 900
   $Background.Height = 500
   

   $DragBarImage = New-Object System.Windows.Controls.Image
   $DragBarImage.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\DragBar.png")))
   $DragBarImage.Width = 900
   $DragBarImage.Height = 40
   $DragBarImage.Add_MouseLeftButtonDown({
      [System.Windows.Window]::GetWindow($args[0]).DragMove()
   })


   $Logo = New-Object System.Windows.Controls.Image
   $Logo.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\LogoSmallWhite.png")))
   $Logo.Width = 44
   $Logo.Height = 44
   

   $SystemWindowsControlsRichTextBoxImage0 = New-Object System.Windows.Controls.Image
   $SystemWindowsControlsRichTextBoxImage0.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\ConsoleBox.png")))
   $SystemWindowsControlsRichTextBoxImage0.Width = 760
   $SystemWindowsControlsRichTextBoxImage0.Height = 310
  
   $SystemWindowsControlsRichTextBox0 = New-Object System.Windows.Controls.RichTextBox
   $SystemWindowsControlsRichTextBox0.FontFamily = New-Object System.Windows.Media.FontFamily("Consolas")
   $SystemWindowsControlsRichTextBox0.FontSize = 10
   $SystemWindowsControlsRichTextBox0.Width = 760
   $SystemWindowsControlsRichTextBox0.Height = 310
   $SystemWindowsControlsRichTextBox0.BorderThickness = 0
   $SystemWindowsControlsRichTextBox0.Document.PagePadding = [System.Windows.Thickness]::new(0)
   $SystemWindowsControlsRichTextBox0.Background = [System.Windows.Media.Brushes]::Transparent
   $SystemWindowsControlsRichTextBox0.Foreground = [System.Windows.Media.Brushes]::White
  

   $SystemWindowsControlsRichTextBoxImage1 = New-Object System.Windows.Controls.Image
   $SystemWindowsControlsRichTextBoxImage1.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\WindowsUpdateBox.png")))
   $SystemWindowsControlsRichTextBoxImage1.Width = 410
   $SystemWindowsControlsRichTextBoxImage1.Height = 120
 
   $SystemWindowsControlsRichTextBox1 = New-Object System.Windows.Controls.RichTextBox
   $SystemWindowsControlsRichTextBox1.FontFamily = New-Object System.Windows.Media.FontFamily("Consolas")
   $SystemWindowsControlsRichTextBox1.FontSize = 10
   $SystemWindowsControlsRichTextBox1.Width = 410
   $SystemWindowsControlsRichTextBox1.Height = 120
   $SystemWindowsControlsRichTextBox1.BorderThickness = 0
   $SystemWindowsControlsRichTextBox1.Document.PagePadding = [System.Windows.Thickness]::new(0)
   $SystemWindowsControlsRichTextBox1.Background = [System.Windows.Media.Brushes]::Transparent
   $SystemWindowsControlsRichTextBox1.Foreground = [System.Windows.Media.Brushes]::White


   $SystemWindowsControlsRichTextBoxImage2 = New-Object System.Windows.Controls.Image
   $SystemWindowsControlsRichTextBoxImage2.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\AppUpdateBox.png")))
   $SystemWindowsControlsRichTextBoxImage2.Width = 460
   $SystemWindowsControlsRichTextBoxImage2.Height = 120

   $SystemWindowsControlsRichTextBox2 = New-Object System.Windows.Controls.RichTextBox
   $SystemWindowsControlsRichTextBox2.FontFamily = New-Object System.Windows.Media.FontFamily("Consolas")
   $SystemWindowsControlsRichTextBox2.FontSize = 10
   $SystemWindowsControlsRichTextBox2.Width = 460
   $SystemWindowsControlsRichTextBox2.Height = 120
   $SystemWindowsControlsRichTextBox2.BorderThickness = 0
   $SystemWindowsControlsRichTextBox2.Document.PagePadding = [System.Windows.Thickness]::new(0)
   $SystemWindowsControlsRichTextBox2.Background = [System.Windows.Media.Brushes]::Transparent
   $SystemWindowsControlsRichTextBox2.Foreground = [System.Windows.Media.Brushes]::White


   $HomeButton = @{
      Button = New-Object System.Windows.Controls.Image
      Icon   = New-Object System.Windows.Controls.Image
   }
   $HomeButton.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarActive.png")))
   $HomeButton.Button.Width = 30
   $HomeButton.Button.Height = 30
   $HomeButton.Icon.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeActive.png")))
   $HomeButton.Icon.Width = 14
   $HomeButton.Icon.Height = 14
   $HomeButton.Button.Tag = $HomeButton
   $HomeButton.Icon.Tag   = $HomeButton
   $HomeButton.Button.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarActiveHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeHover.png")))
   })
   $HomeButton.Button.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarActive.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeActive.png")))
   })
   $HomeButton.Icon.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarActiveHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeHover.png")))
   })
   $HomeButton.Icon.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarActive.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeActive.png")))
   })
   $HomeButton.Button.Add_MouseLeftButtonDown({
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomePressed.png")))
      $this.CaptureMouse() | Out-Null
   })
   $HomeButton.Button.Add_MouseLeftButtonUp({
      $this.ReleaseMouseCapture()
      if ($this.IsMouseOver) {
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeActive.png")))
      } else {
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeActive.png")))
    }
   })
   $HomeButton.Icon.Add_MouseLeftButtonDown({
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomePressed.png")))
      $this.CaptureMouse() | Out-Null
   })
   $HomeButton.Icon.Add_MouseLeftButtonUp({
      $this.ReleaseMouseCapture()
      if ($this.IsMouseOver) {
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeActive.png")))
         $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarActive.png")))
      } else {
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\HomeActive.png")))
    }
   })

   
   $UpdateNowButton = @{
      Button = New-Object System.Windows.Controls.Image
      Icon = New-Object System.Windows.Controls.Image
      Text = New-Object System.Windows.Controls.Image
   }
   $UpdateNowButton.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
   $UpdateNowButton.Button.Width = 118
   $UpdateNowButton.Button.Height = 38
   $UpdateNowButton.Icon.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
   $UpdateNowButton.Icon.Width = 18
   $UpdateNowButton.Icon.Height = 18
   $UpdateNowButton.Text.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))
   $UpdateNowButton.Text.Width = 46
   $UpdateNowButton.Text.Height = 19
   $UpdateNowButton.Button.Tag = $UpdateNowButton
   $UpdateNowButton.Icon.Tag   = $UpdateNowButton
   $UpdateNowButton.Text.Tag = $UpdateNowButton
   $UpdateNowButton.Button.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIconHover.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonTextHover.png")))
   })
   $UpdateNowButton.Button.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))
   })
   $UpdateNowButton.Icon.Add_MouseEnter({
      $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIconHover.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonTextHover.png")))
   })
   $UpdateNowButton.Icon.Add_MouseLeave({
      $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))
   })
   $UpdateNowButton.Text.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIconHover.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonTextHover.png")))
   })
   $UpdateNowButton.Text.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))
   })
   $UpdateNowButton.Button.Add_MouseLeftButtonDown({
      $this.Tag.Button.Width = 110
      $this.Tag.Button.Height = 30
      $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonPressed.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIconPressed.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonTextPressed.png")))
      [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 780)
      [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300) 
      $this.CaptureMouse() | Out-Null
   })
   $UpdateNowButton.Button.Add_MouseLeftButtonUp({
      $this.ReleaseMouseCapture()
      if ($this.IsMouseOver) {
         $this.Tag.Button.Width = 118
         $this.Tag.Button.Height = 38
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
         $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
         $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))  
         [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 775)
         [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300) 
         #StartUpdateRun $AppList
      } else {
         $this.Tag.Button.Width = 118
         $this.Tag.Button.Height = 38
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
         $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
         $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))  
         [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 775)
         [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300)
    }
   })
   $UpdateNowButton.Icon.Add_MouseLeftButtonDown({
      $this.Tag.Button.Width = 110
      $this.Tag.Button.Height = 30
      $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonPressed.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIconPressed.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png"))) 
      [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 780)
      [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300) 
      $this.CaptureMouse() | Out-Null
   })
   $UpdateNowButton.Icon.Add_MouseLeftButtonUp({
      $this.ReleaseMouseCapture()
      if ($this.IsMouseOver) {
         $this.Tag.Button.Width = 118
         $this.Tag.Button.Height = 38 
         $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
         $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))  
         [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 775)
         [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300)  
         #StartUpdateRun $AppList    
      } else {
         $this.Tag.Button.Width = 118
         $this.Tag.Button.Height = 38 
         $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
         $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))  
         [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 775)
         [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300) 
    }
   })
   $UpdateNowButton.Text.Add_MouseLeftButtonDown({
      $this.Tag.Button.Width = 110
      $this.Tag.Button.Height = 30
      $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonPressed.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIconPressed.png")))
      $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonTextPressed.png")))
      [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 780)
      [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300) 
      $this.CaptureMouse() | Out-Null
   })
   $UpdateNowButton.Text.Add_MouseLeftButtonUp({
      $this.ReleaseMouseCapture()
      if ($this.IsMouseOver) {
         $this.Tag.Button.Width = 118
         $this.Tag.Button.Height = 38 
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
         $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
         $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))  
         [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 775)
         [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300) 
         #StartUpdateRun $AppList
      } else {
         $this.Tag.Button.Width = 118
         $this.Tag.Button.Height = 38
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonIcon.png")))
         $this.Tag.Button.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButton.png")))
         $this.Tag.Text.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\UpdateButtonText.png")))  
         [System.Windows.Controls.Canvas]::SetLeft($this.Tag.Button, 775)
         [System.Windows.Controls.Canvas]::SetTop($this.Tag.Button, 300)
    }
   })


   $SettingsButton = @{
      Button = New-Object System.Windows.Controls.Image
      Icon   = New-Object System.Windows.Controls.Image
   }
   $SettingsButton.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Bar.png")))
   $SettingsButton.Button.Width = 30
   $SettingsButton.Button.Height = 30
   $SettingsButton.Icon.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Settings.png")))
   $SettingsButton.Icon.Width = 18
   $SettingsButton.Icon.Height = 18
   $SettingsButton.Button.Tag = $SettingsButton
   $SettingsButton.Icon.Tag   = $SettingsButton
   $SettingsButton.Button.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\SettingsHover.png")))
   })
   $SettingsButton.Button.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Bar.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Settings.png")))
   })
   $SettingsButton.Icon.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\SettingsHover.png")))
   })
   $SettingsButton.Icon.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Bar.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Settings.png")))
   })


   $CloseButton = @{
      Button = New-Object System.Windows.Controls.Image
      Icon   = New-Object System.Windows.Controls.Image
   }
   $CloseButton.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Bar.png")))
   $CloseButton.Button.Width = 30
   $CloseButton.Button.Height = 30
   $CloseButton.Icon.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Close.png")))
   $CloseButton.Icon.Width = 22
   $CloseButton.Icon.Height = 22
   $CloseButton.Button.Tag = $CloseButton
   $CloseButton.Icon.Tag   = $CloseButton
   $CloseButton.Button.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\CloseHover.png")))
   })
   $CloseButton.Button.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Bar.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Close.png")))
   })
   $CloseButton.Icon.Add_MouseEnter({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\BarHover.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\CloseHover.png")))
   })
   $CloseButton.Icon.Add_MouseLeave({
      $this.Tag.Button.Source = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Bar.png")))
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Close.png")))
   })
   $CloseButton.Button.Add_MouseLeftButtonDown({
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\ClosePressed.png")))
      $this.CaptureMouse() | Out-Null
   })
   $CloseButton.Button.Add_MouseLeftButtonUp({
      $this.ReleaseMouseCapture()
      if ($this.IsMouseOver) {
         [System.Windows.Window]::GetWindow($this).Close()
      } else {
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Close.png")))
    }
   })
   $CloseButton.Icon.Add_MouseLeftButtonDown({
      $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\ClosePressed.png")))
      $this.CaptureMouse() | Out-Null
   })
   $CloseButton.Icon.Add_MouseLeftButtonUp({
      $this.ReleaseMouseCapture()
      if ($this.IsMouseOver) {
         [System.Windows.Window]::GetWindow($this).Close()
      } else {
         $this.Tag.Icon.Source   = New-Object System.Windows.Media.Imaging.BitmapImage (New-Object System.Uri ((Join-Path $PSScriptRoot "..\assets\Close.png")))
    }
   })
   

   [System.Windows.Controls.Canvas]::SetLeft($Background, 0)
   [System.Windows.Controls.Canvas]::SetTop($Background, 0)
   [System.Windows.Controls.Canvas]::SetLeft($DragBarImage, 0)
   [System.Windows.Controls.Canvas]::SetTop($DragBarImage, 0)
   [System.Windows.Controls.Canvas]::SetLeft($Logo, 0)
   [System.Windows.Controls.Canvas]::SetTop($Logo, 5)
   [System.Windows.Controls.Canvas]::SetLeft($SystemWindowsControlsRichTextBoxImage0, 10)
   [System.Windows.Controls.Canvas]::SetTop($SystemWindowsControlsRichTextBoxImage0, 50)
   [System.Windows.Controls.Canvas]::SetLeft($SystemWindowsControlsRichTextBox0, 15)
   [System.Windows.Controls.Canvas]::SetTop($SystemWindowsControlsRichTextBox0, 60)
   [System.Windows.Controls.Canvas]::SetLeft($SystemWindowsControlsRichTextBoxImage1, 10)
   [System.Windows.Controls.Canvas]::SetTop($SystemWindowsControlsRichTextBoxImage1, 370)
   [System.Windows.Controls.Canvas]::SetLeft($SystemWindowsControlsRichTextBox1, 15)
   [System.Windows.Controls.Canvas]::SetTop($SystemWindowsControlsRichTextBox1, 380)
   [System.Windows.Controls.Canvas]::SetLeft($SystemWindowsControlsRichTextBoxImage2, 430)
   [System.Windows.Controls.Canvas]::SetTop($SystemWindowsControlsRichTextBoxImage2, 370)
   [System.Windows.Controls.Canvas]::SetLeft($SystemWindowsControlsRichTextBox2, 435)
   [System.Windows.Controls.Canvas]::SetTop($SystemWindowsControlsRichTextBox2, 380)
   [System.Windows.Controls.Canvas]::SetLeft($HomeButton.Button, 780)
   [System.Windows.Controls.Canvas]::SetTop($HomeButton.Button, 10)
   [System.Windows.Controls.Canvas]::SetLeft($HomeButton.Icon, 788)
   [System.Windows.Controls.Canvas]::SetTop($HomeButton.Icon, 18)
   [System.Windows.Controls.Canvas]::SetLeft($UpdateNowButton.Button, 775)
   [System.Windows.Controls.Canvas]::SetTop($UpdateNowButton.Button, 300)
   [System.Windows.Controls.Canvas]::SetLeft($UpdateNowButton.Icon, 790)
   [System.Windows.Controls.Canvas]::SetTop($UpdateNowButton.Icon, 305)
   [System.Windows.Controls.Canvas]::SetLeft($UpdateNowButton.Text, 820)
   [System.Windows.Controls.Canvas]::SetTop($UpdateNowButton.Text, 306)
   [System.Windows.Controls.Canvas]::SetLeft($SettingsButton.Button, 820)
   [System.Windows.Controls.Canvas]::SetTop($SettingsButton.Button, 10)
   [System.Windows.Controls.Canvas]::SetLeft($SettingsButton.Icon, 826)
   [System.Windows.Controls.Canvas]::SetTop($SettingsButton.Icon, 16)
   [System.Windows.Controls.Canvas]::SetLeft($CloseButton.Button, 860)
   [System.Windows.Controls.Canvas]::SetTop($CloseButton.Button, 10)
   [System.Windows.Controls.Canvas]::SetLeft($CloseButton.Icon, 864)
   [System.Windows.Controls.Canvas]::SetTop($CloseButton.Icon, 14)

   
   $SystemWindowsControlsCanvas = New-Object System.Windows.Controls.Canvas
   $SystemWindowsControlsCanvas.Children.Add($Background)                               | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($DragBarImage)                             | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($Logo)                                     | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SystemWindowsControlsRichTextBoxImage0)   | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SystemWindowsControlsRichTextBox0)        | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SystemWindowsControlsRichTextBoxImage1)   | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SystemWindowsControlsRichTextBox1)        | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SystemWindowsControlsRichTextBoxImage2)   | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SystemWindowsControlsRichTextBox2)        | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($HomeButton.Button)                        | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($HomeButton.Icon)                          | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($UpdateNowButton.Button)                   | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($UpdateNowButton.Icon)                     | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($UpdateNowButton.Text)                     | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SettingsButton.Button)                    | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($SettingsButton.Icon)                      | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($CloseButton.Button)                       | Out-Null
   $SystemWindowsControlsCanvas.Children.Add($CloseButton.Icon)                         | Out-Null
   $Root.Content = $SystemWindowsControlsCanvas

   $Root.Show()
   return $Root, $SystemWindowsControlsRichTextBox0, $SystemWindowsControlsRichTextBox1, $SystemWindowsControlsRichTextBox2
}