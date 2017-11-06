#!/bin/bash
vsftpd_pwd_file="/etc/vsftpd/vusers.db"
vsftpd_vusers_file="/etc/vsftpd/vusers.txt"

VUSERS_JSON_FILE="/config/vusers.json"

get_vuser_list()
{
  echo `cat $VUSERS_JSON_FILE | jq '.[].username'`
}

get_vuser_options()
{
  VUSER=$1
  echo `cat $VUSERS_JSON_FILE | jq ".[] | select(.username == $VUSER) | .options[]"`
}

get_vuser_password()
{
  VUSER=$1
  echo `cat $VUSERS_JSON_FILE | jq ".[] | select(.username == $VUSER) | .password"`
}

get_vuser_workspace()
{
  VUSER=$1
  echo `cat $VUSERS_JSON_FILE | jq ".[] | select(.username == $VUSER) | .workspace"`
}

VUSER_LIST=`get_vuser_list`
mkdir -p /etc/vsftpd/vusers_config
for vuser in $VUSER_LIST; do
  VUSER_PASS=`get_vuser_password $vuser`
  VUSER_OPTIONS=`get_vuser_options $vuser`
  echo "--//INFO: create vuser: ${vuser//\"} info..."
  echo -e "${vuser//\"}\n${VUSER_PASS//\"}" >> $vsftpd_vusers_file
  /usr/bin/db_load -T -t hash -f $vsftpd_vusers_file $vsftpd_pwd_file

  echo "--//INFO: create vuser: ${vuser//\"} config..."
  for vuser_opt in $VUSER_OPTIONS; do
    echo -e ${vuser_opt//\"} >> /etc/vsftpd/vusers_config/${vuser//\"}
  done

  VUSER_WORKSPACE=`get_vuser_workspace $vuser`

  if [ -n "$VUSER_WORKSPACE" ]; then
    mkdir -p ${VUSER_WORKSPACE//\"}
    chown -R ftp:ftp ${VUSER_WORKSPACE//\"}
  else
    mkdir -p /home/ftp/${vuser//\"}
  fi

done

echo "--//INFO: update permission"
chown -R ftp:ftp /home/ftp

