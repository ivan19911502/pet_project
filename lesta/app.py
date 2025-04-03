from flask import Flask, jsonify
import redis

app = Flask(__name__)
r = redis.Redis(host='redis', port=6379, db=0)

@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({'status': 'Ok'})

@app.route('/count', methods=['GET'])
def count():
    r.incr('visit_count')
    visit_count = r.get('visit_count').decode('utf-8')
    return jsonify({'visit_count': visit_count})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
