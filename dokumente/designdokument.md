## Design-Dokument Nummer: 1     Datum: 22.05.2025

### Arbeitstitel:
Dodgemania

### Kern (Vision oder Box-Rückseitentext):
**Dodgemania** ist ein kurzes und schnelles 2D-Arcade-Spiel, in dem du deine Reaktionszeit und Geschicklichkeit unter Beweis stellen kannst. Von oben regnen meteoritenartig Objekte herunter.
Der arme INSERT_NAME ist unbeholfen und weiß nicht, wie er den Objekten ausweichen soll. Nur DU kannst ihm helfen, solange wie möglich zu überleben. Aber überleben ist nicht alles.
Es wäre ja schließlich zu leicht, nur Gegenständen auszuweichen. Dein größtes Ziel ist es, Punkte zu sammeln, um zu beweisen, dass du der Beste bist.
Weiche gefährlichen Objekten aus, sammle zahlreiche Münzen und erkunde die Macht der Powerups!

Warum solltest du dieses Spiel spielen?
Durch das simple Spielprinzip, aber der fordernden Gameplay-Loop bietet **Dodgemania** dir einen hohen Wiederspielwert. Als Casual-Spieler bieten dir die Powerups eine zahlreiche Abwechslung in jeder Runde
und als kompetitiver Spieler kannst du dich durch unser Highscore-System mit anderen Spielern messen!

### Team und Verantwortlichkeiten:
* Eren – Gameplay-Programmierung, Dokumentation
* Vincent – Gameplay-Programmierung, VFX, Musik
* Jonas – UI/UX, Grafik, Soundeffekte
* Filip – Gameplay-Programmierung, Testing

### 30 Sekunden Gameplay:
Nachdem du die Runde startest, steuerst du deine Spielfigur mit den Pfeiltasten nach links und rechts auf einem horizontal begrenzten 2D-Feld. Von oben fallen kontinuierlich verschiedene Objekte herab.
Es gibt 3 Objekttypen, die unterschiedliche Effekte haben, wenn sie deine Spielfigur berühren: 
- Objekte, die dir Schaden zufügen
- Objekte, dir Punkte geben
- Objekte, die spezielle Events auslösen (Powerups)

Du versuchst so lange wie möglich zu überleben und dabei so viele Punkte wie möglich zu sammeln. Sobald du keine Leben mehr hast, endet das Spiel.
Du kannst zum Schluss deinen Namen eintragen und den Score speichern. Im Scoreboard kannst du deinen Score mit anderen Spielern vergleichen, um dich dann erneut mit ihnen zu messen.

### Risiken:
- **Monotonie durch zu wenig Variation**: Es besteht die Gefahr, dass das Spiel zu repetitiv wirkt. Gegenmaßnahme: Einführung verschiedener Powerups, anpassbarer Schwierigkeitsgrad, visuelle Abwechslung.
- **Balancing der Objekte**: Zu viele Powerups oder zu häufige Hindernisse können das Spielgefühl negativ beeinflussen. Regelmäßiges Playtesting ist notwendig.
- **Schöne Grafiken**: Schöne und vorallem einheitliche Grafiken zu erstellen ist sehr zeitaufwendig. Externe OpenSource Assets sollten bei Zeitdruck in Erwägung gezogen werden.
