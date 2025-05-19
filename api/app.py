from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import mysql.connector
import os

app = Flask(__name__)
# Change strict origin CORS to allow all origins
CORS(app)

@app.route('/')
def home():
    return 'Benvingut al Centre Mèdic!'  # O retorna una plantilla HTML si és el cas

@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/vnd.microsoft.icon')
def connect_db():
    try:
        db = mysql.connector.connect(
            host="192.168.1.3",  # O el que sigui, depenent de la teva configuració
            user="admin",
            password="Educem00.",
            database="centre_medic",
            port="3306",
            charset="utf8mb4",
            collation="utf8mb4_unicode_ci"
        )
        return db
    except mysql.connector.Error as err:
        print(f"Error de connexió a la base de dades: {err}")
        return None

@app.route('/pacients', methods=['POST'])
def create_pacient():

    # if db is None:
    #     return jsonify({"error": "No s'ha pogut connectar a la base de dades."}), 500

    try:
        data = request.get_json()
        db = connect_db()
        cursor = db.cursor()


        # 1. Inserir el pacient
        cursor.execute("""
            INSERT INTO pacients (dni, nom, cognom, telefon, correu)
            VALUES (%s, %s, %s, %s, %s)
        """, (data['dni'], data['nom'], data['cognom'], data['telefon'], data['correu']))

        # 2. Inserir la visita
        cursor.execute("""
            INSERT INTO visites (pacient_id, especialitat_id, data_visita, motiu_visita)
            VALUES (%s, %s, %s, %s)
        """, (data['dni'], None, data['data_cita'], data['motiu_consulta']))

        db.commit()
        return jsonify({"message": "Pacient i visita creats correctament."}), 201
    except Exception as e:
        # db.rollback()
        return jsonify({"msg": "Error en crear el pacient i la visita.","error":f"{e}"}), 500
    # finally:
        # db.close()

#Mostrar consulta a la taula
@app.route('/pacients', methods=['GET'])
def obtenir_pacients():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT p.dni, p.nom, p.cognom, v.data_visita, v.motiu_visita
        FROM pacients p
        LEFT JOIN visites v ON p.dni = v.pacient_id
    """)
    pacients = cursor.fetchall()
    cursor.close()
    db.close()
    return jsonify(pacients)

if __name__ == '__main__':
#    app.debug = True
    app.run(host='0.0.0.0', port=5000)