# Creating the keys, certficates and stores

## Pre-requisite

Make sure `COMMON_NAME`, `SAN_DNS`, `ORGANISATION`, `COUNTRY`, `LOCALITY` and
`STATE` variables are propperly set in [env.sh](../env.sh).

Use wildcard subdomain for both `COMMON_NAME` and `SAN_DNS`. Note that `COMMON_NAME` should be less than or equal to 64 characters. For longer domains, make use of `SAN_DNS`, in addition to `COMMON_NAME`. 

For example, to use the certificates in IBM ROKS, we can have the following:

```
COMMON_NAME=*.eu-gb.containers.appdomain.cloud
SAN_DNS=*.thisiswaytoolongasdomainthatIneedtousethis.eu-gb.containers.appdomain.cloud
```

## Steps

```
ace-mq-tls
...
└── cert-generation <- includes scirpt to generate keys/certs/stores
    ├── README.md <--- this file
    ├── docker
    │   ├── Dockerfile
    │   └── src
    │       ├── Makefile
    │       └── san.ext
    └── generate.sh
...
```

Change to [cert-generation](.) directory.

Run the shell script, [generate.sh](./generate.sh), with

```
./generate.sh
```

The script will run a container to create the necessary keys, certifcates and stores, in `certs` directory at root of the installation folder. It will also output a decoded version of the MQ server certification for your verification. Check the Issuer, Subject and  X509v3 Subject Alternative Name.

Note that `PREFIX` from [env.sh](../env.sh) will be used in prefixing the name of the files.

Looking at the directory content, you should see:

```sh
.
ace-mq-tls
├── cert-generation
└── certs  <-- the certs directory
    ├── ibm-ace-server.crt
    ├── ibm-ace-server.jks
    ├── ibm-ace-server.kdb
    ├── ibm-ace-server.key
    ├── ibm-ace-server.p12
    ├── ibm-ace-server.sth
    ├── ibm-ca.crt
    ├── ibm-ca.jks
    ├── ibm-ca.key
    ├── ibm-ca.srl
    ├── ibm-client.crt
    ├── ibm-client.jks
    ├── ibm-client.key
    ├── ibm-mq-server.crt
    └── ibm-mq-server.key
...
```



these certificates will be used in the deployment steps. Follow either [local deployment](../local/README.asciidoc) for local container based deployment or [OpenShift deployment](../openshift/README.md) for OpenShift based deployment.
