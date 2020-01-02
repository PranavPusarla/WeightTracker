import sqlite3

class Database:
    def __init__(self, db):
        self.connector = sqlite3.connect(db)
        self.cursor = self.connector.cursor()

    def commit(self):
        self.connector.commit()



