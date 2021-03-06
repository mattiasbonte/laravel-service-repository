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

# Model Input
echo "================================================================"
echo "Input MODEL name:"
read -e -p "=> " MODEL_SINGULAR
MODEL_lower_singular=$(perl -ne 'print lcfirst' <<<"$MODEL_SINGULAR")
MODEL_Upper_singular=$(perl -ne 'print ucfirst' <<<"$MODEL_SINGULAR")

# Service Prompt
echo "================================================================"
while true; do
    read -p "Make a service? [y/n]:" yn
    case $yn in
        [Yy]* ) echo "Input SERVICE name:"
                read -e -p "=> " SERVICE_SINGULAR
                SERVICE_lower_singular=$(perl -ne 'print lcfirst' <<<"$SERVICE_SINGULAR")
                SERVICE_Upper_singular=$(perl -ne 'print ucfirst' <<<"$SERVICE_SINGULAR")
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
        [Yy]* ) echo "Input REPOSITORY name:"
                read -e -p "=> " REPO_SINGULAR
                REPO_lower_singular=$(perl -ne 'print lcfirst' <<<"$REPO_SINGULAR")
                REPO_Upper_singular=$(perl -ne 'print ucfirst' <<<"$REPO_SINGULAR")
                break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no [y/n].";;
    esac
done

# Function Input
echo "================================================================"
echo "Input placeholder FUNCTION name:"
read -e -p "=> " FUNC_SINGULAR
FUNC_lower_singular=$(perl -ne 'print lcfirst' <<<"$FUNC_SINGULAR")
FUNC_Upper_singular=$(perl -ne 'print ucfirst' <<<"$FUNC_SINGULAR")



###########
# SERVICE #
###########

# Make if not exist
if [ $SERVICE_SINGULAR ] ; then
echo "================================================================"
    $EXEC mkdir -p "${WORK_DIR}/app/Services/${MODEL_Upper_singular}"
    if [ "$($EXEC test -f ${WORK_DIR}/app/Services/${MODEL_Upper_singular}/${SERVICE_Upper_singular}Service.php && echo 1 || echo 0)" == "0" ]; then
        $EXEC touch "${WORK_DIR}/app/Services/${SERVICE_Upper_singular}Service.php" || exit
        docker cp service/Service.php $CONTAINER:${WORK_DIR}/app/Services/${SERVICE_Upper_singular}Service.php
        $EXEC sed -i "s+MODEL_Upper_singular+${MODEL_Upper_singular}+g" ${WORK_DIR}/app/Services/${SERVICE_Upper_singular}Service.php
        $EXEC sed -i "s+SERVICE_Upper_singular+${SERVICE_Upper_singular}+g" ${WORK_DIR}/app/Services/${SERVICE_Upper_singular}Service.php
        $EXEC sed -i "s+REPO_Upper_singular+${REPO_Upper_singular}+g" ${WORK_DIR}/app/Services/${SERVICE_Upper_singular}Service.php
        $EXEC sed -i "s+REPO_lower_singular+${REPO_lower_singular}+g" ${WORK_DIR}/app/Services/${SERVICE_Upper_singular}Service.php
        $EXEC sed -i "s+FUNC_lower_singular+${FUNC_lower_singular}+g" ${WORK_DIR}/app/Services/${SERVICE_Upper_singular}Service.php
        echo "${SERVICE_Upper_singular}Service Created..."
    else
        echo "${SERVICE_Upper_singular}Service.php already exists, skipping..."
    fi
fi



##########################
# REPOSITORY & INTERFACE #
##########################

# Make if not exist
if [ $REPO_SINGULAR ] ; then
    echo "================================================================"
    $EXEC mkdir -p "${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}"
    if [ "$($EXEC test -f ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Repository.php && echo 1 || echo 0)" == "0" ]; then
        $EXEC touch "${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Repository.php"
        docker cp repository/Repository.php $CONTAINER:${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Repository.php
        $EXEC sed -i "s+MODEL_Upper_singular+${MODEL_Upper_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Repository.php
        $EXEC sed -i "s+REPO_Upper_singular+${REPO_Upper_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Repository.php
        $EXEC sed -i "s+REPO_lower_singular+${REPO_lower_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Repository.php
        $EXEC sed -i "s+FUNC_lower_singular+${FUNC_lower_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Repository.php
        echo "${REPO_Upper_singular}Repository Created..."
    else
        echo "${REPO_Upper_singular}Repository.php already exists, skipping..."
    fi

    echo "================================================================"
    if [ "$($EXEC test -f ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Interface.php && echo 1 || echo 0)" == "0" ]; then
        $EXEC touch "${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Interface.php"
        docker cp repository/Interface.php $CONTAINER:${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Interface.php
        # Adapt Interface
        $EXEC sed -i "s+MODEL_Upper_singular+${MODEL_Upper_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Interface.php
        $EXEC sed -i "s+REPO_Upper_singular+${REPO_Upper_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Interface.php
        $EXEC sed -i "s+REPO_lower_singular+${REPO_lower_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Interface.php
        $EXEC sed -i "s+FUNC_lower_singular+${FUNC_lower_singular}+g" ${WORK_DIR}/app/Repositories/${MODEL_Upper_singular}/${REPO_Upper_singular}Interface.php
        # Adapt AppServiceProvider
        $EXEC perl -0777pi -e 's+namespace App\\Providers;\s*+namespace App\\Providers;\n\nuse App\\Repositories\\MODEL_Upper_singular\\REPO_Upper_singularInterface;\nuse App\\Repositories\\MODEL_Upper_singular\\REPO_Upper_singularRepository;\n+gm' ${WORK_DIR}/app/Providers/AppServiceProvider.php
        $EXEC perl -0777pi -e 's+public function register\(\)\s*\{+public function register()\n    \{\n        \$this->app->bind(REPO_Upper_singularInterface::class, REPO_Upper_singularRepository::class);+gm' ${WORK_DIR}/app/Providers/AppServiceProvider.php
        $EXEC sed -i "s+MODEL_Upper_singular+${MODEL_Upper_singular}+g" ${WORK_DIR}/app/Providers/AppServiceProvider.php
        $EXEC sed -i "s+REPO_Upper_singular+${REPO_Upper_singular}+g" ${WORK_DIR}/app/Providers/AppServiceProvider.php
        echo "${REPO_Upper_singular}Interface created and binding added in AppServiceProvider."
    else
        echo "${REPO_Upper_singular}Interface.php already exists, skipping..."
    fi
fi



###########
# ARTISAN #
###########

# Make if not exist
echo "================================================================"
if [ "$($EXEC test -f ${WORK_DIR}/app/Models/${MODEL_Upper_singular}.php && echo 1 || echo 0)" == "0" ]; then

    while true; do
    read -p "Add a MODEL? [y/n]:" yn
        case $yn in
            [Yy]* ) $EXEC php artisan make:model ${MODEL_Upper_singular}
                    break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no [y/n].";;
        esac
    done

    while true; do
    read -p "Add an API CONTROLLER? [y/n]:" yn
        case $yn in
            [Yy]* ) $EXEC php artisan make:controller ${MODEL_Upper_singular}Controller --api --model=${MODEL_Upper_singular}
                    $EXEC perl -0777pi -e "s+\<\?php\s*+\<\?php\n\nuse App\\\Http\\\Controllers\\\\${MODEL_Upper_singular}Controller;\n+gm" ${WORK_DIR}/routes/api.php
                    $EXEC sed -i "s+//ROUTE_PLACEHOLDER+Route::apiResource('PLACEHOLDER', ${MODEL_Upper_singular}Controller::class);\n        //ROUTE_PLACEHOLDER+" ${WORK_DIR}/routes/api.php
                    break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no [y/n].";;
        esac
    done

    while true; do
    read -p "Add a REQUEST? [y/n]:" yn
        case $yn in
            [Yy]* ) $EXEC php artisan make:request ${MODEL_Upper_singular}Request
                    break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no [y/n].";;
        esac
    done

    while true; do
    read -p "Add a RESOURCE? [y/n]:" yn
        case $yn in
            [Yy]* ) $EXEC php artisan make:resource ${MODEL_Upper_singular}Resource
                    break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no [y/n].";;
        esac
    done
else
    echo "Model ${MODEL_Upper_singular}.php already exists, skipping..."
fi



###########
# MESSAGE #
###########

echo "================================================================"
echo "File generation complete :)"
