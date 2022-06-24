# Microsoft Sentinel Detection Rules Guide

## General Approach
Start with the microsoft templates to [detect threats out-of-the-box](https://docs.microsoft.com/en-us/azure/sentinel/detect-threats-built-in), then work on building out your detection rules using community resources such as the [SOC Prime Threat Detection Marketplace](https://my.socprime.com/tdm/). Once detections are in place common activities (vulnerability scanning, threat feed updates, etc) can trigger a large volume of false positives - to manage this look into [creating targeted suppression rules](https://docs.microsoft.com/en-us/azure/defender-for-cloud/alerts-suppression-rules#create-a-suppression-rule) based on key attributes of the entities within the alert.

## Examples

### DNS Events
Some firewalls may regularly query malicious domains in their block lists as part of their maintenance activities for firewall rules. These domains and firewalls should be added to suppression rules. An example of how to create a rule that would block appropriate entities is below:

![](https://docs.microsoft.com/en-us/azure/defender-for-cloud/media/alerts-suppression-rules/new-suppression-rule-pane.png)