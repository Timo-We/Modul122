
# CONFIG

TEMP_DIR="/c/Users/$USERNAME/AppData/Local/Temp"
TRASH_DIR="/c/Users/$USERNAME/.local/share/Trash/files"
LOG_FILE="./logs/cleanup.log"

# FUNCTIONS


show_disk_usage() {
    echo "Speicherplatz"
    df -h
}

cleanup_temp() {
    echo "Bereinige Temp-Dateien (älter als 1 Tag)"

    find "$TEMP_DIR" -depth -mtime +0 -print -exec rm -rf {} + 2>/dev/null
}

empty_trash() {
    echo "Leere Papierkorb"

    powershell.exe -Command 'Clear-RecycleBin -Force -ErrorAction SilentlyContinue'
}

log_action() {
    echo "$(date): $1" >> "$LOG_FILE"
}


# MENU


menu() {
    while true
    do
        echo ""
        echo "1) Speicher anzeigen"
        echo "2) Temp bereinigen"
        echo "3) Papierkorb leeren"
        echo "4) Alles ausführen"
        echo "5) Beenden"

        read -p "Auswahl: " choice

        if [ "$choice" = "1" ]; then
            show_disk_usage
            log_action "Speicher angezeigt"

        elif [ "$choice" = "2" ]; then
            cleanup_temp
            log_action "Temp bereinigt"

        elif [ "$choice" = "3" ]; then
            empty_trash
            log_action "Papierkorb geleert"

        elif [ "$choice" = "4" ]; then
            show_disk_usage
            cleanup_temp
            empty_trash
            log_action "Alles ausgeführt"

        elif [ "$choice" = "5" ]; then
            break

        else
            echo "Ungültige Eingabe!"
        fi
    done
}

# AUTO MODE


auto_mode() {
    echo " Automatischer Cleanup läuft"
    show_disk_usage
    cleanup_temp
    empty_trash

    log_action "Auto Cleanup ausgeführt"

}

if [ "$1" = "--auto" ]; then
	auto_mode
else
	menu
fi


