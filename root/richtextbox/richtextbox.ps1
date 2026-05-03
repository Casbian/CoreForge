function RichTextBox([System.Windows.Controls.RichTextBox]$SystemWindowsControlsRichTextBox, [string]$Text, [System.Windows.Media.Brush]$Color = [System.Windows.Media.Brushes]::White) {
    $Run = New-Object System.Windows.Documents.Run $Text.Trim()
    $Run.Foreground = $Color
    $Paragraph = New-Object System.Windows.Documents.Paragraph $Run
    $Paragraph.Margin = [System.Windows.Thickness]::new(0)
    $SystemWindowsControlsRichTextBox.Document.Blocks.Add($Paragraph)
    $SystemWindowsControlsRichTextBox.ScrollToEnd()
}
function RichTextBoxDeleteLine([System.Windows.Controls.RichTextBox]$SystemWindowsControlsRichTextBox) {
    $SystemWindowsControlsRichTextBox.Document.Blocks.Remove($SystemWindowsControlsRichTextBox.Document.Blocks.LastBlock)
}
function RichTextBoxClear([System.Windows.Controls.RichTextBox]$SystemWindowsControlsRichTextBox) {
    $SystemWindowsControlsRichTextBox.Document.Blocks.Clear()
}