
$service = "MongoDB"

Set-Service -Name $service -StartupType Manual
Start-Service -Name $service

Start-Sleep 10

where.exe mongosh

Get-Command mongosh

Get-ChildItem "C:\Program Files" -Recurse -Filter mongosh.exe -ErrorAction SilentlyContinue

$mongosh = "C:\Program Files\mongosh\mongosh.exe"

& $mongosh --eval "
use admin

db.createUser({
  user: 'root',
  pwd: 'root',
  roles: [
    { role: 'root', db: 'admin' }
  ]
})
"

& $mongosh -u root -p root --authenticationDatabase admin --eval "
use my_db
db.createCollection('healthcheck')
"

$mongosh = "C:\Program Files\MongoDB\Shell\bin\mongosh.exe"

& $mongosh `
  -u root `
  -p root `
  --authenticationDatabase admin `
  --eval "
    use my_db;
    db.runCommand({ ping: 1 });
  "