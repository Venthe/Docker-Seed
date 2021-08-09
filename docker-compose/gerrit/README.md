### Initialize Gerrit DB and Git repositories with Docker

The external filesystem needs to be initialized with gerrit.war beforehand:

* All-Projects and All-Users Git repositories created in Gerrit
* System Group UUIDs created in Git repositories

The initialization can be done as a one-off operation before starting all containers.

#### Step-1: Run Gerrit docker init setup from docker

Uncomment the `command: init` option in docker-compose.yaml and run Gerrit with docker-compose in foreground.

```
docker-compose up gerrit
```

Wait until you see in the output the message `Initialized /var/gerrit` and then the container will exit.

#### Step-2: Start Gerrit in daemon mode

Comment out the `command: init` option in docker-compose.yaml and start all the docker-compose nodes:

```
docker-compose up -d
```

### Registering users in OpenLDAP with PhpLdapAdmin

The sample docker compose project includes a node with PhpLdapAdmin connected to OpenLDAP and exposed via Web UX at [https://localhost:6443](https://localhost:6443).

The first user that logs in Gerrit is considered the initial administrator, it is important that you configure it on LDAP to login and having the ability to administer your Gerrit setup.

#### Define the Gerrit administrator in OpenLDAP

Login to PhpLdapAdmin using `cn=admin,dc=example,dc=org` as username and `secret` as password and then create a new child node of type "Courier Mail Account" for the Gerrit Administrator

Example:

* Given Name: Gerrit
* Last Name: Admin
* Common Name: Gerrit Admin
* User ID: gerritadmin
* Email: gerritadmin@localdomain
* Password: secret

Verify that your data is correct and then commit the changes to LDAP.

#### Login to Gerrit as Administrator

Login to Gerrit on [http://localhost](http://localhost) using the new Gerrit Admin credentials created on LDAP.

Example:

* Login: gerritadmin
* Password: secret