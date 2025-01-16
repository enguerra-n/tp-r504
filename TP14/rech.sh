#!/bin/bash

LOG_FILE="/var/log/vul.log"
HISTORY_DIR="/var/log/vul_hist"
EMAIL_ALERT="admin@example.com"
SEUIL_CRITIQUE=5  # Seuil de vul crit
SEUIL_TOTAL=10    # Seuil total de vul

#check si fichier d'alerte existe
mkdir -p "$HISTORY_DIR"

RESULTS=$(debsecan)

# Nombre total de vul
TOTAL_CVES=$(echo "$RESULTS" | wc -l)

# Nombre de vul crit
CRITICAL_CVES=$(echo "$RESULTS" | grep -i 'critical' | wc -l)

# Enregistrer la sortie dans le log avec timestamp
echo "[$(date)] - Total: $TOTAL_CVES, Critiques: $CRITICAL_CVES" >> "$LOG_FILE"

DATE=$(date +'%Y-%m-%d_%H-%M-%S')


# Si le nombre total de vulnérabilités dépasse le seuil
if [ "$TOTAL_CVES" -ge "$SEUIL_TOTAL" ]; then
	echo "trop de vul" | sendmail -s nb_vul admin@exemple.com
fi

# Si le nombre de vulnérabilités critiques dépasse le seuil
if [ "$CRITICAL_CVES" -ge "$SEUIL_CRITIQUE" ]; then
	echo "trop de vul crit " | sendmail -s nb_vul_crit admin@exemple.com
fi

