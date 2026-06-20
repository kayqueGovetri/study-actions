import mysql.connector


def main() -> None:
    connection = mysql.connector.connect(
        host="127.0.0.1",
        port=32768,
        user="root",
        password="root",
        database="my_db",
    )

    try:
        cursor = connection.cursor()

        cursor.execute("SELECT 1")

        result = cursor.fetchone()

        print(f"Query result: {result}")

    finally:
        cursor.close()
        connection.close()


if __name__ == "__main__":
    main()