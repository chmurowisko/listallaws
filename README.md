<h1>List AWS resources in all Regions</h1>

With this simple scripts you can list many different services provisioned in all AWS Regions.

The scrips support aws cli profiles. Just add the name of the cli profile after a scrip name.

<h3>Usage:</h3>

You need to have installed and configured [aws cli](https://aws.amazon.com/cli/) before use this scripts.

Example:
1. Type: **./listallec2.sh** to run the script with default aws cli profile.
2. Type: **./listallec2.sh profile_name** to run the script for particular aws cli profile configured in aws cli credentials.


**UPDATE**
For better review, a "listaallsg" script exports all configured Security Groups to CSV file.


Author: Lukasz Dorosz [@mrdoro](https://twitter.com/mrdoro)
