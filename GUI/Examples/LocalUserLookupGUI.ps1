Add-Type -AssemblyName System.Windows.Forms

# Form
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Local User Lookup"
$Form.Size = New-Object System.Drawing.Size(300, 120)

# Username label
$Label = New-Object System.Windows.Forms.Label
$Label.Location = New-Object System.Drawing.Point(20, 20)
$Label.Size = New-Object System.Drawing.Size(80, 20)
$Label.Text = "Username:"
$Form.Controls.Add($Label)

# Text box to enter username
$TextBox = New-Object System.Windows.Forms.TextBox
$TextBox.Location = New-Object System.Drawing.Point(100, 20)
$TextBox.Size = New-Object System.Drawing.Size(150, 20)
$Form.Controls.Add($TextBox)

# Search button
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(100, 60)
$Button.Size = New-Object System.Drawing.Size(100, 30)
$Button.Text = "Search"
$Button.Add_Click({
    $username = $TextBox.Text
    $user = Get-LocalUser -Name $username
    if ($user) {
        $TextBox.ForeColor = "Green"
    } else {
        $TextBox.ForeColor = "Red"
    }
})
$Form.Controls.Add($Button)

$Form.ShowDialog() | Out-Null
