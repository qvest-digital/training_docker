---
revealOptions:
  transition: fade
---

![docker](./images/docker_logo.png)

----

<div class="divided">
  <h4>Volker Schmitz</h4>
  <img src="./images/saltyblu.png">
  <h5>DevOps Engineer</h5> 
  v.schmitz@tarent.de
</div>

<div class="divided">
  <h4>Daniel Zerlett</h4>
  <img src="./images/b00lduck.png">
  <h5>Software Architect</h5>
  d.zerlett@tarent.de
</div>

----

- Überblick
- Erste Schritte mit dem Docker CLI
- Container-Lifecycle
- Portfreigaben
- Volumes
- Eigene Images erstellen

---

## Was ist Docker

- Motivation
- Seit wann gibt es Docker
- cgroups

----

## Container vs. Virtual Machine

----

### Betriebssystemvirtualisierung

* VirtualBox, Hyper-V Server, QEMU
Note: Bild übernehmen/einfügen (TODO)
Note: https://de.wikipedia.org/wiki/Kernel-based_Virtual_Machine#/media/File:Kernel-based_Virtual_Machine.svg

----

### Containervirtualisierung

* Taskrunner (ähnlich systemd/init)
* Isolieren von Anwendungen und deren Abhängigkeiten durch eigenes Dateisystem

Note: Bild übernehmen/einfügen (TODO)
Note: https://auctores.de/software/verwendete-software-architektur/docker-und-container/

---

## Erste Schritte

```bash
docker run hello-world
```
Note: Ziel: Erster Gehversuch mit Docker, Docker Umgebung funktioniert.
----

## Erste Schritte

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

Note: docker run hello-world

----

## Docker CLI

Docker CLI ist ein Kommandozeilen-Tool mit dem sich auf einfachste Weise der Docker-Daemon kontrollieren lässt.

Einfache Anwendungsfälle von Docker CLI:
- Container erstellen
- Container starten
- laufende Container anzeigen
- Container stoppen

Note: Ziel: Docker CLI Grundlagen verstehen
Note: Systemd-Analogie ansprechen
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
Note: Ziel ist es zu erkennen, wie einfach die Instalation ist.

----

### Übung gitea

- Starte "gitea" vom Docker-Image "gitea/gitea" im Hintergund und exponiere den Container-Port 3000 auf den Host-Port 8080!
- Zeige alle laufenden Docker-Prozesse an und erkenne, ob der Port 3000 auf Port 8080 exponiert ist!
- Bonus: Betrachte die Log-Ausgabe des gitea-Containers in Echtzeit!

Note: split view (TODO)
Note: Bonus bonus: Gibt es noch andere Ports im gitea-Container, die nicht exponiert sind? Wenn ja, exponiere auch diesen Port!

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

Note: docker run -d -p 3000:3000 gitea/gitea

----

### Zusammenfassung

- Erstellen eines Containers mit exponiertem Port 
  - `docker run`
- Containerübersicht
  - `docker ps`
- Ausgabe von Logs
  - `docker logs`
- Docker CLI Hilfe
  - `docker help`
  - `docker help <subcommand>`

Note: split view (TODO)
<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

---

## Container-Lifecycle

TODO: Einfaches Bild zum Lifecycle

----

- Created
  - Container ist erstellt aber nicht gestartet
- Running
  - Container ist gestartet 
- Stopped
  - Container ist noch vorhanden aber gestoppt 
- Paused
  - Container ist angehalten
- Deleted
  - Container ist gelöscht

----

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

Note: docker ps -a
Note: docker stop
Note: docker rm

----

### Übung Lifecycle

- Alle laufenden Container sollen beendet und gelöscht werden. 
- Wie stelle ich fest, dass alle Container gelöscht sind?

---

## Docker Ports & Volumes

----

### Docker Portfreigaben

Docker kann Container Ports an Hostports binden (exponieren).

```
docker run -d -p 80:8081 wordpress
docker run -d -p 80 wordpress
docker ps
```

Note: split view (TODO)
<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

Note: Zwei unterschiedliche Container, binden auf zwei unterschiedlichen Ports.
Note: Random-Ports erklären


### Docker Volumes

```shell
docker run -v /some/content:/usr/share/nginx/html:ro -d nginx
```

Note: split view (TODO)
<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

Note: Kurzer Hinweis auf Anonymous und Named-Volumes
Note: ro,rw etc.

----

### Docker Volumes Detail

- Default: read/write
  - docker run -v /local/folder:/container/folder imageName
  - docker run -v /local/folder:/container/folder:rw imageName
- Read only
  - docker run -v /local/folder:/container/folder:ro imageName

----

### Übung Volumes and Ports

- Starte gitea mit folgenden Optionen:
  - Persistenz der Git-Konfiguration (Container-Pfad /data)
  - Exponiere das Webinterface 
    - Containerport 3000 auf lokalen Port 3000
  - Exponiere SSH
    - Containerport 22 auf lokalen Port 3022
- Richte gitea über das Webinterface ein (http://localhost:3000)
  - Default-Settings lassen
- Container stoppen und löschen
  - Bonus: Gibt es einen Befehl der Stoppen und Löschen vereint?
- Container mit den selben Optionen wieder erstellen
- Was passiert mit der Konfiguration und den Nutzdaten von gitea?

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

Note: docker run -v $(pwd)/gitea-data:/data -p 3000:3000 -p 22:3022
Note: docker stop `containterid`
Note: docker rm `containerid` 
Note: docker rm -f `containerid`
  
----

### Zusammenfassung  

- Exponieren von beliebigen Ports
  - Random Ports
  - Fixed Ports
- Einbinden von Volumes
  - Schreib/Lesezugriff
  - Schreibgeschützt (ro) 
- Stoppen und löschen von Containern
  - docker stop
  - docker rm  
  - docker rm -f 
  
<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->  

Note: docker run -p 3000:3000 -p 3022:22 -v $(pwd)/giteatest:/data gitea/gitea
  
---

## Environment-Variablen

Note: Beispiel environment variablen an MariaDB zeigen.

```
docker run -d \
           -e MYSQL_ROOT_PASSWORD=supersicher \
           -e MYSQL_USER=wordpress \
           -e MYSQL_PASSWORD=wordpress \
           -e MYSQL_DATABASE=wordpress \
           -v $(pwd)/mariadb-data:/var/lib/mysql \
           --name wordpress-database \
           mariadb

docker inspect wordpress-database
```

----

### Übung PostgresDB starten

 - Starte einen [postgreSQL](https://hub.docker.com/_/postgres/) Docker-Container mit:
   - einer automatisch erstellten Datenbank mit dediziertem Benutzeraccount 
   - Umgebungsvariablen POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB
 - Sorge dafür, dass das Datenverzeichnis der Datenbank (/var/lib/postgresql/data) auf ein lokales 
   Volume ($(pwd)/volumes/db) gemappt ist!
   
Note: docker run -d --name=gitea-database -e POSTGRES_USER=gitea -e POSTGRES_PASSWORD=gitea -e POSTGRES_DB=gitea -v $(pwd)/postgesql-data:/var/lib/postgresql/data postgres

----

### Zusammenfassung

- Container Namen geben (--name)
- Environment-Variablen an Container übergeben (-e)
- docker inspect

---

## Kommunikation zwischen Containern

Kommunikation über die "Docker default bridge"
Namensauflösung per Docker-DNS

Note: Wordpress-Container starten, mit mysql verknüpfen
Note: Ziel: Interne Kommunikation zwischen Containern
Note: docker run --link=wordpress-database -e WORDPRESS_DB_HOST=wordpress-database -e WORDPRESS_DB_USER=wordpress -e WORDPRESS_DB_PASSWORD=wordpress -e WORDPRESS_DB_NAME=wordpress wordpress

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->

----

### Übung: Gitea mit PostgreSQL verbinden

- Stoppe und lösche nun deinen Gitea Container!
- Konfiguriere den Container so, dass Gitea seine Konfiguration in der lokalen PostgreSQL speichert!
  - Benutze dafür die vorher erstellte Datenbank!
  
Note: docker run -d --name=gitea-database -e POSTGRES_USER=gitea -e POSTGRES_PASSWORD=gitea -e POSTGRES_DB=gitea -v $(pwd)/postgesql-data:/var/lib/postgresql/data postgres
Note: docker run -p 3000:3000 -v $(pwd)/gitea/data:/data -p 3000:3000 -p 3022:22 --link=gitea-database gitea/gitea

----

### Zusammenfassung

Verbinden von Containern
  - --link
  - Namensauflösung per Docker DNS

---

## Container und Images

- Was ist ein Image und was ist ein Container

Note: Ein Image ist nicht lauffähig, es wir verwendet um ein Container zu erzeugen
Note: Ein Container ist eine Instanz von einem Image und kann zur Laufzeit verändert werden
Note: Beispiel: docker run -it ubuntu -> apt-get update; apt-get install git -y; exit
Note:           docker run -it ubuntu git --version
Note: Das Selbe nochmal mit commit
Note: docker image ls

<iframe width="100%" src="http://localhost:4200?u=trainer&p=trainer"> <!-- .element: class="fragment" -->
---

## Zusammenfassung

- Unterschied Container und Images
- docker commit
- docker images
  - docker image ls
 

# Docker Images erstellen

---

## Docker CLI

### docker exec

docker run --name mynginx-container -it nginx bash
  echo "<h1>Hello World</h1>" > /usr/share/nginx/html/index.html
  exit 
docker commit mynginx-container mynginx-image
  
Note: Docker commit erklären mit Überleitung zu Dockerfile

----

## Image aus Dockerfile erstellen


Dockerfile
```
FROM nginx
RUN echo "<h1>Hello World from Dockerfile</h1>" > /usr/share/nginx/html/index.html 
```

```bash
docker build -t mynginx-image:2
docker run -d -p 8081:80 mynginx-image
docker run -d -p 8082:80 mynginx-image:2
```

---

### Übung

- Baue ein docker Image das auf nginx basiert
- Dieses soll eine modifizierte index.html haben
- Tagge den Container als mynginx
- Baue einen zweiten nginx container der den "COPY"-Befehl nutzt.
- Tagge den Container als mynginx in Version 2
- Bonus: Nutze Nginx mit alpine anstatt ubuntu
- Bonus vergleiche die Image größen

Link zu Dokumentation

----

### Docker Base Images

Welche "base" Images gibt es?
Was sind die Unterschiede?

Note: Alpine ist der bevorzugte, da er wesentlich kleiner ist als alle anderen.

----

### Zusammenfassung

- Dockerfile
  - FROM
  - COPY
  - RUN
  - CMD
- Docker CLI
  - docker build -t tag:version .
  - docker commit image tag:version
- Docker Hub

---

## Advanced Optional

---

## docker-compose

TODO: motivation, syntax, cli

Ziel: Vereinfachung von docker cli

Tool zur Vereinfachung von docker (v2)
Tool zu benutzung von docker swarm (v3)

Note: Example: wordpress mit postgresql

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
- Unterschied docker-compose stop/down

----

### Übung

- Füge deiner docker-compose.yml ein "seprates" Netzwerk hinzu!
- Richte nun die Verbindung von gitea und mariaDB über das neuerstellte Netzwerk ein.

---

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

## Dynamisches routing labels mit traefik -- optional

Traefik beispiel zeigen

----

### Übung alles in traefik einbauen

