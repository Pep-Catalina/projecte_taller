
from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Educem00.",
        database="centre_medic"
    )

@app.route('/pacients', methods=['GET'])
def get_pacients():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM pacients")
    pacients = cursor.fetchall()
    db.close()
    return jsonify(pacients)


@app.route('/pacients', methods=['POST'])
def create_pacient():
    data = request.get_json()
    db = connect_db()
    cursor = db.cursor()

    # Inserir pacient
    cursor.execute("""
        INSERT INTO pacients (nom, cognom, telefon, correu)
        VALUES (%s, %s, %s, %s)
    """, (data['nom'], data['cognom'], data['telefon'], data['correu']))
    db.commit()

    # Obtenir l'ID del pacient recentment creat
    pacient_id = cursor.lastrowid

    # Crear la visita
    cursor.execute("""
        INSERT INTO visites (pacient_id, data_visita, motiu_visita)
        VALUES (%s, %s, %s)
    """, (pacient_id, data['data_cita'], data['motiu']))
    db.commit()

    db.close()
    return jsonify({'message': 'Pacient i visita creats correctament'}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
