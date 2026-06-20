$service = "postgresql-x64-14"

Set-Service -Name $service -StartupType Manual
Start-Service -Name $service

Start-Sleep 10

$config = "C:\PostgreSQL\14\data\postgresql.conf"

(Get-Content $config) `
    -replace '^#?port\s*=\s*\d+', 'port = 5433' |
    Set-Content $config

Restart-Service $service

Start-Sleep 10

$env:PGPASSWORD = "root"

$psql = "C:\Program Files\PostgreSQL\14\bin\psql.exe"

$roleExists = & $psql `
    -h localhost `
    -p 5433 `
    -U postgres `
    -d postgres `
    -tAc "SELECT 1 FROM pg_roles WHERE rolname='test'"

if (-not $roleExists) {
    & $psql `
        -h localhost `
        -p 5433 `
        -U postgres `
        -d postgres `
        -c "CREATE ROLE test LOGIN PASSWORD 'test';"
}

$dbExists = & $psql `
    -h localhost `
    -p 5433 `
    -U postgres `
    -d postgres `
    -tAc "SELECT 1 FROM pg_database WHERE datname='my_db'"

if (-not $dbExists) {
    & $psql `
        -h localhost `
        -p 5433 `
        -U postgres `
        -d postgres `
        -c "CREATE DATABASE my_db OWNER test;"
}

& $psql `
    -h localhost `
    -p 5433 `
    -U postgres `
    -d postgres `
    -c "GRANT ALL PRIVILEGES ON DATABASE my_db TO test;"

$env:PGPASSWORD = "test"

$psql = "C:\Program Files\PostgreSQL\14\bin\psql.exe"

& $psql `
    -h localhost `
    -p 5433 `
    -U test `
    -d my_db `
    -c "SELECT current_database();"

& $psql `
    -h localhost `
    -p 5433 `
    -U test `
    -d my_db `
    -c "SELECT version();"