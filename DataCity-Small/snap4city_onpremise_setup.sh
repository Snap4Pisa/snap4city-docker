# Funzione che copia una sola volta il file
fcopy(){
if [ ! -z $3 ]
then
  echo "$3 is not null or space"
  if [ -e $2/$3/$4 ]
  then
    echo "file $4 esistente"
  else
    cp $1/$3/$4 $2/$3/$4
    echo "copiato file $4"
    sed -i 's/http:\/\/snap4city.aedit.it/https:\/\/'$domain'/g' $1/$3/$4
  fi
else
  echo "null 0"
  if [ -e $2/$4 ]
  then
    echo "file $4 esistente"
  else
    cp $1/$4 $2/$4
    echo "copiato file $4"
    sed -i 's/http:\/\/smart4city.aedit.it/https:\/\/'$domain'/g' $1/$4
  fi
fi
# sed -i 's/http:\/\/dashboard/http:\/\/'$domain'/g' $base_path/dashboard-builder-conf/sso.ini

}

#
# INIZIO SCRIPT
#

base_path=`pwd`
backup_path=$base_path/bck_snap4city2

domain="snap4city.aedit.it"
landingPageUrl="https://snap4city.aedit.it/"
claim="Snap4Pisa"

# crea la directory dove vengono salvati i file originali che saranno modificati dallo script
mkdir $backup_path 2> /dev/null

cd $backup_path
# crea tutte le directory
mkdir dashboard-backend-conf          2> /dev/null
mkdir dashboard-builder-conf          2> /dev/null
mkdir dashboard-cron-conf             2> /dev/null
mkdir iot-directory-conf              2> /dev/null
mkdir iotapp-nr1                      2> /dev/null
mkdir iotapp-nr2                      2> /dev/null
mkdir iotapp-nr3                      2> /dev/null
mkdir notificator-conf                2> /dev/null
mkdir orionbrokerfilter-conf          2> /dev/null
mkdir ownership-conf                  2> /dev/null
mkdir processloader-conf              2> /dev/null
mkdir servicemap-conf                 2> /dev/null
mkdir servicemap-iot-conf             2> /dev/null
mkdir servicemap-superservicemap-conf 2> /dev/null
mkdir synoptics-conf                  2> /dev/null

echo "lista delle dir:"
ls -la $backup_path
# effettua il backup dei file originali
fcopy $base_path $backup_path  "" "docker-compose.yml"
#
fcopy $base_path $backup_path  "dashboard-builder-conf" "sso.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "general.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "serviceMapAndTv.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "ownership.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "notificator.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "synoptics.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "iotApplications.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "personalData.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "webSocketServer.ini"
fcopy $base_path $backup_path  "dashboard-builder-conf" "kbHost.ini"
#
fcopy $base_path $backup_path  "iot-directory-conf" "general.ini"
fcopy $base_path $backup_path  "iot-directory-conf" "serviceURI.ini"
fcopy $base_path $backup_path  "iot-directory-conf" "sso.ini"
#
fcopy $base_path $backup_path  "notificator-conf" "conf.ini"
#
fcopy $base_path $backup_path  "ownership-conf" "config.php"
#
fcopy $base_path $backup_path  "processloader-conf" "config.php"
fcopy $base_path $backup_path  "processloader-conf" "external_service.php"
fcopy $base_path $backup_path  "servicemap-conf" "servicemap.properties"
#
fcopy $base_path $backup_path  "synoptics-conf" "config.js"
fcopy $base_path $backup_path  "synoptics-conf" "v2-config.js"
#
fcopy $base_path $backup_path  "iotapp-nr1" "settings.js"
fcopy $base_path $backup_path  "iotapp-nr2" "settings.js"
fcopy $base_path $backup_path  "iotapp-nr3" "settings.js"
#
#
# #
# # modifica il contenuto del database mysql
# #
#
# docker exec datacitysmall_dashboarddb_1 bash -c 'mysql -u user -ppasswordx -e "UPDATE Dashboard.Domains set domains=\"['$domain']\", landingPageUrl=\"'$landingPageUrl'\", claim=\"'$claim'\" WHERE id=2;"'
# docker exec datacitysmall_dashboarddb_1 bash -c 'mysql -u user -ppasswordx -e "UPDATE Dashboard.MainMenu SET linkUrl = REPLACE(linkUrl, \"http://dashboard\", \"http://'$domain'\") where linkUrl like \"http://dashboard%\""'
# docker exec datacitysmall_dashboarddb_1 bash -c 'mysql -u user -ppasswordx -e "UPDATE Dashboard.MainMenuSubmenus SET linkUrl = REPLACE(linkUrl, \"http://dashboard\", \"http://'$domain'\") where linkUrl like \"http://dashboard%\""'
# docker exec datacitysmall_dashboarddb_1 bash -c 'mysql -u user -ppasswordx -e "UPDATE Dashboard.MobMainMenu SET linkUrl = REPLACE(linkUrl, \"http://dashboard\", \"http://'$domain'\") where linkUrl like \"http://dashboard%\""'
# docker exec datacitysmall_dashboarddb_1 bash -c 'mysql -u user -ppasswordx -e "UPDATE Dashboard.MobMainMenuSubmenus SET linkUrl = REPLACE(linkUrl, \"http://dashboard\", \"http://'$domain'\") where linkUrl like \"http://dashboard%\""'
#
# docker exec datacitysmall_dashboarddb_1 bash -c 'mysql -u user -ppasswordx -e "UPDATE profiledb.ownership SET elementUrl = REPLACE(elementUrl, \"http://dashboard\", \"http://'$domain'\") where elementUrl like \"http://dashboard%\""'
#
