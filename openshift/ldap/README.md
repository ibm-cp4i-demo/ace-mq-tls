# Install OpenLDAP

## Pre-requisite

Make sure OpenShift internal registry is exposed.

## Steps

```
client-deployment
└── ldap
    ├── README.md <- this file
    ├── client
    │   └── run.sh
    └── create-ldap
        ├── Dockerfile
        ├── bootstrap.ldif
        ├── install.sh
        ├── ldap-deployment.yaml
        └── ldap-service.yaml 
...
```

We would run the script [create-ldap/install.sh](create-ldap/install.sh) script. The script will create a namespace for LDAP and run steps to install OpenLDAP on the OCP cluster. Users and groups will create from [create-ldap/bootstrap.ldif](create-ldap/bootstrap.ldif).

1. Change directory to [create-ldap](./create-ldap)

2. Run the script:

   ```bash
   ./install.sh
   ```


3. To verify that the installation worked, run the [client/run.sh](client/run.sh) scripts

   a. Change directory to [client](client)

   b. Run the script:

      ```bash
      ./run.sh
      ```
   
   The above will run a query for all the entries in LDAP for the root base DN.

## Next Step

Install MQ cluster, [mq/README.md](../mq/README.md)
