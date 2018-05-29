Param (
	[string]$Path = "c:\xxx",
	[string]$SMTPServer = "smtp.domain.com",
	[string]$From = "alias@domain.com",
	[string]$To = "alias@domain.com",
	[string]$Subject = "new file created"
	)

$SMTPMessage = @{
To = $To
From = $From
Subject = "$Subject at $Path"
Smtpserver = $SMTPServer
}

$File = Get-ChildItem $Path | Where { $_.name -match 'password' -and $_.LastWriteTime -ge [datetime]::Now.AddMinutes(-30)}
If ($File)
{	$SMTPBody = "`nThe following File /folder have recently been added :`n`n"
	$File | ForEach { $SMTPBody += "$($_.FullName)`n" }
	Send-MailMessage @SMTPMessage -Body $SMTPBody