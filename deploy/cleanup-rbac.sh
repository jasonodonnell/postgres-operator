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

CLUSTER_ROLES=(
    pgopclusterrole
    pgopclusterrolesecret
    pgopclusterrolecrd
)

CLUSTER_ROLE_BINDINGS=(
    pgopclusterbinding-${PGO_OPERATOR_NAMESPACE?}
    pgopclusterbindingesecret-${PGO_OPERATOR_NAMESPACE?}
    pgopclusterbindingcrd-${PGO_OPERATOR_NAMESPACE?}
)

ROLES=(
    pgo-role
    pgo-backrest-role
)

ROLE_BINDINGS=(
    pgo-role-binding-${PGO_OPERATOR_NAMESPACE?}
    pgo-backrest-role-binding-${PGO_OPERATOR_NAMESPACE?}
)

SERVICE_ACCOUNTS=(
    postgres-operator
    pgo-backrest
)

echo "Deleting cluster roles.."
for cr in "${CLUSTER_ROLES[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get clusterrole ${cr?} 2>&1 /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "Cluster role ${cr?} found.  Deleting.."
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete clusterrole ${cr?}
    fi
done

echo "Deleting cluster role bindings.."
for crb in "${CLUSTER_ROLE_BINDINGS[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get clusterrolebindings ${crb?} 2>&1 /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "Cluster role binding ${crb?} found.  Deleting.."
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete clusterrolebinding ${crb?}
    fi
done

echo "Deleting roles.."
for role in "${ROLES[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get role ${role?} 2>&1 /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "Role ${role?} found.  Deleting.."
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete role ${role?}
    fi
done

echo "Deleting role bindings.."
for rb in "${ROLE_BINDINGS[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get rolebindings ${rb?} 2>&1 /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "Role binding ${rb?} found.  Deleting.."
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete rolebinding ${rb?}
    fi
done

echo "Deleting service accounts.."
for sa in "${SERVICE_ACCOUNTS[@]}"
do
    ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} get serviceaccounts ${sa?} 2>&1 /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "Service account ${sa?} found.  Deleting.."
        ${PGO_CMD?} --namespace=${PGO_OPERATOR_NAMESPACE?} delete serviceaccount ${sa?}
    fi
done
