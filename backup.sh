#!/bin/bash

BACKUP_SOURCE="/var/opt/gitlab/backups"  # Путь к архиву с бекапом
BACKUP_DEST1="/mnt/gitlab/backups/" # Путь к папке для бекапов
BACKUP_DEST2="/mnt/gitlab/config_backups/"  # Путь к папке для конфигов и секретов
SECRET_CONFIG_FILE="/etc/gitlab/config_backup"              # Путь к файлу с секретами и к конфигу
MAX_BACKUPS=5              

if find "$BACKUP_DEST1" -maxdepth 1 -type d -name "backups" > /dev/null 2>&1 && find "$BACKUP_DEST2" -maxdepth 1 -type d -name "config_backup" > /dev/null 2>&1; then
	echo "Обе директории найдены."
else
	echo "Одна или обе директрии не найдены."
	exit 1
fi

if [ "$(find "$BACKUP_SOURCE" -maxdepth 1 -type f -name "*.tar" | wc -l)" -gt 0 ]; then
	echo "Файлы бекапа найдены. Копирование запущено..."
	mv "$BACKUP_SOURCE"/*.tar "$BACKUP_DEST1"
else
	echo "Файлы бекапа не найдены."
fi

cd "$BACKUP_DEST1"
 
BACKUP_COUNT=$(find "$BACKUP_DEST1" -maxdepth 1 -type f -name "*.tar" | wc -l)     #-maxdepth 1: Этот параметр ограничивает глубину поиска. Значение 1 означает, что команда find будет искать только в самой папке "$BACKUP_DEST1" и не будет заходить в подкаталоги. type -f - ищет только файлы.

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
	echo "Слишком много файлов. Удаление старых бекапов..."
	ls -t | tail -n +$(($MAX_BACKUPS + 1)) | xargs rm -f
fi

echo "---------------------------------------------------------------"


if [ "$(find "$SECRET_CONFIG_FILE" -maxdepth 1 -type f -name "*.tar" | wc -l)" -gt 0 ]; then
	echo "Бекапы конфигурационных файлов найдены. Копирование запущено..."
	mv "$SECRET_CONFIG_FILE"/*.tar "$BACKUP_DEST2"
else
	echo "Конфигурационные бекапы не найдены."
fi

cd "$BACKUP_DEST2"

BACKUP_COUNT=$(find "$BACKUP_DEST2" -maxdepth 1 -type f -name "*.tar" | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
	echo "Слишком много файлов. Удаление старых конфиг файлов..."
	ls -t | tail -n +$(($MAX_BACKUPS + 1)) | xargs rm -f
fi



