# Strukturverktyg

Ett PowerShell-skript som automatiskt skapar en mappstruktur för ett valfritt system eller miljö.

## Vad gör skriptet?

När du kör skriptet får du ange ett namn — till exempel ett kundsystem eller en miljö. Skriptet skapar då en huvudmapp med det namnet och tre undermappar inuti:

```
<namn>/
├── logs/
│   └── log-YYYY-MM-DD.txt
├── scripts/
└── temp/
```

Loggfilen skapas automatiskt med dagens datum som filnamn och innehåller en rad med datum och tid för när strukturen skapades.

## Hur kör man skriptet?

### Om du har fått .ps1-filen direkt

1. Kör detta kommando en gång i terminalen om du aldrig kört PowerShell-skript tidigare:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
   ```
   Svara **J** eller **Y** när terminalen frågar.

   > **Varför krävs det här?** Windows blockerar körning av PowerShell-skript som standard. Det är en säkerhetsinställning som förhindrar att skript körs av misstag eller av illasinnade program. `-Scope CurrentUser` betyder att du bara ändrar inställningen för ditt eget användarkonto — inte för hela datorn. `RemoteSigned` betyder att skript du själv skrivit får köras fritt, men skript som laddats ner från internet måste vara digitalt signerade. Det är ett engångssteg och behöver inte göras igen.

2. Navigera till den mapp där du vill att mappstrukturen skapas:
   ```powershell
   cd C:\Users\Namn\Desktop
   ```

3. Öppna skriptet i VS Code och tryck **Run**, eller kör det via terminalen:
   ```powershell
   & "C:\Scripts\strukturverktyg.ps1"
   ```

4. Ange ett namn när skriptet frågar och tryck Enter.

> **OBS:** Om en mapp med samma namn redan finns avbryts skriptet med ett felmeddelande.

---

### Om du skapar filen från scratch (t.ex. från GitHub)

Om du inte har filen utan vill skapa den själv genom att kopiera koden, kör följande i terminalen. Det säkerställer att filen sparas med rätt teckenkodning så att svenska tecken fungerar korrekt:

```powershell
$kod = @'
... (klistra in skriptkoden här)
'@

[System.IO.File]::WriteAllText("C:\Scripts\strukturverktyg.ps1", $kod, [System.Text.Encoding]::UTF8)
```

Kör sedan `Set-ExecutionPolicy` enligt steg 1 ovan och fortsätt därifrån.

---

## Vad var svårt eller intressant?

Det svåraste under projektet var att hantera teckenkodning — svenska tecken som å, ä och ö kan orsaka fel om filen inte sparas i rätt format (UTF-8). Det är något som lätt förbises men som snabbt ställer till problem när skriptet körs.

Det mest intressanta var att se hur enkla byggstenar som variabler, funktioner och loopar sätts ihop till ett skript som faktiskt gör något användbart. Felhanteringen med try/catch kändes också som ett stort steg mot att skriva professionell kod — istället för att skriptet kraschar får användaren ett tydligt meddelande om vad som gick fel.
