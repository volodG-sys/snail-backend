#!/bin/bash

# --- НАЛАШТУВАННЯ ---
BUCKET_NAME="fastsnail-media-2026"
# Дані бази даних
DB_HOST="fastsnail-db.c9y0s0maa19n.eu-central-1.rds.amazonaws.com"
DB_USER="vladg-codecommit"
DB_NAME="fastsnail_db"
export PGPASSWORD='qwerty1234'

# Формат імені файлу: db_backup_рікмісяцьдень_годинахвилинасекунда.sql
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="db_backup_$TIMESTAMP.sql"

echo "Розпочинаю створення бекапу бази $DB_NAME..."

# 1. Створення дампу бази (використовуємо pg_dump)
# -h (хост), -U (користувач), -d (база)
pg_dump -h $DB_HOST -U $DB_USER -d $DB_NAME > /tmp/$BACKUP_NAME

# 2. Відправка в S3 (використовуємо IAM Role сервера EC2)
# Ми кладемо файл у папку backups всередині бакета
echo "Завантажую файл $BACKUP_NAME у S3 бакет $BUCKET_NAME..."
aws s3 cp /tmp/$BACKUP_NAME s3://$BUCKET_NAME/backups/$BACKUP_NAME

# 3. Видалення тимчасового файлу з диска EC2
rm /tmp/$BACKUP_NAME

echo "Успішно! Бекап збережено в s3://$BUCKET_NAME/backups/"