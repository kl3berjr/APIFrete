import os
from flask import Flask, request, render_template, jsonify
from datetime import datetime
from configBD import db, init_db

appfrete = Flask(__name__, template_folder=os.path.join(os.getcwd(), "templetes"))

# Configuração do banco de dados
init_db(appfrete)

# Modelo Veículo
class Veiculo(db.Model):
    __tablename__ = "veiculos"

    id = db.Column(db.Integer, primary_key=True)
    marca = db.Column(db.String(100), nullable=False)
    modelo = db.Column(db.String(100), nullable=False)
    ano = db.Column(db.Integer, nullable=False)  # Correção: deve ser Integer
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)



# Rota Home
@appfrete.route('/home')
def exibir():
    return render_template('home.html')

# Rota para cadastrar um novo veículo
@appfrete.route('/cadastro', methods=['GET', 'POST'])
def criar():
    if request.method == 'GET':
        return render_template('cadastro.html')

    try:
        # Captura os dados do formulário HTML
        veiculo_data = request.form.to_dict()

        # Converte o campo "ano" para inteiro
        veiculo_data["ano"] = int(veiculo_data.get("ano", 0))

        # Criar um novo veículo no banco de dados
        novo_veiculo = Veiculo(
            marca=veiculo_data.get("marca", ""),
            modelo=veiculo_data.get("modelo", ""),
            ano=veiculo_data["ano"]
        )

        db.session.add(novo_veiculo)
        db.session.commit()

        # Retorna os dados inseridos em formato JSON
        return jsonify({
            "id": novo_veiculo.id,
            "marca": novo_veiculo.marca,
            "modelo": novo_veiculo.modelo,
            "ano": novo_veiculo.ano,
            "created_at": novo_veiculo.created_at,
            "updated_at": novo_veiculo.updated_at
        }), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500


# Rota para listar todos os veículos
@appfrete.route('/lista', methods=['GET'])
def listar():
    try:
        veiculos = Veiculo.query.all()
        veiculos_json = [
            {
                "id": veiculo.id,
                "marca": veiculo.marca,
                "modelo": veiculo.modelo,
                "ano": veiculo.ano,
                "created_at": veiculo.created_at,
                "updated_at": veiculo.updated_at
            }
            for veiculo in veiculos
        ]
        return jsonify(veiculos_json), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Rota para editar um veículo
@appfrete.route('/editar', methods=['GET'])
def edit():
    return render_template('editar.html')

# Rota para excluir um veículo 
@appfrete.route('/excluir', methods=['GET'])
def deletar():
    return render_template('excluir.html')


# Executando a aplicação
if __name__ == "__main__":
    appfrete.run(port=5000, host='localhost', debug=True)
