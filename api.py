from flask import Flask

app = Flask(__name__) #__name__ is a special variable in python that creates an instance of the web app

@app.route("/", methods =['GET'])
def hello():
    return "Hello World"

@app.route("/hello")
def helloo():
    return "Hello Not World"

if __name__ == '__main__':
    app.run(debug=True)

