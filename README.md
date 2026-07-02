# Zabbix Proxy 7.0 for 32-bit QNAP NAS

<p align="right">
  <strong>Translations:</strong> <a href="README_ru.md">🇷🇺 Русский</a>
</p>

---

### Overview
This solution provides an automated build system for **Zabbix Proxy 7.0** tailored specifically for QNAP NAS devices running on 32-bit ARM processors (e.g., **TS-431XeU**). 

> [!TIP]
> **Save Your Resources and Tokens!**
> By forking this repository, you leverage free cloud-based compilation via **GitHub Actions**. There is absolutely no need to spend your local CPU cycles, time, or third-party premium tokens on cross-architecture building.

---

### How It Works
1. **Fork or copy** this repository to your personal GitHub account.
2. The bundled **GitHub Actions** workflow triggers automatically upon changes or manual dispatch.
3. The runner builds the `zabbix-proxy:7.0-armv7` image in the cloud.
4. You pull/download the finalized image directly to your environment.

---

### Deployment
To deploy the compiled image, open your QNAP management interface and navigate to:
**Container Station** → **Application** → **Create**

Utilize the following Docker Compose configuration:

```yaml
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
```

---

### Funding & Support

If this project saved your tokens, CPU resources, and time, please consider supporting its development.

<p align="left">
  <a href=".github/FUNDING.yml">
    <img src="https://img.shields.io/badge/Sponsor_this_project-ea4aaa?style=for-the-badge&logo=github-sponsors&logoColor=white" alt="Sponsor Badge"/>
  </a>
</p>

> [!NOTE]
> You can also use the native **"Sponsor"** button located in the right sidebar of this GitHub repository page.
