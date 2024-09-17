
```bash
psql -U username -d database -h hostname
```


```sql
create database <database>;
create role <username> with login encrypted password '<password>';
grant connect on database <database> to <username>;

-- connect to <database> and create extension "uuid-ossp", if you are using uuid as primary key
\c polpick
create extension if not exists "uuid-ossp";
-- version 15+
GRANT CREATE ON SCHEMA public TO polpick; 

-- optional
GRANT ALL PRIVILEGES ON DATABASE polpick TO polpick;

```

#### note
```
\list or \l     : list all databases
\c <db>         : connect to a certain database
\c <db> <user>  : connect to a certain database as a user 
\dt             : list all tables in the current database using your search_path
\dt *.          : list all tables in the current database regardless your search_path
```