from flask import Flask, render_template, request, redirect, url_for
#import mysql.connector
import re  

app = Flask(__name__, template_folder='templates')



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

#point d'entrée

@app.route("/form")
def monForm():
	return render_template("form.html", fruit="test")


#point de sortie
patt1 = ".{6,}"
patt2 = ".*\d+.*"
patt3 = ".*[A-Z]+.*"
patt4 = ".*[a-z]+.*"
patt5 = ".*[#%{}@\"].*"
@app.route('/newuser',methods = ['POST', 'GET'])
def newuser():
	if request.method == 'POST':
		username = request.form.get("username")
		password = request.form.get("password")
		if re.fullmatch(patt1, password) == None:
			print("Echec condition Au moins 6 caractères")
			erreur="au moins 6 caractères"
			return render_template("error.html", user=username, error=erreur)
		else :
			if re.fullmatch(patt2, password) == None:
				print("Echec condition Au moins 1 chiffre")
				erreur="Au moins 1 chiffre"
				return render_template("error.html", user=username, error=erreur)
			else :
				if re.fullmatch(patt3, password) == None:
					print("Echec condition Au moins 1 majuscule")
					erreur="Au moins 1 majuscule"
					return render_template("error.html", user=username, error=erreur)
				else :
					if re.fullmatch(patt4, password) == None:
						print("Echec condition Au moins 1 minuscule")
						erreur="Au moins 1 minuscule"
						return render_template("error.html", user=username, error=erreur)
					else :
						if re.fullmatch(patt5, password) == None:
							print("Echec condition au moins 1 caractère parmi les 5 suivants : #%{}@\"")
							erreur="au moins 1 caractère parmi les 5 suivants : #%{}@\""
							return render_template("error.html", user=username, error=erreur)
						else :
							return render_template("newuser.html", user=username, password=password)	    
        #return res.text()


if __name__ == '__main__':
    app.run(debug=True)
