#!/bin/bash 
# Copyright 2019 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIGMAPS=(
    pgo-config
)

DEPLOYMENTS=(
    postgres-operator
)

SECRETS=(
    pgo-backrest-repo-config
    pgo.tls
)

SERVICES=(
    postgres-operator
)

for cm in "${CONFIGMAPS[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get configmaps ${cm?} 2> /dev/null
    if [[ $? -eq 0 ]]
    then
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete configmap ${cm?}
    fi
done

for deployment in "${DEPLOYMENTS[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get deployments ${deployment?} 2> /dev/null
    if [[ $? -eq 0 ]]
    then
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete deployment ${deployment?}
    fi
done

for secret in "${SECRETS[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get secrets ${secret?} 2> /dev/null
    if [[ $? -eq 0 ]]
    then
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete secret ${secrets?}
    fi
done

for service in "${SERVICES[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get services ${service?} 2> /dev/null
    if [[ $? -eq 0 ]]
    then
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete service ${service?}
    fi
done

sleep 5
