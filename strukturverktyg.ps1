# Ser till att svenska tecken (å, ä, ö) visas korrekt i terminalen
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# ============================================================
# Funktion: Skapa en mappstruktur
# Skapar en huvudmapp med undermappar och en loggfil.
# Tar emot ett namn från användaren som avgör vad huvudmappen ska heta.
# ============================================================
function Skapa-Mappstruktur {
    param ([string]$Namn)

    # Bygger ihop sökvägen till huvudmappen utifrån var användaren står i terminalen
    $huvudmapp = Join-Path -Path (Get-Location) -ChildPath $Namn

    # De undermappar som ska skapas inuti huvudmappen
    $undermappar = @("logs", "scripts", "temp")

    # Hämtar dagens datum som används som filnamn på loggfilen
    $datumFilnamn = Get-Date -Format "yyyy-MM-dd"

    # Hämtar datum och klockslag som används som innehåll i loggfilen
    $datumTid = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Bygger ihop den fullständiga sökvägen till loggfilen
    $loggfil = Join-Path -Path $huvudmapp -ChildPath "logs\log-$datumFilnamn.txt"

    try {
        # Skapar huvudmappen. Out-Null döljer den tekniska utskriften från New-Item
        New-Item -Path $huvudmapp -ItemType Directory | Out-Null
        Write-Host "Skapade huvudmapp: $huvudmapp" -ForegroundColor Green

        # Loopar igenom listan med undermappar och dem
        foreach ($mapp in $undermappar) {
            $sokvag = Join-Path -Path $huvudmapp -ChildPath $mapp
            New-Item -Path $sokvag -ItemType Directory | Out-Null
            Write-Host "  Skapade undermapp: $mapp" -ForegroundColor Cyan
        }

        # Skriver en rad i loggfilen med tidsstämpel för när strukturen skapades
        $logginnehall = "Struktur skapad: $datumTid"
        Set-Content -Path $loggfil -Value $logginnehall -Encoding UTF8
        Write-Host "  Skapade loggfil: log-$datumFilnamn.txt" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Klart! Mappstrukturen för '$Namn' är skapad." -ForegroundColor Green
    }
    catch {
        # Fångar upp fel och visar ett felmeddelande istället för att avlutas
        Write-Host "FEL: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# ============================================================
# Huvudprogram – det som körs när skriptet startas
# ============================================================

# Skriver ut en rubrik så användaren förstår vad skriptet gör
Write-Host "======================================" -ForegroundColor Yellow
Write-Host "   Verktyg för att skapa en mappstruktur" -ForegroundColor Yellow
Write-Host "======================================" -ForegroundColor Yellow
Write-Host ""

# Loopar tills användaren anger ett namn som fungerar
do {
    $anvandarInput = Read-Host "Ange ett namn för huvudmappen"

    # Kontrollerar att användaren inte lämnade fältet tomt
    if ([string]::IsNullOrWhiteSpace($anvandarInput)) {
        Write-Host "Du angav inget namn. Försök igen." -ForegroundColor Red
        $forsokIgen = $true
    } elseif (Test-Path (Join-Path (Get-Location) $anvandarInput)) {
        # Kontrollerar om en mapp med samma namn redan finns
        Write-Host "Mappen finns redan. Välj ett annat namn." -ForegroundColor Red
        $forsokIgen = $true
    } else {
        # Namnet är ledigt, skapar mappstrukturen och avsluta loopen
        Skapa-Mappstruktur -Namn $anvandarInput
        $forsokIgen = $false
    }

} while ($forsokIgen)
