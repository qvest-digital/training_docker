---
revealOptions:
  transition: fade
---

# Containerisierung mit Docker

---

## Container vs. Virtual Machine

----

### Betriebssystemvirtualisierung

* VirtualBox, Hyper-V Server, QEMU
Note: Bild einfügen
Note: https://de.wikipedia.org/wiki/Kernel-based_Virtual_Machine#/media/File:Kernel-based_Virtual_Machine.svg

----

### Containervirtualisierung

* Taskrunner (ähnlich systemd/init)
* Isolieren von Anwendungen und deren Abhängigkeiten durch eigenes Dateisystem

---

## Erste Schritte

```bash
docker run hello-world
```
Note: Ziel: Erster gehversuch mit docker, docker Umgebung funktioniert.
----

## Erste Schritte

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

----

## Docker CLI

Docker CLI ist ein Komandozeilen-Tool mit dem sich auf einfachste weise der docker daemon kontrollieren lösst.

Dies ist vergleichar mit systemd.

Es ist möglich container zu
* starten
* stoppen
* überwachen
* erstellen

Note: Ziel: Docker CLI grundlagen verstehen
----

## Docker CLI

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

----

## Docker CLI

```shell
docker run -d -p 8080:80 wordpress
docker ps
docker logs <containerID>
```
Note: https://hub.docker.com/_/wordpress/
Note: Ziel ist es zu erkennen wie einfach die instalation ist.

----

### Übung gitea

- Starte "gitea" vom Docker-Image "gitea/gitea" und exponiere den internen Port 3000 auf den externen Port 80!
- Zeige alle laufenden Docker-Prozesse an und erkenne, ob der Port 3000 exponiert ist!
- Gibt es noch andere Ports in dem gitea-Container die nicht exponiert sind? Wenn ja, exponiere auch diesen Port!
- Betrachte die Log-Ausgabe des gitea-Containers in Echtzeit!
- Beende den gitea-Container, ohne ihn zu löschen und starte ihn wieder!
- Lösche den gitea-Container!

----

### Zusammenfassung

Docker CLI

```
docker help
```

Grundlegendes starten stoppen von containern mit `docker start && docker stop`
Übersicht mit `docker ps` und Ausgabe von Logs `docker logs`

---

## Docker Ports & Volumes

----

### Docker Ports

Docker kann Container Ports an Hostports binden.

Altes beispiel docker run -p 8080:80 wordpress

docker run -d -p 80 wordpress
docker run -d -p 80:8081 wordpress
docker ps

Note: Zwei unterschiedliche container! Binden auf zwei unterschiedliche ports

----

### Docker Ports

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

---

### Docker Volumes

```shell
docker -v /var/run/docker.sock:/var/run/docker.sock 9000:9000 portainer/portainer
```

----

### Docker Volumes Detail
 docker -v
  (anonymous, named vs path) rw ro etc.
 docker -e root_password

----

### Übung Volumes and Ports

- Starte gitea und schaffe eine persistens der gitconfiguration
- Expose den openssh Port und das Webinterface

---


## Docker communikation und Environment Variablen

- wordpress container starten
- reverese proxy starten

Note: Ziel: Interne Kommunikation zwischen containern
Note: Todo: NGINX vorbereiten mit einer konfig (ein git?) das als volume gemounted wird.
Note: Todo: Self signed Cert

----

## Docker communikation und Environment Variablen

Note: Todo: Iframe einbinden

----

### Docker Environment variablen

Note: Beispiel environment variablen an MariaDB zeigen.

### Übung MariaDB starten und einrichten

 - Starte einen [mariaDB](https://hub.docker.com/_/mariadb/) Docker-Container mit:
   - vorgeingestelltem "root"-Passwort (Umbgebungsvariable MYSQL_ROOT_PASSWORD)
   - einer automatisch erstellten Datenbank mit dediziertem Benutzeraccount (Umgebungsvariablen MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORT)
 - Sorge dafür, dass das Datenverzeichnis der Datenbank (/var/lib/mysql) auf ein lokales Volume (./volumes/db) gemappt ist!

----

### Übung Gitea mit MariaDB verbinden

- Stoppe und lösche nun deinen Gitea Container.
- Konfiguriere den Container so, dass Gitea seine Konfiguration in der lokalen MariaDB speichert
  - Benutze dafür die vorher erstellte Datenbank!

---

## Docker CLI wird zu docker-compose

Note: Todo docker cli command aufzeigen, im vergleich zu docker-compose

## Docker Architektur

Layers: Top Buttom

* Client
  * Manages:
    * container
    * images
    * networks
    * data volumes
* Rest API
* docker daeomon (server)

---

## docker-compose (v2 und v3)

TODO: motivation, syntax, cli

Ziel: vereinfachung von docker cli

Tool zur Vereinfachung von docker (v2)
Tool zu benutzung von docker swarm (v3)


## docker-compose (v3)

Example: wordpress mit mariadb und portainer in 2 netzen

----

### Übung

- Stoppe und lösche deine vorrangegangen Container ohne Nutzdatemverlust.
- Erstelle eine docker-compose.yml in der [gitea](https://hub.docker.com/r/gitea/gitea/) und mariadb als Services beschrieben sind.
  - Stelle sicher das alle Volumes und Ports erhalten bleiben.
- Lagere das Daten-Verzeichnis von gitea auf deinen Computer aus.

---

## Docker Netzwerke

- docker network ls
- docker-compose naming (netzwerke und container)
- docker-compose -p
- docker network rm
- docker inspect (auch volumes etc.)
- unterschied docker-compose stop/down

----

### Übung

- Füge deiner docker-compose.yml ein "seprates" Netzwerk hinzu!
- Richte nun die Verbindung von gitea und mariaDB über das neuerstellte Netzwerk ein.

---

# Docker Images verstehen und erstellen

---

## Anforderungen an die Anwendung

- alles läuft als Docker-Container
- glusterfs Gegenbeispiel

---

## Docker CLI

### docker exec

docker run -it worpress:latest-alpine bash
  apk add git
  exit
docker run -it wordpress:latest-alpine bash
  git --version

----

### docker commit
Docker commit erklären

----

### Docker Image version Container

Note: vorstellen wie man einen Docker container baut.
Note: verweis auf die dokumentation
Note: docker build -t

----

### Docker Versionirung

Note: tag erklären

---

## Dockerfile am Beispiel von caddy

Note: Da wir noch nicht soweit sind nehmen wir caddy (kann man kompilert runterladen)
Note: git vorbereiten (reverse Proxy einrichten?)

- FROM
- COPY
- CMD

----

### Docker Base Images

scratch vs alpine vs ubuntu vs debian vs microsoft

Note: welcher ist der richtige?
Note: Was sind die vor und nachteile?
Note: Best Practice

----

### Übung: Service in Docker Einbetten

- Kopiere das Binary (tbd) in den Dockercontainer!
  - nehme hierfür einen von scratch container
- Stelle sicher, dass der Port 8080 exponiert wird.
- Starte den Container und verbinde dich über localhost:8080
- Erweiterung
  - Lade eine caddyfile in deinen container und stelle sicher das diese geladen wird
  - füge die certificate aus dem gegeben git hinzu
  - Nutze eine andere base

----

### Übung: Nacharbeitung

- dockerfile
  - unterschiedliche FROMs
  - docker image größen beispiel mit und ohne cache
  - docker layer

---

## Docker registry

docker pull tomcat:8
docker run -d -p 8080 tomcat:8

(install git in container)
docker stop tomcat container
docker run -d -p 8080 tomcat:8

same again, for stop docker commit container

Difference container image

----

- docker registry erklären vorstellen
- docker hub vorstellen
- docker tags
- docker push
- docker pull

----

### Übung

- Beziehe aus der schulungs-registry einen Container von einem anderem Schulungsmitglied!
- Starte den Container neben deinem bestehenden Dockercontainer auf Port 8081.

---

## Dockerfile & docker build

## Layer und Storage Driver (theorie only)

- Was ist das eigentlich?
- Wo sehe ich das?

---

## Dockerfile Layer

- EXPOSE
- USER
- ENV
- RUN TODO: Bsp einbauen

----

### Übung

- Erweitere deine Dockerfile so, dass die Anwendung nicht mehr unter dem default User und Gruppe läuft!
  - Stelle mit RUN sicher, dass der User berechtigungen hat das Binary zu starten und im Verzeichnis (/app) zu schreiben.
- Konfiguriere die Anwendung über ENV variablen, stelle sicher dass alle Ports exponiert werden.

---

## Advanced Layer

- COPY vs ADD
- WORKDIR
- ENTRYPOINT vs CMD
  - ENTRYPOINT nicht überschreibbar
- HEALTHCHECK ?

----

### Übung

- Versuche den RUN Befehl durch WORKDIR und COPY --chown zu erstezen.

---

## Advanced and Optional

### Multistagebuilds

- Konzept vorstellen
  - beispiel an Go Service
- COPY --from
- STOPSIGNAL

----

#### Übung

- Baue in einem vorrangestellen Dockercontainer dein Java Jar zusammen, nenne diesen "build"!
  - benutze hierfür Gradle
- Kopiere das erfolgreich gebaute Jar vom ersten Container in den zweiten Container.
  - Nutze hierfür die Docker "Multistage Build"-Funktionalität (COPY --from=build)
- Java Service bauen mit multistage (service tut das gleiche (wie go service) ist in aber in Java geschrieben)

---

### Zusammenfassung Layer, Praxisbeispiel

- Dockerfiles vergleichen
- Layer Vergleichen
- Image Größen vergleichen

---

#### Ziel:

- Es existieren zwei Dockerfiles die beide Funktionieren
- ein Go Service ein Java Service
  - der Java service ist selbsterarbeitet

---

### Best practice

- Konfiguration über Umgebungsvariablen
- Logging über STDOUT
  - Filebeat JSONLOG
- Nur ein Prozess
- Exit Codes (SIGTERM usw)

----

#### Übung:

- start.sh
  - mit debug help etc
- ENTRYPOINT auf start.sh
- reagiert auf SIGTERM oder definiert ein STOPSIGNAL
- Sinnvolle(tm) Exit-Codes
 (siehe --init)
- Nutze die Health Resource im HEALTHCHECK


---

### Dynamisches routing labels mit traefik -- optional

Traefik beispiel zeigen

----

#### Übung alles in traefik einbauen
