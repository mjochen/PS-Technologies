$folder = Get-Item "C:\tmp\Backgrounds\oneFolder"

$allImages = Get-ChildItem $folder -File

$random = Get-Random  -Minimum $allImages.GetLowerBound(0) -Maximum $allImages.GetUpperBound(0)

# https://gist.github.com/zippy1981/969855
# Loosely based on http://www.vistax64.com/powershell/202216-display-image-powershell.html

[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")

$file = (Get-Item $allImages[$random].fullName)
#$file = (get-item "c:\image.jpg")

$img = [System.Drawing.Image]::Fromfile($file);

# This tip from http://stackoverflow.com/questions/3358372/windows-forms-look-different-in-powershell-and-powershell-ise-why/3359274#3359274
[System.Windows.Forms.Application]::EnableVisualStyles();
$form = new-object Windows.Forms.Form
$form.Text = "Image Viewer"
$form.Width = $img.Size.Width;
$form.Height =  $img.Size.Height;
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width =  $img.Size.Width;
$pictureBox.Height =  $img.Size.Height;

$pictureBox.Image = $img;
$form.controls.add($pictureBox)
$form.Add_Shown( { $form.Activate() } )
$form.ShowDialog()
#$form.Show();
