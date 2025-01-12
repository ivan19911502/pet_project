#!/bin/bash

BACKUP_SOURCE="/var/opt/gitlab/backups"  # Путь к архиву с бекапом
BACKUP_DEST1="/mnt/gitlab/backups/" # Путь к папке для бекапов
BACKUP_DEST2="/mnt/gitlab/config_backups/"  # Путь к папке для конфигов и секретов
SECRET_CONFIG_FILE="/etc/gitlab/config_backup"              # Путь к файлу с секретами и к конфигу
MAX_BACKUPS=5              

if ls -la "$BACKUP_SOURCE"/*.tar > /dev/null 2>&1; then
	echo "Файлы бекапа найдены. Копирование запущено..."
	mv /var/opt/gitlab/backups/*.tar /mnt/gitlab/backups/
else
	echo "Файлы бекапа не найдены."
fi


cd "$BACKUP_DEST1"
BACKUP_COUNT=$(ls -1 | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
	echo "Слишком много файлов. Удаление старых бекапов..."
	ls -t | tail -n +$(($MAX_BACKUPS + 1)) | xargs rm -f
fi

echo "---------------------------------------------------------------"


if ls -la "$SECRET_CONFIG_FILE"/*.tar > /dev/null 2>&1; then
	echo "Бекапы конфигурационных файлов найдены. Копирование запущено..."
	mv /etc/gitlab/config_backup/*.tar /mnt/gitlab/config_backups/
else
	echo "Конфигурационные бекапы не найдены."
fi

cd "$BACKUP_DEST2"
BACKUP_COUNT=$(ls -1 | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
	echo "Слишком много файлов. Удаление старых конфиг файлов..."
	ls -t | tail -n +$(($MAX_BACKUPS + 1)) | xargs rm -f
fi



