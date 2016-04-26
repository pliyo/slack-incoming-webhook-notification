Param(
        [Parameter(Mandatory = $true,      Position = 0,  HelpMessage = 'Slack channel')][ValidateNotNullorEmpty()]
        [String]$Channel,
        [Parameter(Mandatory = $true,      Position = 1,  HelpMessage = 'Name of your bot')]
        [String]$BotName = 'Deployment Snitch',
        [Parameter(Mandatory = $false,     Position = 2,  HelpMessage = 'Optional url of your deployment')]
        [String]$Url = 'PowerShell Bot',
        [Parameter(Mandatory = $false,     Position = 3,  HelpMessage = 'Optional name of your deployment')]
        [String]$DeploymentName = 'New release',
        [Parameter(Mandatory = $false,     Position = 2,  HelpMessage = 'Optional environments of your deployment')]
        [String]$Environments = 'Europe',
        [Parameter(Mandatory = $false,     Position = 3,  HelpMessage = 'Optional content of your deployment')]
        [String]$Contains = 'Binaries',
        [Parameter(Mandatory = $false,     Position = 4,  HelpMessage = 'Slack Incoming Message Hook')][ValidateNotNullorEmpty()]
        [String]$Hook
)

$iconEmoji = ":bomb:"
$text = ""
If($Url.Length > 1)
{
    $deploymentUrl = "<http://$Url|$DeploymentName>"
}
$userName = ""
$currentTime = (Get-Date).AddMinutes(5)
$time = $currentTime.ToShortTimeString()
$Color = "#99ccff"

$payload = 
@"
{
	"channel"     : "$Channel",
	"icon_emoji"  : "$iconEmoji",
	"text"        : "$text",
	"username"    : "$BotName",
    "mrkdwn"      : true,
    "attachments" : 
    [
        {
            "fallback"    : "Automated Message",
            "pretext"     : "*NEW DEPLOYMENT FOR $time (BST)*: \n $deploymentUrl",
            "color"       : "#99ccff",
            "fields"      : [
                {
                    "title"  : "Environments:",
                    "value"  : "$Environments",
                    "short"  : true 
                },
                {
                    "title"  : "Contains:",
                    "value"  : "$Contains",
                    "short"  : true 
                }
            ],
            "mrkdwn_in"   : ["pretext"]
        }
    ]
}
"@

Invoke-WebRequest `
	-Uri $Hook `
	-Method "POST" `
	-Body $payload