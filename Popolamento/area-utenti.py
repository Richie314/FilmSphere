from Cryptodome.Hash import SHA224
import random
import string

abbonamenti = [
    '',
    ''
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
def data():
    return ''

def generate_single(users, pws, nomi, cognomi):
    sql = 'REPLACE INTO `Utente` (`Codice`, `Nome`, `Cognome`, `Email`, `Password`, `Abbonamento`, `DataInizioAbbonamento`) VALUES\n'
    user = next_line(users)
    email = rand_email(user=user)
    password = hash(next_line(pws))
    nome, cognome = next_nome_cognome(nomi, cognomi)
    abb = abbonamento()
    iscrizione = data()
    
    sql += '(\'' + user + '\', \'' + nome + '\', \'' + cognome + '\', \'' + email + '\', \'' + password + '\', \'' + abb + '\', \'' + iscrizione + '\');\n'
    


    return sql

def genera_abbonamenti():
    if len(abbonamenti) == 0:
        return ''
    tipo = ''
    tariffa = ''
    durata = ''
    definiz = ''
    offline = ''
    maxore = ''
    gbmese = ''
    
    sql = 'REPLACE INTO `Abbonamento`(`Tipo`, `Tariffa`, `Durata`, `Definizione`, `Offline`, `MaxOre`, `GBMensili`) VALUES\n'
    sql += '(\'' + tipo + '\', ' + tariffa + ', ' + durata + ', ' + definiz + ', ' + offline +', ' + maxore +', ' + gbmese + '),\n'
    sql += '(\'' + tipo + '\', ' + tariffa + ', ' + durata + ', ' + definiz + ', ' + offline +', ' + maxore +', ' + gbmese + '),\n'
    sql += '(\'' + tipo + '\', ' + tariffa + ', ' + durata + ', ' + definiz + ', ' + offline +', ' + maxore +', ' + gbmese + '),\n'
    sql += '(\'' + tipo + '\', ' + tariffa + ', ' + durata + ', ' + definiz + ', ' + offline +', ' + maxore +', ' + gbmese + ');\n'

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
        line = generate_single(usernames, passwords, nomi, cognomi)
        file_out.writelines([comment, line])
    
    usernames.close()
    passwords.close()
    nomi.close()
    cognomi.close()

if __name__ == '__main__':
    generate()