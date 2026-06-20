New-Item -ItemType Directory -Force -Path C:\mysql-data

& "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" `
  --initialize-insecure `
  --datadir=C:\mysql-data

Start-Process `
  -FilePath "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" `
  -ArgumentList `
  "--datadir=C:\mysql-data",
  "--port=32768",
  "--bind-address=0.0.0.0"

Start-Sleep 20

$mysql = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"

& $mysql `
  --protocol=TCP `
  -h 127.0.0.1 `
  -P 32768 `
  -u root `
  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"

& $mysql `
  --protocol=TCP `
  -h 127.0.0.1 `
  -P 32768 `
  -u root `
  -proot `
  -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'root';"

& $mysql `
  --protocol=TCP `
  -h 127.0.0.1 `
  -P 32768 `
  -u root `
  -proot `
  -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"

& $mysql `
  --protocol=TCP `
  -h 127.0.0.1 `
  -P 32768 `
  -u root `
  -proot `
  -e "FLUSH PRIVILEGES;"

& $mysql `
  --protocol=TCP `
  -h 127.0.0.1 `
  -P 32768 `
  -u root `
  -proot `
  -e "CREATE DATABASE IF NOT EXISTS my_db;"


& $mysql `
  --protocol=TCP `
  -h 127.0.0.1 `
  -P 32768 `
  -u root `
  -proot `
  -e "SHOW DATABASES;"

& $mysql `
  --protocol=TCP `
  -h 127.0.0.1 `
  -P 32768 `
  -u root `
  -proot `
  -e "SELECT VERSION();"