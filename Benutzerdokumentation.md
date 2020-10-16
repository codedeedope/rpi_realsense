Diese Benutzerdokumentation ist [hier](https://codedeedope.github.io/rpi_realsense/Benutzerdokumentation.html) auch im Web zu finden.

# Vorbedingungen
## Hardware
* Rechner. Getestet mit Kubuntu 18.04 und ROS Melodic Morenia. ROS Daten empfangen müsste aber auch mit neuerem (K-)ubuntu und ROS funktionieren. Auch getestet in einer virtuellen Maschine mit dem DHCP Server auf OpenSuse Linux als Host.
* Vorkonfigurierter Raspberry Pi 4B (nachfolgend “RPI” genannt)
* RPI Netzteil
* Intel® RealSense™ Depth Camera D435 (Firmware Version 5.12.7.100 vorinstalliert auf einer Kamera mindestens)
* USB 3.1 Gen 2 Typ-C nach Standard-A Kabel
* Ethernet Kabel

## Anschlusskonfiguration
* Kamera an RPI via USB Kabel verbunden.
* RPI Stromkabel verbunden.
* RPI an Rechner via Ethernet Kabel verbunden.

# Einrichten
**– Kann je nach System variieren –** \
**- Nur relevant bei eigenem Rechner –**

## Netzwerkverbindung einrichten
In KDE Network Connections: \
Neues Wired Ethernet “RPI4” anlegen. \
IPv4 Method "Manual" eintragen. \
Adress: 192.168.10.2

## DHCP Server installieren
Ist Folgender. Je nach System wird er anders installiert.

	isc dhcp server


## RPI statische IP Adresse zuweisen via DHCP Server
Via

	sudo nano /etc/dhcp/dhcpd.conf


Folgendes einfügen:

	subnet 192.168.10.0 netmask 255.255.255.0 {
	}

	host rpi4 {
	hardware ethernet dc:a6:32:58:1e:a9;
	fixed-address 192.168.10.137;
	}

Dienst aktivieren

	sudo systemctl restart isc-dhcp-server.service

Überprüfen \
**Achtung: Netzwerkverbindung “RPI4” muss aktiviert sein!**

	sudo journalctl --unit=dhcpd.service
	nmap -T5 -sP 192.168.10.0-255
	ping 192.168.10.137

# Verwenden
Netzwerkverbindung “RPI4” aktivieren. \
**Beim Labor Rechner muss "Vicon" aktiviert sein.**

u.U. DHCP Server (neu-) starten

	sudo systemctl restart dhcpd.service

**Achtung:** `sudo nmap -sn 192.168.10.0-255` zeigt die falsche MAC Adresse an, wenn das RPI hinter dem PoE Switch ist. \
`sudo journalctl --unit isc-dhcp-server.service` benutzen, um MAC - IP Zuordnung zu überprüfen.

SSH Verbindung zum RPI4 öffnen

	ssh ubuntu@192.168.10.137

->Passwort: password

Auf dem RPI4 via SSH ausführen

	sudo docker run -it --rm --name=ros --privileged \
	--mount type=bind,src=/usr/local/,dst=/usr/local/ \
	--mount type=bind,src=/home/ubuntu/realsense-ros_ws/,dst=/home/idein/realsense-ros_ws \
	--network=host \
	realsense-ros-pi:latest

**Folgendes lokal machen, nicht auf dem RPI!**

Auf Empfänger Maschine eigene IP setzen

	export ROS_IP=192.168.10.2

Auf Empfänger Maschine IP des PI's setzen

	export ROS_MASTER_URI=http://192.168.10.137:11311

Kamera Daten sind jetzt verfügbar. Nachzuschauen mit

	rostopic list
	rostopic echo
	rviz

