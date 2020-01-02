import sqlite3
from database import Database
from datetime import datetime, timedelta
import matplotlib.pyplot as plt

def add_weight(first_name, last_name, weight, datetime):
    full_name = first_name+" "+last_name
    database = Database('weights.db')
    database.cursor.execute('''INSERT INTO WEIGHTS VALUES(?,?,?)''',(full_name, weight, datetime))
    database.connector.commit()
    database.cursor.close()

def get_all_weights(first_name, last_name):
    full_name = first_name + " " +last_name
    database = Database('weights.db')
    database.cursor.execute('''SELECT Weight FROM WEIGHTS WHERE Client_Name=?''', (full_name,))
    print(database.cursor.fetchall())

def get_week_weights(first_name, last_name):
    full_name = first_name + " " + last_name
    database = Database('weights.db')
    database.cursor.execute('''SELECT date(Datetime, 'unixepoch', 'localtime'), AVG(Weight), Datetime FROM WEIGHTS WHERE Client_Name=? GROUP BY date(Datetime, 'unixepoch', 'localtime')''', (full_name,))
    total_list = database.cursor.fetchall()
    date_list = []
    for entry in total_list:
        date_list.append(entry[0])
    most_recent_weekday = datetime.fromtimestamp(total_list[len(total_list)-1][2]).weekday()
    most_recent_date = datetime.fromtimestamp(total_list[len(total_list)-1][2])
    print(type(most_recent_date))
    weights = []
    dates = []
    print(total_list)
    for index in reversed(range(most_recent_weekday+1)):
        user_date = most_recent_date-timedelta(days=index)
        if str(user_date.date()) in date_list:
            index = date_list.index(str(user_date.date()))
            weights.append(total_list[index][1])
            dates.append(total_list[index][2])
    for day in range(len(dates)):
        dates[day] = datetime.fromtimestamp(dates[day]).strftime('%A')
    print(dates)
    plt.plot(dates,weights, marker='o')
    plt.savefig('static/week_weights_graph.png', format='png')
    plt.show()

def weekday(day):
    weekday = []
    if day >= 0:
        weekday.append('Monday')
    if day >= 1:
        weekday.append('Tuesday')
    if day >= 2:
        weekday.append('Wednesday')
    if day >=3:
        weekday.append('Thursday')
    if day >=4:
        weekday.append('Friday')
    if day >= 5:
        weekday.append('Saturday')
    if day >= 6:
        weekday.append('Sunday')
    return weekday

def get_total_weights(first_name, last_name):
    full_name = first_name+' '+last_name
    database = Database('weights.db')
    database.cursor.execute('''SELECT date(Datetime, 'unixepoch', 'localtime'), AVG(Weight), Datetime FROM WEIGHTS WHERE Client_Name=? GROUP BY date(Datetime, 'unixepoch', 'localtime')''',(full_name,))
    dates = []
    weights = []
    total_list = database.cursor.fetchall()
    for tuple in total_list:
        total_date = tuple[0]
        weights.append(tuple[1])
        dates.append(total_date[5:7]+"/"+total_date[8:])
    x = dates
    y = weights
    plt.plot(x,y, marker='o')
    plt.savefig('static/total_weights_graph.png', format='png')
    plt.show()

def diff_date(timestamp1, timestamp2):
    date1 = datetime.fromtimestamp(timestamp1)
    date2 = datetime.fromtimestamp(timestamp2)
    if (date1.date() == date2.date()):
        return True
    return False

def delete_weight(first_name, last_name, weight, datetime):
    full_name = first_name+" "+last_name
    database = Database('weights.db')
    database.cursor.execute('''DELETE FROM WEIGHTS WHERE Client_Name=? AND Weight=? AND Datetime=?''', (full_name, weight, datetime))
    database.connector.commit()
    database.cursor.close()

def delete_weights(first_name, last_name):
    full_name = first_name + " " + last_name
    database = Database('weights.db')
    database.cursor.execute('''DELETE FROM WEIGHTS WHERE Client_Name=?''',(full_name,))
    database.connector.commit()
    database.cursor.close()

def total_days(first_name, last_name):
    full_name = first_name + " " + last_name
    database = Database('weights.db')
    database.cursor.execute('''SELECT Weight, Datetime FROM WEIGHTS WHERE Client_Name=?''', (full_name,))
    total_list = database.cursor.fetchall()
    date = datetime.now().timestamp()
    total_days = 0
    for tuple in total_list:
        if (datetime.fromtimestamp(tuple[1])).date() != (datetime.fromtimestamp(date).date()):
            total_days+=1
        date = tuple[1]
    return total_days

def total_loss(first_name, last_name):
    database = Database('weights.db')
    full_name = first_name+" " +last_name
    database.cursor.execute('''SELECT Weight FROM WEIGHTS WHERE Client_Name=?''', (full_name,))
    total_list = database.cursor.fetchall()
    first_weight = total_list[0][0]
    last_weight = total_list[len(total_list)-1][0]
    return last_weight - first_weight

def show_database():
    database = Database('weights.db')
    database.cursor.execute('''SELECT * FROM WEIGHTS''')
    for row in database.cursor:
        print(row)

#add_weight("Pranav", "Pusarla", 140, (datetime.now() - timedelta(days=1)).timestamp())
#show_database()
#get_week_weights("Pranav", "Pusarla")
#get_total_weights("Pranav", "Pusarla")
total_loss("Pranav", "Pusarla")