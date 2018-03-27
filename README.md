# Atlassian Jira-Software Docker

## Run

### Create directories

```
mkdir -p /tmp/jira-app /tmp/jira-psql
```

## Start Postgresql

```
docker rm jira-db
docker run \
--name jira-db \
-e POSTGRES_USER=jira \
-e POSTGRES_DB=jira \
-e POSTGRES_PASSWORD=test123 \
-p 5432:5432 \
-v /tmp/jira-psql:/var/lib/postgresql/data \
docker.io/postgres:9.5
```

## Start Jira

```
docker rm jira-app
docker run \
--name jira-app \
-e HOSTNAME=localhost \
-e SCHEMA=http \
-e PORT=8080 \
-p 8080:8080 \
-v /tmp/jira-app:/var/lib/jira_software \
--link jira-db:jira-db \
docker.io/bborbe/atlassian-jira-software:7.5.0-1.1.2
```

## Setup Jira

Open http://localhost:8080

```
Hostname: jira-db
Port:     5432
Database: jira
Username: jira
Password: test123
```

## Version Schema

JIRAVERISON-BUILDVERSION

7.5.0-1.0.0 = Jira-Software 7.5.0 and Buildscripts 1.0.0
