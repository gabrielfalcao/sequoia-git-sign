#!/usr/bin/env bash
prefix="gabrielfalcao"
owner_name="Gabriel Falcão"
owner_email=gabriel@nacaolivre.org

expires_in=6m # or 2y or 2m or never

cypher_suite=rsa4k # or rsa3k or rsa4k cv25519
basename="${prefix}_${cypher_suite}"
key_file="${basename}.pgp"
revocation_cert_file="${key_file}.rev"
cert_file="${basename}.cert.pgp"

set -x
if [ ! -e "${key_file}" ]; then
    sq key generate --can-sign \
       --cipher-suite  \
       --expires-in ${expires_in} \
       --userid "${owner_name} <${owner_email}>" \
       --export ${key_file}
fi
chmod 0600 ${key_file} ${revocation_cert_file}

if [ ! -e "${cert_file}" ]; then
    sq key extract-cert --output ${cert_file} ${key_file}
fi

set -e
sq sign --signer-key ${key_file} README.md > README.md.sig
sq verify --signer-cert ${cert_file} README.md.sig
