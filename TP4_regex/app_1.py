from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
import re  # Import pour gérer les expressions régulières

app = Flask(__name__, template_folder='templates')


# MySQL configuration (pas nécessaire si vous ne vous connectez pas à la base de données)
db_config = {
    'host': 'tp4-sql',
    'user': 'root',
    'password': 'foo',
    'database': 'demosql'
}


@app.route('/')
def index():
    # Initialiser la connexion MySQL (ne pas utiliser si vous ne vous connectez pas à la base)
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    # Exemple de requête
    query = "SELECT * FROM myTable"
    cursor.execute(query)
    data = cursor.fetchall()
    
    # Fermer le curseur et la connexion
    cursor.close()
    conn.close()
    
    return render_template('index.html', data=data)

@app.route('/newuser/', methods=['GET', 'POST'])
def new_user():
    if request.method == 'POST':
        username = request.form['username']
        res = request.form.get("password")
        pattern = "aaa" #"(.{6,}|\d+|[A-Z]+|[a-z]+|(\#\%\{\}\@\))"
        test = re.search(pattern,res)
        #return res.text()
        #return("password non valide")
        #return render_template('newuser.html', error_message="erreur")
    return render_template('newuser.html')

if __name__ == '__main__':
    app.run(debug=True)
