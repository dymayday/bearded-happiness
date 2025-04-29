#!/bin/bash

BACKUP_DIR="/System/Volumes/Data/Volumes/X9Pro/backup"
7z a $BACKUP_DIR/macbook-pro-backup_$(date '+%F').7z ~/Documents -p
e $BACKUP_DIR
