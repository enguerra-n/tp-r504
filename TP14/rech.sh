#!/bin/bash

HISTORY_DIR="/var/log/vul_hist"
LOG_FILE_NB="$HISTORY_DIR/vul_nb.log"
LOG_FILE="$HISTORY_DIR/vul_list.log"
SEUIL_CRITIQUE=5  # Seuil de vulnérabilités critiques
SEUIL_TOTAL=10    # Seuil total de vulnérabilités

# Créer le répertoire et les fichiers de log si nécessaires
mkdir -p "$HISTORY_DIR"
touch "$LOG_FILE_NB"
touch "$LOG_FILE"

# Exécuter debsecan
RESULTS=$(debsecan)

# Nombre total de vulnérabilités
TOTAL_CVES=$(echo "$RESULTS" | wc -l)

# Nombre de vulnérabilités critiques
CRITICAL_CVES=$(echo "$RESULTS" | grep -i 'critical' | wc -l)

# Date actuelle pour les logs
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
DATE_FICHIER=$(date +'%Y-%m-%d')

# Enregistrer les résultats dans le fichier de log avec un timestamp
echo "[$(date)] - Total: $TOTAL_CVES, Critiques: $CRITICAL_CVES" >> "$LOG_FILE_NB"
echo "$RESULTS" >> "$LOG_FILE"

# Si le nombre total de vulnérabilités dépasse le seuil
if [ "$TOTAL_CVES" -ge "$SEUIL_TOTAL" ]; then
    echo "trop de vul" | mail -s "nb_vul" admin@exemple.com
fi

# Si le nombre de vulnérabilités critiques dépasse le seuil
if [ "$CRITICAL_CVES" -ge "$SEUIL_CRITIQUE" ]; then
    echo "trop de vul crit" | mail -s "nb_vul_crit" admin@exemple.com
fi
