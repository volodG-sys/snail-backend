#!/bin/bash

# --- НАЛАШТУВАННЯ (Згідно з settings.py) ---
BUCKET_NAME="fastsnail-media-2026"
DB_HOST="fastsnail-db.c9y0s0maa19n.eu-central-1.rds.amazonaws.com"
DB_USER="postgres"
DB_NAME="fastsnailbet"
export PGPASSWORD='qwerty1234'

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="db_backup_$TIMESTAMP.sql"

echo "Розпочинаю створення бекапу бази $DB_NAME..."

# Виконуємо дамп
pg_dump -h $DB_HOST -U $DB_USER -d $DB_NAME > /tmp/$BACKUP_NAME

# Завантажуємо в S3
aws s3 cp /tmp/$BACKUP_NAME s3://$BUCKET_NAME/backups/$BACKUP_NAME

# Видаляємо тимчасовий файл
rm /tmp/$BACKUP_NAME

echo "Успішно! Бекап збережено в s3://$BUCKET_NAME/backups/"
