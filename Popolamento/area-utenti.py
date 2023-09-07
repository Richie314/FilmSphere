from Cryptodome.Hash import SHA224
import random
import string
import datetime

abbonamenti = [
    'Basic',
    'Premium',
    'Pro',
    'Deluxe',
    'Ultimate'
]

domini_email = [
    'libero.it',
    'virgilio.it',
    'hotmail.it',
    'gmail.com',
    'yahoo.com',
    'aol.com',
    'live.com',
    'msn.com',
    'yahoo.it',
    'alice.it',
    'facebook.com',
    'tiscali.it'
]

def next_line(file, rec=0):
    if rec > 5:
        raise Exception('Problema in lettura file!')
    try:
        line = file.readline()
    except:
        return next_line(file=file, rec=rec + 1)
    if not line:
        file.seek(0)
        return next_line(file=file, rec=rec)
    return str(line).replace('\r', '').replace('\n', '').replace('\t', '')
def next_nome_cognome(nomi, cognomi):
    nome = next_line(file=nomi)
    cognome = next_line(file=cognomi)

    if nome[0] == '"':
        nome = nome[1:-1]
    
    if cognome[0] == '"':
        cognome = cognome[1:-1]

    return nome, cognome
def hash(password):
    h = SHA224.new()
    h.update(str(password).encode())
    return h.hexdigest()
def rand_email(user):
    start = user + '-' + ''.join(random.choices(population=string.ascii_letters+string.digits, k=random.randint(2, 4))) 
    dominio = random.choice(domini_email)
    return start + '@' + dominio
def abbonamento():
    return random.choice(abbonamenti)
def data(min=None, max=None):
    if not min:
        return data(min=datetime.datetime.now(), max=max)
    if not max:
        new_max = min + datetime.timedelta(days=random.randint(1, 100))
        return data(min=min, max=new_max)

    delta = max - min
    return min + datetime.timedelta(days=random.randint(1, delta.days))

def date_to_str(date):
    if not date:
        return ''
    return str(date.year) + '-' + str(date.month) + '-' + str(date.day)

def generate_single_fattura(user, pagata):
    if not pagata:
        return 'INSERT INTO `Fattura` (`Utente`, `DataEmissione`) VALUES (\'' + user + '\', \'' +  date_to_str(data()) + '\');\n'
    
    pan = ''.join(random.choices(population=string.digits, k=16))
    cvv = random.randint(1, 999)
    scadenza = data()

    emissione = data(min=scadenza)
    pagamento = data(min=scadenza, max=emissione)

    scadenza = str(scadenza.year) + '-' + str(scadenza.month) + '-01'
    emissione = date_to_str(emissione)
    pagamento = date_to_str(pagamento)

    sql = 'REPLACE INTO `CartaDiCredito` (`Pan`, `Scadenza`, `CVV`) VALUES (' + str(pan) + ', \'' + scadenza + '\', ' + str(cvv) + ');\n'
    sql += 'INSERT INTO `Fattura` (`Utente`, `DataEmissione`, `DataPagamento`, `CartaDiCredito`) VALUES (\'' + user + '\', \'' +  emissione + '\', \'' + pagamento + '\', ' + str(pan) + ');\n'

    return sql

def generate_single_user(users, pws, nomi, cognomi):
    sql = 'INSERT INTO `Utente` (`Codice`, `Nome`, `Cognome`, `Email`, `Password`, `Abbonamento`, `DataInizioAbbonamento`) VALUES\n'
    user = next_line(users)
    email = rand_email(user=user)
    password = hash(next_line(pws))
    nome, cognome = next_nome_cognome(nomi, cognomi)
    abb = abbonamento()
    iscrizione = date_to_str(data())
    
    sql += '(\'' + user + '\', \'' + nome + '\', \'' + cognome + '\', \'' + email + '\', \'' + password + '\', \'' + abb + '\', \'' + iscrizione + '\');\n'
    
    # Fatture e Pagamenti
    numero_fatture = random.randint(1, 11)
    for i in range(0, numero_fatture):
        sql += generate_single_fattura(user, i < 10)

    # Recensioni
    numero_recensioni = random.randint(0, 2)
    for i in range(0, numero_recensioni):
        sql += 'CALL `RecensioneCasuale`(\'' + user + '\');\n'

    # Connessioni


    # Visualizzazioni


    return sql

def genera_abbonamenti():
    if len(abbonamenti) == 0:
        return ''
    
    sql = 'REPLACE INTO `Abbonamento`(`Tipo`, `Tariffa`, `Durata`, `Definizione`, `Offline`, `MaxOre`, `GBMensili`) VALUES\n'
    sql += '(\'Basic\', 5.99, 30, 1080, FALSE, 8, 32),\n'
    sql += '(\'Premium\', 9.99, 30, 2160, FALSE, 8, 96),\n'
    sql += '(\'Pro\', 13.49, 30, 4096, FALSE, 28, 0),\n'
    sql += '(\'Deluxe\', 24.99, 60, 4096, FALSE, 28, 0),\n'
    sql += '(\'Ultimate\', 39.99, 90, 16384, TRUE, 28, 0);\n\n'

    basic_esclusioni = random.randint(6, 10)
    for i in range(0, basic_esclusioni):
        sql += 'CALL `EsclusioneCasuale`(\'Basic\');\n'

    return sql

def generate():
    # https://github.com/danielmiessler/SecLists
    usernames = open('user-names.txt', 'r')
    passwords = open('passwords.txt', 'r')

    # https://github.com/filippotoso/nomi-cognomi-italiani/
    nomi = open('nomi.csv', 'r')
    cognomi = open('cognomi.csv', 'r')

    file_out = open('area-utenti.sql', 'w')
    file_out.write('USE `FilmSphere`;\n')
    file_out.write(genera_abbonamenti())
    
    for i in range(1, 1000000):
        comment = '-- ' + str(i) + '\n'
        # Uncomment to debug
        # print(str(i) + '/1000000')
        line = generate_single_user(usernames, passwords, nomi, cognomi)
        file_out.writelines([comment, line])
    
    usernames.close()
    passwords.close()
    nomi.close()
    cognomi.close()

if __name__ == '__main__':
    generate()