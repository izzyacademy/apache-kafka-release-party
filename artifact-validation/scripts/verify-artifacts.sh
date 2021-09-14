#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SELF=$(cd $(dirname $0); pwd -P)/$(basename $0)

set -e
set -u
set -o pipefail

if [ $# -ne 1 ]; then
    echo "usage:"
    echo -e "\tverify-artifacts.sh"
    echo "example:"
    echo "verify-kafka-rc.sh [verify_signatures|verify_hash|verify_source]"
    exit 1
fi

set +e

for x in TMPDIR; do
    if [ -z ${!x} ]; then
        echo "Fatal exception! Missing required environment variable: $x"
        exit 1;
    fi
done

for x in wget gpg md5sum sha1sum sha512sum tr cut tar sed; do
    which $x >/dev/null
    if [ $? -ne 0 ]; then
        echo "Fatal exception! Missing required CLI utility $x">&2
        exit 1;
    fi
done

set -e

declare -r KEYS_URL='https://kafka.apache.org/KEYS'
declare -r WORKDIR="$TMPDIR/$$.out"
declare -r KEYS_FILE="$WORKDIR/keys.out"
declare -r VERSION="${PROJECT_KAFKA_VERSION}"
declare -r REMOTE_RELEASE_SITE="${PROJECT_DOWNLOAD_URL}"
declare -r CURRENT_SCALA_VERSION="${PROJECT_SCALA_VERSION}"
declare -r SCALA_HOME="/usr/local/software/scala-${CURRENT_SCALA_VERSION}"
declare -r GRADLE_HOME="/usr/local/software/gradle"

# Declaring Release Notes, Source Tar Ball, Site Docs for Specific Scala Version, Binaries for Specific Scala Version
declare -r FILES=RELEASE_NOTES.html\ kafka-$VERSION-src.tgz\ kafka_$CURRENT_SCALA_VERSION-$VERSION-site-docs.tgz\ kafka_$CURRENT_SCALA_VERSION-$VERSION.tgz

mkdir -p $WORKDIR
echo "Working Directory: $WORKDIR"

export PATH="$GRADLE_HOME/bin:$SCALA_HOME/bin:$PATH"

function download_artifacts {

    echo "Downloading release files"
    echo ""
    for x in $FILES; do
        echo -e "\t$x"
        wget -q $REMOTE_RELEASE_SITE/$x -O $WORKDIR/$x
        for y in asc md5 sha1 sha512; do
            echo -e "\t$x.$y"
            wget -q $REMOTE_RELEASE_SITE/$x.$y -O $WORKDIR/$x.$y
        done
    done
}

function verify_signatures {

    download_artifacts

    echo "Downloading signing keys"
    wget -q $KEYS_URL -O $KEYS_FILE

    echo "Importing PGP signing keys"
    gpg --import "$KEYS_FILE"

    echo "List PGP keys and fingerprints"
    gpg --fingerprint

    echo "Verifying PGP signatures"
    echo "Make sure that the fingerprint for the signer is a match!"
    for x in $FILES; do
        gpg --verify $WORKDIR/$x.asc
    done
}

function verify_hash {

    download_artifacts

    echo "Verifying Cryptographic Hashes"

    for x in md5 sha1 sha512; do
        util=${x}sum
        echo ""
        echo "Verifying ${x}sums"
        echo ""
        for y in $FILES; do
            sum=$(cat $WORKDIR/$y.$x | tr -d '\n' | cut -d':' -f2- | sed -e 's/ //g')
            echo "$sum $WORKDIR/$y" >$WORKDIR/$y.$x.normalized
            $util -c $WORKDIR/$y.$x.normalized
        done
    done
}

function verify_source {

    download_artifacts

    echo "Verifying kafka source tree"
    pushd $WORKDIR >/dev/null
    tar zxf kafka-$VERSION-src.tgz
    pushd $WORKDIR/kafka-$VERSION-src >/dev/null
    echo -e "Invoking Gradle"
    gradle
    for x in srcJar javadoc javadocJar scaladoc scaladocJar docsjar unitTest integrationTest; do
        echo ""
        echo -e "\tBuilding $x"
        echo ""
        ./gradlew $x
    done
    popd >/dev/null
    popd >/dev/null
}

case "${1:-''}" in
  'verify_signatures')
        verify_signatures
        ;;

  'verify_hash')
        verify_hash
        ;;

  'verify_source')
        verify_source
        ;;
    *)
        echo "Usage: $SELF [verify_signatures|verify_hash|verify_source]"
        exit 1
        ;;
esac

exit 0