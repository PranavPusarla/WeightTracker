import sqlite3

connector = sqlite3.connect('weights.db')
cursor = connector.cursor()
cursor.execute('''CREATE TABLE WEIGHTS([Client_Name] text, [Weight] double, [Datetime] integer)''')
