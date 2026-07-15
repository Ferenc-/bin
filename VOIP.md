# VOIP

## 1&1

https://hilfe-center.1und1.de/konfigurationsdaten-internettelefonie

### Telefonie-Passwort (VoIP-Passwort)

Das Passwort können Sie selbst vergeben bzw. ändern.

https://hilfe-center.1und1.de/telefonie-passwort-cc-aendern

```
Mit dem Telefonie-Passwort werden Ihre Festnetznummern authentifiziert.
Sie brauchen es zum Beispiel dann, wenn Sie eine neue Nummer manuell im Router eintragen möchten.

Falls Sie Ihr Telefonie-Passwort nicht kennen, können Sie es im 1&1 Control-Center neu vergeben.
Ändern Sie das Passwort danach auch in den Router-Einstellungen!
Nur so sind Sie weiterhin unter Ihrer Festnetznummer erreichbar.
```

### Benutzername

```
Länderkennung für Deutschland: 0049 oder +49
Im Benutzernamen: 49

Vorwahl Ihres Ortsnetzes: 01234
Im Benutzernamen: 1234

Rufnummer: 55667788
Im Benutzernamen: 55667788

Somit lautet Ihr Benutzername für die 1&1 Telefonie: 49123455667788
```


https://control-center.1und1.de/customerData.html#/phonenumbers
`49 4929 6629983` -> `4949296629983`

### 1&1 Telefonie-Server

#### Public UDP

```
1&1 SIP-Domäne/ 1&1 SIP-Server/Registrar: sip.1und1.de
1&1 STUN-Server: stun.1und1.de
1&1 realm: 1und1.de
SIP-Port: 5060
```

#### Internal TLS

```
registrarUri=sip:tls-sip.1und1.de
stunServers=stun.1und1.de
realm=*
port=5061
```
