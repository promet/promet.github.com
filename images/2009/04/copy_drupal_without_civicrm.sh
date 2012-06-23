#!/bin/bash
#    PURPOSE  : copy drupal installation to new cpanel account
#    PARAMS   : cp_usename cp_dbname cp_dbuser cp_dbpass cp_domain
#    WEBSITE  : Promethost.com
#    NOTES    : Initial version, no strict filters/validations on parameters
#               Applicable and tested on CPANEL servers.  You can adjust the paths if you need to use on PLESK servers

# Test number of cli arguments
if [ $# != 5 ]; then
    echo "ERROR: param count does not match"
    exit 0
fi

# Check home directory of given or destination cp_username if it exist
if [ ! -d "/home/$1" ]; then
    echo "ERROR: Environment does not exist for $1"
    exit 0
fi

# Assign parameters to variables.  You can just use the $1 $2 if you want less line of codes.
DESTINATION_cp_usename=$1
DESTINATION_cp_dbname=$2
DESTINATION_cp_dbuser=$3
DESTINATION_cp_dbpass=$4
DESTINATION_cp_domain=$5

#  Supply the info of the SOURCE Drupal installation
drupal_username=SOURCE_CPANEL_USERNAME
drupal_dbname=SOURCE_DRUPAL_DB_NAME
drupal_dbuser=SOURCE_DB_USER
drupal_dbpass=SOURCE_DB_PASS
# full domain or subdomain of SOURCE drupal installation
drupal_domain=DOMAIN.TLD
TIME_STAMP=`date +%Y%m%d%H%M%S`
# Email address to receive logs, separate address with comma
MAIL_LIST="admin@domain.com"
BACKUP_DIR="/full/path/to/backups"
LOG_FILE=${BACKUP_DIR}/copydrupal-${DESTINATION_cp_usename}.${TIME_STAMP}.log

# add details to log file
echo "********** S T A R T   O F   R U N - (`date +%Y%m%d%H%M%S`) ************" >> $LOG_FILE
echo "         SCRIPT :  copy_drupal.sh "                                       >> $LOG_FILE
echo "       SITENAME :  ${DESTINATION_cp_usename}"                             >> $LOG_FILE
echo "       LOG FILE :  $LOG_FILE"                                             >> $LOG_FILE
echo "           DATE :  ${TIME_STAMP}"                                         >> $LOG_FILE
cat ${LOG_FILE}

# copy files from drupal installs to new account, update owner/group
cp -vpr /home/${drupal_username}/public_html/*  /home/${DESTINATION_cp_usename}/public_html/  >> $LOG_FILE
cp -vp /home/${drupal_username}/public_html/.htaccess  /home/${DESTINATION_cp_usename}/public_html/  >> $LOG_FILE
chown -R ${DESTINATION_cp_usename}:${DESTINATION_cp_usename} /home/${DESTINATION_cp_usename}/public_html/*  >> $LOG_FILE
chmod 777 /home/${DESTINATION_cp_usename}/public_html/sites/default/files >> $LOG_FILE

# create sql dump of source Drupal install
mysqldump -Q -u${drupal_dbuser} -p${drupal_dbpass} ${drupal_dbname} > ${BACKUP_DIR}/${drupal_dbname}.${TIME_STAMP}.sql
# update referrences to domain name
perl -pi -e "s/${drupal_domain}/${DESTINATION_cp_domain}/g" ${BACKUP_DIR}/${drupal_dbname}.${TIME_STAMP}.sql
# update referrences to path and cpanel username
perl -pi -e "s/${drupal_username}/${DESTINATION_cp_usename}/g" ${BACKUP_DIR}/${drupal_dbname}.${TIME_STAMP}.sql
# import updated sql dump to new cpanel account
mysql -u${DESTINATION_cp_dbuser} -p${DESTINATION_cp_dbpass} ${DESTINATION_cp_dbname} < ${BACKUP_DIR}/${drupal_dbname}.${TIME_STAMP}.sql

# update configs and other files with referrence to source Drupal account
find /home/${DESTINATION_cp_usename}/public_html -type f -exec perl -pi -e "s/${drupal_domain}/${DESTINATION_cp_domain}/g" {} \;
find /home/${DESTINATION_cp_usename}/public_html -type f -exec perl -pi -e "s/${drupal_dbpass}/${DESTINATION_cp_dbpass}/g" {} \;
find /home/${DESTINATION_cp_usename}/public_html -type f -exec perl -pi -e "s/${drupal_dbuser}/${DESTINATION_cp_dbuser}/g" {} \;
find /home/${DESTINATION_cp_usename}/public_html -type f -exec perl -pi -e "s/${drupal_dbname}/${DESTINATION_cp_dbname}/g" {} \;
find /home/${DESTINATION_cp_usename}/public_html -type f -exec perl -pi -e "s/${drupal_username}/${DESTINATION_cp_usename}/g" {} \;

#  send process logs to sysadmins
echo "*********** E N D   O F   R U N - (`date +%Y%m%d%H%M%S`) ***************" >> $LOG_FILE
cat $LOG_FILE | mail -s "Copy Drupal Site: ${drupal_domain} -> ${DESTINATION_cp_domain}" ${MAIL_LIST}
echo "PROCESS COMPLETED."
