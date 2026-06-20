
$service = "MongoDB"

Set-Service -Name $service -StartupType Manual
Start-Service -Name $service

Start-Sleep 10
Get-Service -Name $service


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