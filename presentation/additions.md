---
revealOptions:
  transition: fade

---

# Container mit Docker

<div id="header-footer">
  <p class="slide-footer"><img src="images/light.svg" height="40" width="200"><br>tarent solutions GmbH<br>Volker Schmitz & Daniel Zerlett</p>
</div>

---

# Docker bis Produktion

Beispiel "rocket.chat"

----

## Bestandsaufnahme

- https://rocket.chat/docs/installation/docker-containers/
  - Securing the server
    - Firewall basics (skipped)
  - Securing the server
    - fail2ban (skipped)
  - Install docker-compose (skipped)
  - Editing the Host-File (skipped)
  - Installing NGINX & SSL certificate (skipped)
  - Create docker-compose
  - Automatic Startup & Crash Recovery
  - Reboot and Check

Note:
- ist das so okay?
- kann man etwas ändern?

----

## Vorgehen und Ziele

- Docker-Compose
  - Rocket.Chat ans laufen bekommen
    - Persistenz (Volumes)
- SSL mit traefik/dynamisches routing
  - mehrere compose-Files
  - Docker Netzwerke
- Docker Security
  - Eigenes Image bauen
- Auflösung von Abhänihgkeiten
  - Hinzufügen von Health-Checks
- Backup and Recovery

---

# Docker Netzwerke

----

## Docker Netzwerke CLI

<iframe src="http://localhost:42180?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

Note:

- docker network ls
- docker-compose naming (netzwerke und container)
- docker-compose -p
- docker network rm
- Unterschied docker-compose stop/down

----

## Übung

- Füge der docker-compose.yml von Rocket.Chat ein "separates" Netzwerk hinzu!

----

## Zusammenfassung

- Docker CLI *network*
- Verständnis von Docker-Netzwerken

---

# Docker Healthcheck

Liefert den aktuellen Health-Status des Containers.

----

## Status

- Healthy
- Unhealthy
- Starting

Dafür kann man jeden Befehl nehmen der im Container ausführbar ist, dieser muss 0 oder 1 zurückgeben (exit code).

Note:
Warum braucht man das?
Hauptsächlich für Orchestrierung.

----

## Beispiel

Im Dockerfile:

```DOCKERFILE
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```

In Compose:

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 1m30s
  timeout: 10s
  retries: 3
  start_period: 40s
```

----

## Übung

Baut in rocket.chat sowie in die MongoDB valide Health-Checks ein.
Nutzt dafür das docker-compose-File.

----

## Zusammenfassung

Docker Healthcheck über Dockerfile und docker-compose-File

---

# Traefik

----

## Was is traefik?

<img src="images/traefik.svg"/>

----

## Traefik als Reverse-Proxy

```yaml
proxy:
  image: traefik # The official Traefik docker image
  command: --api --docker # Enables the web UI and tells Traefik to listen to docker
  ports:
    - "80:80"     # The HTTP port
    - "443:443" # The HTTPS port
    - "8080:8080" # The Web UI (enabled by --api)
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock # So that Traefik can listen to the Docker events
```

----

## Dynamisches Routing über Treafik

```yaml
  whoami:
    image: containous/whoami # A container that exposes an API to show its IP address
    labels:
      - "traefik.frontend.rule=Host:whoami.docker.localhost"
```

```shell
curl -H Host:whoami.docker.localhost http://127.0.0.1
```

Note:

- traefik.backend=blog
- traefik.frontend.rule=Host:blog.example.com
- traefik.docker.network=proxy
- traefik.port=80

----

## Übung

Baut eine Docker Compose mit traefik und routet rocket.chat über diesen.

<iframe src="http://localhost:42190?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

----

## Traefik SSL mit Let's Encrypt

- ACME

---

# Backup

- mongodb
- Volumes

----

# Backup

<iframe src="http://localhost:42200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

---

# Monitoring

- Grafana
- Telegraf
- InfluxDB

----

# Monitoring

<iframe src="http://localhost:42210?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

---

# ENDE PRAXISTEIL

---

# Best practice

- Konfiguration über Umgebungsvariablen
- Logging über STDOUT
  - Filebeat JSONLOG
- Nur ein Prozess
- Exit Codes (SIGTERM usw)

----

## Übung

- start.sh
  - mit debug help etc
- ENTRYPOINT auf start.sh
- reagiert auf SIGTERM oder definiert ein STOPSIGNAL
- Sinnvolle(tm) Exit-Codes
 (siehe --init)
- Nutze die Health Resource im HEALTHCHECK

---

# Security

- Docker User Space
- Dies kann man Reglementieren
- Angreifbare - libaries im Container/Image
- Docker Hub Security Scan
- Docker User Space

----

## User Space

- Docker läuft als root
- Container laufen Default als root
- Kein standard Zugriff auf das Host Netz

----

## Was tun?

- Dockerfile
  - USER
DockerCLI
  - *--user*

---

# Docker Daemon

- Configuration von Netzwerken
- Configuration des Logging Drivers

----

## Netzwerkconfiguration

```json
{
  "bip": "10.60.3.1/24",
  "default-address-pools":
  [
    {
      "scope":"local",
      "base":"10.60.0.0/16",
      "size":24
    },
    {
      "scope":"global",
      "base":"10.61.0.0/16",
      "size":24
    }
  ]
}
```

----

## Logging Configuration

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```

Note:
docker run --log-driver json-file --log-opt max-size=10m alpine echo hello world

---

# Orchestrierung mit Swarm

----

## Initialisieren

- docker swarm init

----

## Erweitern

- docker join

----

## Swarm CLI

Alles anders aber doch irgendwie gleich.

- docker stack
- docker service

----

## Skalierung und Redundanz

- Storage
  - NFS, GlusterFS
- Datenbanken
  - Cluster

---

# Ende
