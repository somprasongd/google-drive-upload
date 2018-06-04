echo "Script Backup PostgreSQL"
echo "By Somprasong Damyos <somprasong.damyos@gmail.com>"
echo " Create Apr 4,2018"
pgHome=/var/lib/postgresql/10
pgPath=$pgHome/bin
echo -n "Please enter your database's name : ";read DB
#Backup
pgBak=/backup
mkdir -p $pgBak/GoogleDrive
cp google-oauth2.sh /backup/GoogleDrive
cp upload.sh /backup/GoogleDrive
cp uploadGG.sh /backup/GoogleDrive
cd $pgBak/GoogleDrive
echo "#!/bin/sh" > daily_GoogleDrive.sh
echo "/bin/rm -rf $pgBak/Daily/*.sql.gz" >> daily_GoogleDrive.sh
echo "$pgPath/pg_dump -U postgres $DB | gzip -9 > $pgBak/GoogleDrive/\$(date +%Y%m%d).sql.gz" >> daily_GoogleDrive.sh
echo "/bin/sh /backup/GoogleDrive/uploadGG.sh" >> daily_GoogleDrive.sh
chmod 755 *
chown postgres. $pgBak
echo "Database backup files are in : $pgBak"
echo "Run cd /backup/GoogleDrive/google-drive-upload-master/;./google-oauth2.sh"
echo "Run cd /backup/GoogleDrive/;./daily_GoogleDrive.sh"
echo "Create Crontab User postgres|00 21 * * * /backup/GoogleDrive/daily_GoogleDrive.sh"