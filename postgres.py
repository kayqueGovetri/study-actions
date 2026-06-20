import psycopg

with psycopg.connect(
    host="127.0.0.1",
    port=5433,
    user="test",
    password="test",
    dbname="my_db",
) as conn:
    with conn.cursor() as cur:
        cur.execute("SELECT 1")
        print(cur.fetchone())