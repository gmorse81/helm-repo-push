#!/usr/bin/env bash

helm init --client-only
helm repo add ${PLUGIN_REPO_NAME} ${HELM_REPO_URL}
echo ${UPDATE_DEPENDENCIES}
if [ "${UPDATE_DEPENDENCIES}" = "false" ]; then
  helm package --version=$(cat .tags) --app-version=$(cat .tags) --save=false ${PLUGIN_CHART_SUBDIR}/.
else
  helm package -u --version=$(cat .tags) --app-version=$(cat .tags) --save=false ${PLUGIN_CHART_SUBDIR}/.
fi
RESPONSE=$(curl --data-binary "@${PLUGIN_CHART_SUBDIR}-$(cat .tags).tgz" ${HELM_REPO_URL}/api/charts)
echo $RESPONSE
if [ $RESPONSE = '{"saved":true}' ]; then
  exit 0
else
  exit 1
fi
