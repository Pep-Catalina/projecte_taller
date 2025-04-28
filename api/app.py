
from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

def connect_db():
    return mysql.connector.connect(
        host="db",
        user="root",
        password="example",
        database="taller"
    )

@app.route('/vehicles', methods=['GET'])
def get_vehicles():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM vehicles")
    vehicles = cursor.fetchall()
    db.close()
    return jsonify(vehicles)

@app.route('/appointments', methods=['POST'])
def create_appointment():
    data = request.get_json()
    db = connect_db()
    cursor = db.cursor()
    cursor.execute("INSERT INTO cites (vehicle_id, data_cita, servei_sollicitat) VALUES (%s, %s, %s)", 
                   (data['vehicle_id'], data['data_cita'], data['servei_sollicitat']))
    db.commit()
    db.close()
    return jsonify({'message': 'Cita creada'}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
