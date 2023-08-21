#!/bin/bash

DomainName="plex.yourdomain.com"
PlexCertPath="/opt/plex/cert"
PlexCertPass="Password_Here"
PlexDockerName="Plex_Docker_Container_Name"

# Create PKCS #12 Cert
openssl pkcs12 -export \
  -out $PlexCertPath/plex_certificate.p12 \
  -in /etc/letsencrypt/live/$DomainName/cert.pem \
  -inkey /etc/letsencrypt/live/$DomainName/privkey.pem \
  -certfile /etc/letsencrypt/live/$DomainName/chain.pem \
  -passout pass:$PlexCertPass \
  -certpbe AES-256-CBC -keypbe AES-256-CBC -macalg SHA256

chmod 755 $PlexCertPath/plex_certificate.p12

# Restart Plex docker container
docker restart $PlexDockerName