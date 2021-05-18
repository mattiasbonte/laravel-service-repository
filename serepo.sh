#!/bin/bash
#############
# VARIABLES #
#############
CONTAINER="api.guideline.xcs"
EXEC="docker exec -it $CONTAINER" # Docker (leave empty without docker)
WORK_DIR="/app"

##############
# USER INPUT #
##############
# Service Prompt
echo "================================================================"
while true; do
    read -p "Make a service? [y/n]:" yn
    case $yn in
        [Yy]* ) echo "Input service name, singular & plural:"
                read -e -p "Singular:" SERV_SINGULAR
                SERV_lower_singular=$(perl -ne 'print lc' <<<"$SERV_SINGULAR")
                SERV_Upper_singular=$(perl -ne 'print ucfirst' <<<"$SERV_lower_singular")
                break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no [y/n].";;
    esac
done

# Repository Prompt
echo "================================================================"
while true; do
    read -p "Make a repository? [y/n]:" yn
    case $yn in
        [Yy]* ) echo "Input repository name, singular & plural:"
                read -e -p "Singular:" REPO_SINGULAR
                REPO_lower_singular=$(perl -ne 'print lc' <<<"$REPO_SINGULAR")
                REPO_Upper_singular=$(perl -ne 'print ucfirst' <<<"$REPO_lower_singular")
                break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no [y/n].";;
    esac
done

###############
# COPY & EDIT #
###############
# Service
if [ $SERV_SINGULAR ] ; then
    echo "================================================================"
    if [[ ! $EXEC -e ${WORK_DIR}/app/Services ]]; then
        echo "foef"
    fi

    # echo "Copy ${SERV_Upper_singular}Service"
    # docker cp service/Service.php $CONTAINER:${WORK_DIR}/app/Services/${SERV_Upper_singular}/${SERV_Upper_singular}Service.php
    # echo "Fill ${SERV_Upper_singular}Service"
    # $EXEC sed -i "s+SERV_Upper_singular+${SERV_Upper_singular}+g" ${WORK_DIR}/app/Services/${SERV_Upper_singular}/${SERV_Upper_singular}Service.php
    # $EXEC sed -i "s+SERV_lower_singular+${SERV_lower_singular}+g" ${WORK_DIR}/app/Services/${SERV_Upper_singular}/${SERV_Upper_singular}Service.php
fi
