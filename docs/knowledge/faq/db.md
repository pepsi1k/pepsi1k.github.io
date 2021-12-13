# Postgresql 
```bash
create database $database_name;
create role $user_name with login encrypted password '$PASSWORD';
grant connect on database $database_name to $user_name;
```
connect to $database_name and create extension "uuid-ossp", if you are using uuid as primary key
```bash
create extension if not exists "uuid-ossp";
```