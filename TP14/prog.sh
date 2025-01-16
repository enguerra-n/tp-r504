#!/bin/bash

# Vérifier si la tâche cron est déjà présente dans /etc/crontab
if grep -q "30 2 * * * /home/user/script/rech.sh" /etc/crontab; then
    echo "La tâche cron pour rech.sh est déjà présente."
else
    # Ajouter la tâche cron pour exécuter rech.sh tous les jours à 02h30
    (crontab -l ; echo "30 2 * * * /home/user/script/rech.sh") | crontab -
    echo "La tâche cron pour rech.sh a été ajoutée."
fi
