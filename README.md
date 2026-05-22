# Strukturverktyg

Ett PowerShell-skript som automatiskt skapar en mappstruktur.

## Vad gör skriptet?

När du kör skriptet får du ange ett namn. Skriptet skapar då en huvudmapp med det namnet och tre undermappar inuti:

```
<namn>/
├── logs/
│   └── log-YYYY-MM-DD.txt
├── scripts/
└── temp/
```

Loggfilen skapas automatiskt med dagens datum som filnamn och innehåller en rad med datum och tid för när strukturen skapades.

## Hur kör man skriptet?

### Om du har .ps1-filen på datorn

1. Kör detta kommando en gång i terminalen om du aldrig kört PowerShell-skript tidigare:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
   ```
   Svara **J** eller **Y** när terminalen frågar.

   > **Varför krävs det här?** Windows blockerar körning av PowerShell-skript som standard. Det är en säkerhetsinställning som förhindrar att skript körs av misstag eller av illasinnade program. `-Scope CurrentUser` betyder att du bara ändrar inställningen för ditt eget användarkonto, inte för hela datorn. `RemoteSigned` betyder att skript du själv skrivit får köras fritt, men skript som laddats ner från internet måste vara digitalt signerade. Det är ett engångssteg och behöver inte göras igen.

2. Navigera till den mapp där du vill att mappstrukturen skapas:
   ```powershell
   cd C:\Users\Namn\Desktop
   ```

3. Öppna skriptet i VS Code och tryck **Run**, eller kör det via terminalen:
   ```powershell
   & "C:\Scripts\strukturverktyg.ps1" 
   ```
   Ändra namn och sökväg till där du valt att spara skriptet.

   
   
5. Ange ett namn när skriptet frågar och tryck Enter.

> **OBS:** Om en mapp med samma namn redan finns avbryts skriptet med ett felmeddelande.

---

## Vad var svårt eller intressant?

Det svåraste under projektet var att hantera teckenkodning. Svenska tecken som å, ä och ö orsakade fel. Det hade lätt kunnat lösas om jag valt att använda mig av engelska, men vad är det roliga i det?

Det mest intressanta var att se hur enkla byggstenar som variabler, funktioner och loopar sätts ihop till ett skript som faktiskt gör något mer än retunerar 'Hello world' i terminalen. 
Felhanteringen med try/catch kändes också som ett stort steg. Istället för att skriptet kraschar får användaren ett tydligt meddelande om vad som gick fel.

Självklart var det ju också intressant att få lära sig mer om allt. Tidigare har man kanske googlat fram ett skript och bara copy pastat in i terminalen för att få något löst. Här byggde man det ändå från grunden vilket är för jäkla skoj i slutändan när allt lirar.


