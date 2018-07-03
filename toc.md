
# Docker CLI

## Docker Einstieg

### Container vs. Virtual Machine

 Docker ist ein Taskrunner, ein "besseres systemd"

## Erste Schritte

 docker run hello-world

### Docker CLI (gitea als Beispiel)

 docker run -d -p 3000:3000 gitea/gitea
 docker ps
 docker logs
 docker stop/start/restart/rm

### Übung

- Befehle selber ausprobieren

## Ports, Volumes und Environment Variablen

 docker run -d -p mysql und so weiter
  (random vs fixed)
 docker -v
  (anonymous, named vs path) rw ro etc.
  docker -e root_password

 TODO: mysql image vorbereiten

### Übung

- DB starten und in lokalem directory dateien sichten ./volumes/db
- Umgebungsvariablen richtig setzten:
  - root passwort
  - default db
  - etc.

## Container verknüpfen

- beide container starten und gitea die sql verbindung geben

- tu es

## docker-compose (v3)

- motivation, syntax, cli

### Übung

- gitea mit mysql in docker-compose
- beide mit volume

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
