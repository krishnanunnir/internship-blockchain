import flask
import random 
from flask import json
from flask import Response

app = flask.Flask(__name__)

@app.route('/', methods=['GET'])

def vals():
	humidity = random.uniform(1,100)
	temperature = random.uniform(1,100)
	js = [{"humidity":humidity,"temperature":temperature}]
	return Response(json.dumps(js),  mimetype='application/json')

app.run()


if __name__ == '__main__':
	app.debug=True
	app.run()
