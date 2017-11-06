#!/bin/bash
set -eu
export TERM=xterm
# Bash Colors
green=`tput setaf 2`
bold=`tput bold`
reset=`tput sgr0`
# Functions
log() {
  if [[ "$@" ]]; then echo "${bold}${green}[VSFTPD `date +'%T'`]${reset} $@";
  else echo; fi
}

# Uploaded files world readable settings
if [ "${UPLOADED_FILES_WORLD_READABLE}" = "true" ]; then
  sed -i "s|local_umask=077|local_umask=022|g" /etc/vsftpd/vsftpd.conf
  log "Uploaded files will become world readable."
fi

# update passive ports settings
if [ -n "${PASV_MIN_PORT}" ] && [ -n "${PASV_MAX_PORT}" ]; then
  sed -i "s|pasv_min_port=.*|pasv_min_port=${PASV_MIN_PORT}|g" /etc/vsftpd/vsftpd.conf
  sed -i "s|pasv_max_port=.*|pasv_max_port=${PASV_MAX_PORT}|g" /etc/vsftpd/vsftpd.conf
  log "Passive ports will advertise : ${PASV_MIN_PORT}-${PASV_MAX_PORT}"
fi

# Create home dir and update vsftpd user db:
mkdir -p "/home/ftp"
log "Created home directory"

log "create vuser ..."
/usr/sbin/vsftpd_vusers.sh

# Get log file path
export LOG_FILE=`grep ^xferlog_file /etc/vsftpd/vsftpd.conf|cut -d= -f2`

# Set permissions for FTP user
chown -R ftp:ftp /home/ftp/

log "VSFTPD daemon starting"
# Run vsftpd:
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
