from flask import Flask, jsonify, send_file, url_for
import data_functions
from datetime import datetime

app = Flask(__name__) #__name__ is a special variable in python that creates an instance of the web app

@app.route("/", methods =['GET'])
def hello():
    return ("Hello World")

@app.route("/hello")
def helloo():
    return "Hello Not World"

@app.route("/total_loss/<first_name>/<last_name>", methods = ['GET'])
def total_loss(first_name, last_name):
    return str(data_functions.total_loss(first_name, last_name))

@app.route("/total_weights_graph/<first_name>/<last_name>", methods = ['GET'])
def total_weights(first_name, last_name):
    data_functions.get_total_weights(first_name, last_name)
    filename = '/Users/Pranav/PycharmProjects/WeightTracker'
    return "http://127.0.0.1:5000" + url_for('static', filename="total_weights_graph.png")

@app.route("/weekly_weights_graph/<first_name>/<last_name>", methods = ['GET'])
def week_weights(first_name, last_name):
    data_functions.get_week_weights(first_name, last_name)
    return "http://127.0.0.1:5000" + url_for('static', filename="week_weights_graph.png")

@app.route("/add_weight/<first_name>/<last_name>/<weight>", methods = ['GET','POST'])
def add_weight(first_name, last_name, weight):
    data_functions.add_weight(first_name, last_name, int(weight), datetime.now().timestamp())
    return

if __name__ == '__main__':
    app.run(debug=True)

