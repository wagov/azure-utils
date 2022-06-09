# Microsoft Sentinel Detection Rules Guide

## General Approach
Start with the microsoft templates to [detect threats out-of-the-box](https://docs.microsoft.com/en-us/azure/sentinel/detect-threats-built-in), then work on building out your detection rules using community resources such as the [SOC Prime Threat Detection Marketplace](https://my.socprime.com/tdm/).

## Examples

### DNS Events
Some firewalls may regularly query malicious domains in their block lists as part of their maintenance activities for firewall rules. These domains and firewalls should be added to suppression rules.