import sqlite3

class Database:
    def db_connect(self,db):
        self.connector = sqlite3.connect(db)
        self.cursor = self.connector.cursor()

    def add_user(self, first_name, last_name):
        self.cursor.execute('''CREATE TABLE first_name+'_'+last_name ([Weight] integer, [Datetime] date)''')

    def add_weight(self, first_name, last_name, weight, datetime):
        self.cursor.execute('''INSERT INTO first_name+'_'+last_name(weight, datetime)''')

    def commit(self):
        self.connector.commit()

