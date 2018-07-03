
# Docker Einstieg

## Container vs. Virtual Machine

 Docker ist ein Taskrunner, ein "besseres systemd"

## Erste Schritte

 docker run hello-world

## Docker CLI (gitea als Beispiel)

 docker run -d -p 3000:3000 gitea/gitea
 docker ps
 docker logs
 docker stop/start/restart/rm

### Übung gitea starten

 - Starte "gitea" vom Docker-Image "gitea/gitea" und exponiere den internen Port 3000 auf den externen Port 80!
 - Zeige alle laufenden Docker-Prozesse an und erkenne, ob der Port 3000 exponiert ist!
 - Gibt es noch andere Ports in dem gitea-Container die nicht exponiert sind? Wenn ja, exponiere auch diesen Port!
 - Betrachte die Log-Ausgabe des gitea-Containers in Echtzeit!
 - Beende den gitea-Container, ohne ihn zu löschen und starte ihn wieder!
 - Lösche den gitea-Container!

## Ports, Volumes und Environment Variablen

 docker run -d -p mysql und so weiter
  (random vs fixed)
 docker -v
  (anonymous, named vs path) rw ro etc.
 docker -e root_password

 TODO: mysql image vorbereiten
 TODO: registry vorbereiten

### Übung MariaDB starten und einrichten

 - Starte einen [mariaDB](https://hub.docker.com/_/mariadb/) Docker-Container mit:
   - vorgeingestelltem "root"-Passwort (Umbgebungsvariable MYSQL_ROOT_PASSWORD)
   - einer automatisch erstellten Datenbank mit dediziertem Benutzeraccount (Umgebungsvariablen MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORT) 
 - Sorge dafür, dass das Datenverzeichnis der Datenbank (/var/lib/mysql) auf ein lokales Volume (./volumes/db) gemappt ist!
 

## Container verknüpfen

- beide container starten und gitea die sql verbindung geben

### Übung Gitea mit MariaDB verbinden

- Stoppe und lösche nun deinen Gitea Container. 
- Konfiguriere den Container so, dass Gitea seine Konfiguration in der lokalen MariaDB speichert
  - Benutze dafür die vorher erstellte Datenbank!

## docker-compose (v3)

- motivation, syntax, cli

### Übung

- Stoppe und lösche deine vorrangegangen Container ohne Nutzdatemverlust.
- Erstelle eine docker-compose.yml in der [gitea](https://hub.docker.com/r/gitea/gitea/) und mariadb als Services beschrieben sind.
  - Stelle sicher das alle Volumes und Ports erhalten bleiben.
- Lagere das Daten-Verzeichnis von gitea auf deinen Computer aus.

## Docker Netzwerke

- docker network ls
- docker-compose naming (netzwerke und container)
- docker-compose -p
- docker network rm
- docker inspect (auch volumes etc.)
- unterschied docker-compose stop/down

### Übung

- Container über docker netzwerk verbinden
- DB Verbindung über docker dns
- (streber) Internes Netzwerk

# Eigene Awendung in Docker

## Anforderungen an die Anwendung

- alles läuft als Docker-Container
- glusterfs Gegenbeispiel

## Dockerfile an beispiel eines gegebenen Services

- FROM
- COPY
- CMD

TODO: Registry vorbereiten

### Übung: Service in Docker einbetten

## Exkurs

- docker tags
- docker push
- docker pull

### Übung

- service von jmd anderem pullen und starten

## Layer und Storage Driver (theorie only)

- Was ist dasa eigentlich?
- Wo sehe ich das?

## Dockerfile Layer TODO: Split/Reihenfolge

- EXPOSE
- USER
- ENV
- RUN TODO: Bsp einbauen

### Übung

- Dockerfile erweitern

## Advanced Layer

- COPY vs ADD
- WORKDIR
- ENTRYPOINT vs CMD
  - ENTRYPOINT nicht überschreibbar
- HEALTHCHECK ?

### Übung

- Dockerfile erweitern

### Multistagebuilds

- Konzept vorstellen
  - beispiel an Go Service
- COPY --from
- STOPSIGNAL

### Übung

- Java Service bauen mit multistage (service tut das gleiche (wie go service) ist in aber in Java geschrieben)

## Zusammenfassung Layer praxis Beispiel

- Dockerfiles vergleichen
- Layer Vergleichen
- Image Größen vergleichen

### Ziel:

- Es existieren zwei Dockerfiles die beide Funktionieren
- ein Go Service ein Java Service
  - der Java service ist selbsterarbeitet

## Best practice

- Konfiguration über Umgebungsvariablen
- Logging über STDOUT
  - Filebeat JSONLOG
- Nur ein Prozess
- Exit Codes (SIGTERM usw)

### Übung:

- start.sh
  - mit debug help etc
- ENTRYPOINT auf start.sh
- reagiert auf SIGTERM oder definiert ein STOPSIGNAL
- Sinnvolle(tm) Exit-Codes
 (siehe --init)
