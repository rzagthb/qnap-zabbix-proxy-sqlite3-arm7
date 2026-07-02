# Zabbix Proxy 7.0 для 32-битных QNAP NAS

<p align="right">
  <strong>Перевод:</strong> <a href="README.md">🇬🇧 English</a>
</p>

---

### Обзор
Данное решение представляет собой автоматизированную систему сборки **Zabbix Proxy 7.0**, разработанную специально для сетевых хранилищ QNAP NAS под управлением 32-битных процессоров ARM (например, **TS-431XeU**).

> [!TIP]
> **Экономия ваших ресурсов и токенов!**
> Добавляя этот репозиторий к себе, вы делегируете всю кросс-компиляцию облачным мощностям **GitHub Actions**. Вам больше не нужно тратить ресурсы своего процессора, локальное время или платные токены на сторонних платформах для сборки под ARMv7.

---

### Принцип работы
1. **Форкните** или **скопируйте** этот репозиторий в свой аккаунт GitHub.
2. Интегрированный воркфлоу **GitHub Actions** запустится автоматически.
3. В облаке соберется готовый целевой образ `zabbix-proxy:7.0-armv7`.
4. Вы скачиваете/забираете готовый артефакт для развертывания.

---

### Развертывание
Для запуска собранного образа перейдите в веб-интерфейс управления QNAP:
**Container Station** → **Приложение** (Application) → **Создать**

Используйте следующий манифест Docker Compose:

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

### Поддержка проекта

Если этот проект сэкономил ваши токены, ресурсы процессора и время, вы можете поддержать автора.

<p align="left">
  <a href=".github/FUNDING.yml">
    <img src="https://img.shields.io/badge/Поддержать_проект-ea4aaa?style=for-the-badge&logo=github-sponsors&logoColor=white" alt="Sponsor Badge"/>
  </a>
</p>

> [!NOTE]
> Вы также можете воспользоваться стандартной кнопкой **«Sponsor»** в правом сайдбаре на главной странице этого репозитория.
