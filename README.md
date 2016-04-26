# Slack Incoming Webhook Notification using Powershell

## Required powershell version: 3 and onwards

Thea idea behind this project is to notify at the beginning of each deployment with a message in slack.
So I wrote this powershell that will do the work for me

The challenge was to understand how to write a simple json object inside a powershell by doing:
```
@{
 "YourJson" : "GoesHere"
}@
```

And the multiple possibilities that offer <a href="https://api.slack.com/incoming-webhooksIncoming">Incoming Webhooks</a>
(Customize Slack -> Configure Apps -> Search -> Incoming Webhooks -> Install)

## About the project

We are using 
```
Get-Date.AddMinutes(5)
```

To get the current date and add to that 5 minutes. Because all our deployments need to be notified with at least five minutes in advance.
```
$currentTime.ToShortTimeString() will return the hour, so for example: 02:43
```
