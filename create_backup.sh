echo "Script Backup PostgreSQL"
echo "By Somprasong Damyos <somprasong.damyos@gmail.com>"
echo " Create Apr 4,2018"
PG_HOME=/var/lib/postgresql/10
PG_BIN=$PG_HOME/bin
echo -n "Please enter your database's host : ";read DB_HOST
echo -n "Please enter your database's port : ";read DB_PORT
echo -n "Please enter your database's username : ";read DB_USER
echo -n "Please enter your database's password : ";read DB_PWD
echo -n "Please enter your database's name : ";read DB_NAME
echo -n "Please enter your google drive backup directory : ";read GG_BACKUP
#Backup
BACKUP_DIR=~/backup
mkdir -p $BACKUP_DIR
cp google-oauth2.sh $BACKUP_DIR
cp upload.sh $BACKUP_DIR
cp start.sh $BACKUP_DIR
cd $BACKUP_DIR
echo "#!/bin/sh" > daily_backup.sh
echo "/bin/rm -rf $BACKUP_DIR/daily/*.sql.gz" >> daily_backup.sh
echo "$PG_BIN/pg_dump -U $DB_USER -h $DB_HOST -p $DB_PORT $DB_NAME | gzip -9 > $BACKUP_DIR/daily/\$(date +%Y%m%d).sql.gz" >> daily_backup.sh
echo "/bin/sh $BACKUP_DIR/upload.sh $BACKUP_DIR/daily/*.sql.gz $GG_BACKUP" >> daily_backup.sh
chmod 755 *
chown $DB_USER $BACKUP_DIR
echo "Database backup files are in : $BACKUP_DIR/daily"
echo "Next step:"
echo "Run cd $BACKUP_DIR;./google-oauth2.sh"
echo "Run cd $BACKUP_DIR;./daily_backup.sh"
echo "And create crontab User $DB_USER|23 30 * * * $BACKUP_DIR/daily_backup.sh"