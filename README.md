ZABBIX-PROXY-ARMV7(8)=====System Manager's Manual=====ZABBIX-PROXY-ARMV7(8)

NAME
     zabbix-proxy-armv7 — GitHub Actions builder for 32-bit QNAP NAS devices

SYNOPSIS
     1. Fork or copy this repository to your GitHub account.
     2. GitHub Actions workflow triggers automatically to build the image.
     3. Download or pull the compiled zabbix-proxy:7.0-armv7 image.
     4. Deploy via QNAP Container Station using Docker Compose.

DESCRIPTION
     The zabbix-proxy-armv7 utility provides an automated CI/CD pipeline
     tailored for compiling and building Zabbix Proxy 7.0 Docker images
     optimized for 32-bit ARM architectures (ARMv7), specifically targeting
     hardware constraints like the QNAP TS-431XeU.

     By offloading the compilation process to GitHub Actions, users do not
     need to expend local computational resources or consume premium paid
     tokens for cross-architecture builds. The workflow outputs a ready-to-
     deploy image.

DEPLOYMENT
     To deploy the compiled image within QNAP Container Station, create a new
     Application and insert the following Docker Compose configuration:

     version: '3.8'

     services:
       zabbix-proxy:
         image: zabbix-proxy:7.0-armv7 
         container_name: zabbix-proxy
         
         environment:
           - ZBX_SERVER_HOST=[ip_zabbix_server]:10051 
           - ZBX_HOSTNAME=ts431xeu
           - ZBX_PROXYMODE=0 
           
         volumes:
           - zabbix-proxy-db:/var/lib/zabbix/db_data
         restart: unless-stopped
     volumes:
       zabbix-proxy-db:
         driver: local

FILES
     README.txt            This manual file.
     .github/workflows/    GitHub Actions workflow definitions.
     .github/FUNDING.yml   Repository sponsorship configuration.

SEE ALSO
     docker-compose(1), zabbix_proxy(8)

If this solution saved your tokens and time, consider supporting the author.
Sponsorship Link:
.github/FUNDING.yml
