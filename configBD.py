import psycopg2
from psycopg2 import Error
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()  # Instância global do SQLAlchemy

def init_db(app):
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+psycopg2://postgres:kleber@localhost:5432/FreteAgil'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)  # Registra o SQLAlchemy no Flask

# Função de conexão manual com o banco (opcional)
def connecti():
    try:
        conn = psycopg2.connect(
            dbname="FreteAgil",
            host="localhost",
            user="postgres",
            password="kleber",
            port="5432"
        )
        print("Conectado com sucesso ao banco de dados!")
        return conn
    except Error as e:
        print(f"Erro ao conectar: {e}")
        return None

# Função para encerrar a conexão
def close(conn):
    if conn:
        conn.close()
        print("Conexão encerrada")
