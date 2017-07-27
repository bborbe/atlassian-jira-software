# Atlassian Jira-Software Docker

## Run

`mkdir -p /tmp/jira-app /tmp/jira-psql`

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

```
docker rm jira-app
docker run \
--name jira-app \
-e HOSTNAME=localhost \
-e SCHEMA=http \
-e PORT=8080 \
-p 8080:8080 \
-v /tmp/jira-app:/var/lib/jira \
--link jira-db:jira-db \
docker.io/bborbe/atlassian-jira-software:7.4.1-1.0.6
```

Open http://localhost:8080

Database-Setup:
User: jira
Pass: test123
Host: jira-db

## Version Schema

JIRAVERISON-BUILDVERSION

7.4.1-1.0.0 = Jira-Software 7.4.1 and Buildscripts 1.0.0

## Copyright and license

    Copyright (c) 2017, Benjamin Borbe <bborbe@rocketnews.de>
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are
    met:
    
       * Redistributions of source code must retain the above copyright
         notice, this list of conditions and the following disclaimer.
       * Redistributions in binary form must reproduce the above
         copyright notice, this list of conditions and the following
         disclaimer in the documentation and/or other materials provided
         with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
