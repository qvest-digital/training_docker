
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

### Übung: 
 - Befehle selber ausprobieren


## Ports, Volumes und Environment Variablen
 docker run -d -p mysql und so weiter
  (random vs fixed)
 docker -v 
  (anonymous, named vs path) rw ro etc.
  docker -e root_password
 
 TODO: mysql image vorbereiten
  
### Übung:
 - DB starten und in lokalem directory dateien sichten ./volumes/db
 - Umgebungsvariablen richtig setzten:
   - root passwort
   - default db
   - etc.
 
 
## Container verknüpfen
 - beide container starten und gitea die sql verbindung geben

### Übung:
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
 - docker inspect
 - unterschied docker-compose stop/down 
   




----
SNIP
----
 
## Anforderungen an die Anwendung

 - alles läuft als Docker-Container
 - glusterfs Gegenbeispiel
 
### Best practice

 - Konfiguration über Umgebungsvariablen
 - Logging über STDOUT
 - Nur ein Prozess
 - reagiert auf SIGTERM oder definiert ein STOPSIGNAL
 - Sinnvolle(tm) Exit-Codes  
  (siehe --init)
  


## Dockerfile
 
 
 