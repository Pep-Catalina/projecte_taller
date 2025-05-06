
from flask import Flask, request, jsonify
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
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
            host="localhost",  # O el que sigui, depenent de la teva configuració
            user="root",
            password="Educem00.",
            database="centre_medic"
        )
        return db
    except mysql.connector.Error as err:
        print(f"Error de connexió a la base de dades: {err}")
        return None

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
    # Imprimir la petició per veure si arriba al backend
    print("S'ha rebut una petició POST a /pacients")
    
    data = request.get_json()
    
    # Imprimir les dades per veure què s'està rebent
    print(data)

    db = connect_db()
    
    if db is None:
        return jsonify({'error': 'Error de connexió a la base de dades'}), 500
    
    cursor = db.cursor()

    try:
        # Inserim el pacient
        cursor.execute("""
            INSERT INTO pacients (dni, nom, cognom, telefon, correu)
            VALUES (%s, %s, %s, %s, %s)
            """, (data['dni'], data['nom'], data['cognom'], data['telefon'], data['correu']))

        db.commit()

        pacient_id = cursor.lastrowid  # Obtenim l'ID del pacient creat
        
        # Ara inserim la cita (visita) relacionada amb aquest pacient
        cursor.execute("""
            INSERT INTO visites (pacient_id, data_visita, motiu_visita)
            VALUES (%s, %s, %s)
        """, (pacient_id, data['data_cita'], data['motiu_consulta']))
        db.commit()

        return jsonify({'message': 'Pacient i cita creats correctament', 'pacient_id': pacient_id}), 201

    except mysql.connector.Error as err:
        db.rollback()
        return jsonify({'error': f'Error en la inserció: {err}'}), 500
    finally:
        db.close()



if __name__ == '__main__':
    app.debug = True
    app.run(host='0.0.0.0', port=5000)
