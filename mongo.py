from pymongo import MongoClient

client = MongoClient(
    "mongodb://root:root@127.0.0.1:27017/my_db?authSource=admin"
)

db = client["my_db"]

print(db.command("ping"))