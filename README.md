# Terraform-ark-server

Terraform module for running an Ark Server

## How to setup

1. Create a .tfvars file in the root directory

2. Create a PEM Key through the AWS console

3. Declare necessary variables
   * NOTE: You can also specify other variables such as instance type in the event you need more computing power
   * Required variables
     * server_name
     * key_name
     * my_ip
     * server_password
     * admin_password

4. Create AWS credentials by creating a new user via the IAM section in the AWS console

5. Export your access key and secret access keys
   1. Access key: `export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>`
   2. Secret Access Key: `export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>`

6. Initialize terraform with `terraform init`

7. Plan your infrastructure to make sure there aren't any errors `terraform plan -var-file="<name_of_var_file>.tfvars"`

8. Create your resources `terraform apply --auto-approve -var-file="<name_of_var_file>.tfvars"`

9. Wait a couple of minutes for your Ark server to be installed and startup

10. Check if your server is discoverable through the SteamAPI `https://api.steampowered.com/ISteamApps/GetServersAtAddress/v0001?addr=<ec2_ip>`
    1. You can find the ec2_ip through the AWS console labeled *Public IPv4 Address*
    2. If your server isn't discoverable after 20 minutes, try SSHing into the server with PuTTY (Windows) or via the CLI (Mac/Linux)
    3. Use the `top` command to see if the server is running under the command column named `ShooterGam+` or `steamcmd` if it's still installing
       1. If neither are showing up, check the script log with `view script.log` command and check to see where the script went wrong

11. You should receive a JSON response with a structure like this

```json
{
    "response": {
        "success": true,
        "servers": [
            {
                "addr": "1.2.3.4:7777",
                "gmsindex": -1,
                "steamid": "xxxxxxxxxxxxxx",
                "appid": 346110,
                "gamedir": "ark_survival_evolved",
                "region": -1,
                "secure": false,
                "lan": false,
                "gameport": 7777,
                "specport": 0
            }
        ]
    }
}
```

12. Add your server to your favorites list by going into Steam and at the top window options -> View -> Game Servers -> Favorites -> plus sign -> enter the public ec2_ip
13. Connect to the server with your password (if set)
14. Have fun on the Ark!
