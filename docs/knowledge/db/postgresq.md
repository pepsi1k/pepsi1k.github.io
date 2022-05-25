
```sql
create database <database>;
create role <username> with login encrypted password '<password>';
grant connect on database <database> to <username>;

-- connect to <database> and create extension "uuid-ossp", if you are using uuid as primary key
create extension if not exists "uuid-ossp";
```