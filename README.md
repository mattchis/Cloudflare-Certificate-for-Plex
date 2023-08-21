# Cloudflare-Certificate-for-Plex

This script is for grabing a Let's Encrypt Certificate from Cloudflare and convert it to pkcs12 for Plex.

## Install required packages

`apt-get install python3-certbot python3-certbot-dns-cloudflare`

## Setup Secret File
`mkdir -p ~/.secrets/certbot/`
`touch ~/.secrets/certbot/cloudflare.ini`
`chmod 600 ~/.secrets/certbot/cloudflare.ini`

## Add the follow to the cloudflare.ini file
`dns_cloudflare_email = CLOUDFLARE_USER_ACCOUNT`
`dns_cloudflare_api_key = SECRET_TOKEN`

## Pull Initial Certificate from Cloudflare
`certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini -m EmailAddress -d DomainName`

## Edit plex-cert.sh with your setup details

## Manual Run
`/root/plex-cert.sh`

## Add crontab Entry for auto renewal
`0 0,12 * * * root sleep 609 && certbot renew -q && /root/plex-cert.sh`

## Enable certificate on Plex
Under the settings in the Plex web GUI select **Network** then change the following:
- **Secure connections:** Required
- **Custom certificate location:** /PlexCertPath/plex_certificate.p12
- **Custom certificate encryption key:** PlexCertPass
- **Custom certificate domain:** DomainName

## Checking the experation date on certificate
`openssl pkcs12 -in /PlexCertPath/plex_certificate.p12 -nokeys -passin pass:"PlexCertPass" -clcerts | openssl x509 -enddate`