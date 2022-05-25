

#### connect 
```bash
mysql -u <user> <database> p
```

#### Create user

```sql
CREATE DATABASE <database>;
CREATE USER '<user>'@'%' IDENTIFIED BY '<password>';
GRANT ALL PRIVILEGES ON <database>.* TO '<user>'@'%';
```

### create backup
```bash
mysqldump -u root -p <database> > "<database>-$(date +%Y-%m-%d-%H:%M).sql"
```

### restore backup
```bash
mysql -u root <database> -p  < backup.sql
```