#!/usr/bin/env bash

command -v docker-compose || (echo "Docker compose is required for this script." && exit 1);

# Run MySQL command as root
root_command() {
    _docker_file="${1:-..}/docker/docker-compose.yml";
    _cmd="${2:-SHOW DATABASES}";
    _db="${3:-}";

    docker-compose -f "${_docker_file}" run --rm -e "MYSQL_CMD=${_cmd}" -e "MYSQL_USER=root" -e "MYSQL_PWD=MangosDb" -e "MYSQL_DB=${_db}" db_exec;
}

# Run MySQL command as the user
user_command() {
    _docker_file="${1:-..}/docker/docker-compose.yml";
    _cmd="${2:-SHOW DATABASES}";
    _db="${3:-}";

    docker-compose -f "${_docker_file}" run --rm -e "MYSQL_CMD=${_cmd}" -e "MYSQL_DB=${_db}" db_exec;
}

export -f root_command;
export -f user_command;
###########################
##### Database server #####
###########################
docker_path="/opt/mangos0/database";
repo_path="${PWD%%docker}";

docker-compose -f "${repo_path}/docker/docker-compose.yml" up -d db

output="ERROR";

while [ "$( echo ${output} | grep -io error)" == "ERROR" ];
do
  echo "Waiting for DB to come up.";
  sleep 2;
  output=$( root_command "${repo_path}" );
done

#########################
##### Database user #####
#########################
if docker-compose -f "${repo_path}/docker/docker-compose.yml" run --rm -e "MYSQL_CMD=SHOW DATABASES" -e "MYSQL_DB=" db_exec;
then
    echo "User connection successful."
else
    echo "Creating database user"

    root_command "${repo_path}" "SOURCE ${docker_path}/user.sql" "";
    root_command "${repo_path}" "FLUSH PRIVILEGES" ""
fi

###########################
##### Realmd Database #####
###########################
root_command "${repo_path}" "SOURCE ${docker_path}/Realm/Setup/realmdCreateDB.sql" "" || echo "Realm DB already exists";
root_command "${repo_path}" "SOURCE ${docker_path}/Realm/Setup/realmdLoadDB.sql" "realmd"

import=( $( find "${repo_path}/Realm/Updates/Rel21" -maxdepth 1 -iname '*.sql' -printf "%f\n" ) );
if [ ! -z "${import}" ];
then
    for sql in "${import[@]}";
    do
        echo "Importing Realm update ${sql}";
        root_command "${repo_path}" "SOURCE ${docker_path}/Realm/Updates/Rel21/${sql}" "realmd";
    done
fi
import=( $( find "${repo_path}/Realm/Updates/Rel22" -maxdepth 1 -iname '*.sql' -printf "%f\n" ) );
if [ ! -z "${import}" ];
then
    for sql in "${import[@]}";
    do
        echo "Importing Realm update ${sql}";
        root_command "${repo_path}" "SOURCE ${docker_path}/Realm/Updates/Rel22/${sql}" "realmd";
    done
fi

##############################
##### Character Database #####
##############################
root_command "${repo_path}" "SOURCE ${docker_path}/Character/Setup/characterCreateDB.sql" "" || echo "Realm DB already exists";
user_command "${repo_path}" "SOURCE ${docker_path}/Character/Setup/characterLoadDB.sql" "character0"

import=( $( find "${repo_path}/Character/Updates/Rel21" -maxdepth 1 -iname '*.sql' -printf "%f\n" ) );
if [ ! -z "${import}" ];
then
    for sql in "${import[@]}";
    do
        echo "Importing Character update ${sql}";
        root_command "${repo_path}" "SOURCE ${docker_path}/Character/Updates/Rel21/${sql}" "character0";
    done
fi
import=( $( find "${repo_path}/Character/Updates/Rel22" -maxdepth 1 -iname '*.sql' -printf "%f\n" ) );
if [ ! -z "${import}" ];
then
    for sql in "${import[@]}";
    do
        echo "Importing Character update ${sql}";
        root_command "${repo_path}" "SOURCE ${docker_path}/Character/Updates/Rel22/${sql}" "character0";
    done
fi
# find "${repo_path}/Character/Updates/Rel21" -maxdepth 1 -iname '*.sql' -exec bash -c 'root_command "'${repo_path}'" "SOURCE $1" "character0"' _ {} \;

##########################
##### World Database #####
##########################
root_command "${repo_path}" "SOURCE ${docker_path}/World/Setup/mangosdCreateDB.sql" "" || echo "Realm DB already exists";
user_command "${repo_path}" "SOURCE ${docker_path}/World/Setup/mangosdLoadDB.sql" "mangos0"

import=( $( find "${repo_path}/World/Setup/FullDB" -maxdepth 1 -iname '*.sql' -printf "%f\n" ) );
if [ ! -z "${import}" ];
then
    for sql in "${import[@]}";
    do
        echo "Importing World Setup ${sql}";
        root_command "${repo_path}" "SOURCE ${docker_path}/World/Setup/FullDB/${sql}" "mangos0";
    done
fi
# find "${repo_path}/World/Setup/FullDB" -maxdepth 1 -iname '*.sql' -exec bash -c 'root_command "'${repo_path}'" "SOURCE $1" "mangos0"' _ {} \;

import=( $( find "${repo_path}/World/Updates/Rel21" -maxdepth 1 -iname '*.sql' -printf "%f\n" ) );
if [ ! -z "${import}" ];
then
    for sql in "${import[@]}";
    do
        echo "Importing World Update ${sql}";
        root_command "${repo_path}" "SOURCE ${docker_path}/World/Updates/Rel21/${sql}" "mangos0";
    done
fi
import=( $( find "${repo_path}/World/Updates/Rel22" -maxdepth 1 -iname '*.sql' -printf "%f\n" ) );
if [ ! -z "${import}" ];
then
    for sql in "${import[@]}";
    do
        echo "Importing World Update ${sql}";
        root_command "${repo_path}" "SOURCE ${docker_path}/World/Updates/Rel22/${sql}" "mangos0";
    done
fi
# find "${repo_path}/World/Updates/Rel21" -maxdepth 1 -iname '*.sql' -exec bash -c 'root_command "'${repo_path}'" "SOURCE $1" "mangos0"' _ {} \;
