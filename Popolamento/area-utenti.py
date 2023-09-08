from Cryptodome.Hash import SHA224
import random
import string
import datetime
import sys
from math import floor

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

user_agents = [
    # Windows user agents
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.51",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/114.0",
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 OPR/95.0.0.0 (Edition Campaign 34)"
    # Mac user agents
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Safari/605.1.1",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
    # Linux user agents
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
    "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/114.0",
    "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/114.0",
    "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0",
    "Mozilla/5.0 (X11; Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
    # Chrome OS user agent
    "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
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
        new_max = min + datetime.timedelta(days=random.randint(1, 101))
        return data(min=min, max=new_max)
    
    delta = max - min
    days = random.randint(0, delta.days)
    hours = random.randint(0, 23)
    minutes = random.randint(0, 59)
    seconds = random.randint(0, 59)
    return min + datetime.timedelta(days=days, hours=hours, minutes=minutes, seconds=seconds)

def date_to_str(date):
    if not date:
        return ''
    return str(date.year) + '-' + str(date.month).zfill(2) + '-' + str(date.day).zfill(2)

def datetime_to_str(date):
    if not date:
        return ''
    return date_to_str(date=date) + ' ' + str(date.hour).zfill(2) + ':' + str(date.minute).zfill(2) + ':' + str(date.second).zfill(2)

def generate_single_fattura(user, pagata, fatture_pagate, fatture_da_pagare, carte_di_credito):
    if not pagata:
        with open(fatture_da_pagare, 'a') as file:
            file.write('(\'' + user + '\', \'' +  date_to_str(data()) + '\'),\n')
    
    pan = ''.join(random.choices(population=string.digits, k=16))
    cvv = random.randint(1, 999)
    scadenza = data()

    emissione = data(min=scadenza)
    pagamento = data(min=scadenza, max=emissione)

    scadenza = str(scadenza.year) + '-' + str(scadenza.month) + '-01'
    emissione = date_to_str(emissione)
    pagamento = date_to_str(pagamento)
    """
    INSERT INTO `Fattura` (`Utente`, `DataEmissione`) VALUES\n'
    REPLACE INTO `CartaDiCredito` (`Pan`, `Scadenza`, `CVV`) VALUES\n
    INSERT INTO `Fattura` (`Utente`, `DataEmissione`, `DataPagamento`, `CartaDiCredito`) VALUES
    """
    with open(carte_di_credito, 'a') as file:
        file.write('(' + str(pan) + ', \'' + scadenza + '\', ' + str(cvv) + '),\n')
    with open(fatture_pagate, 'a') as file:
        file.write('(\'' + user + '\', \'' +  emissione + '\', \'' + pagamento + '\', ' + str(pan) + ');\n')
def generate_connessione(user, add_vis=False):
    sql = '\tREPLACE INTO `Connessione` (`Utente`, `IP`, `Inizio`, `Fine`, `Hardware`) VALUES '
    ip = str(int.from_bytes(random.randbytes(4), 'big'))
    inizio = data()
    fine = datetime_to_str( data(min=inizio) )
    inizio = datetime_to_str(inizio)
    hw = random.choice(user_agents)
    sql += '(\'' + user + '\', ' + ip + ', \'' + inizio + '\', \'' + fine + '\', \'' + hw +'\');\n'
    if add_vis:
        sql += '\tCALL `VisualizzazioneCasuale`(\'' + user + '\', ' + ip + ', \'' + inizio + '\');\n'
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

    # Connessioni e Visualizzazioni
    numero_connessioni = random.randint(0, 20)
    for i in range(0, numero_connessioni):
        sql += generate_connessione(user, numero_connessioni % 2 == 0)

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

    sql += 'CALL `EsclusioneCasuale`(\'Premium\');\n'
    sql += 'CALL `EsclusioneCasuale`(\'Premium\');\n'
    return sql

def generate(number):
    assert number != 0
    # https://github.com/danielmiessler/SecLists
    usernames = open('user-names.txt', 'r')
    passwords = open('passwords.txt', 'r')

    # https://github.com/filippotoso/nomi-cognomi-italiani/
    nomi = open('nomi.csv', 'r')
    cognomi = open('cognomi.csv', 'r')

    file_out = open('area-utenti.sql', 'w')
    file_out.write('USE `FilmSphere`;\n\n')
    file_out.write('/*!SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0*/;\n')
    file_out.write('/*!SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0*/;\n')
    file_out.write('/*!SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE=\'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION\'*/;\n\n')
    
    file_out.write(genera_abbonamenti())
    
    checkpoint = floor(number / 100)

    for i in range(1, number):
        comment = '-- ' + str(i) + '\n'
        if i % checkpoint == 0:
            print(str(floor(i / number * 100)) + '%\t' + str(i) + '/' + str(number))
        line = generate_single_user(usernames, passwords, nomi, cognomi)
        file_out.writelines([comment, line])
    
    file_out.write('\n/*!SET SQL_MODE=@OLD_SQL_MODE*/;\n')
    file_out.write('/*!SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS*/;\n')
    file_out.write('/*!SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS*/;')
    

    usernames.close()
    passwords.close()
    nomi.close()
    cognomi.close()

if __name__ == '__main__':
    if len(sys.argv) < 2:
        number = number = 0.1
    else:
        number = sys.argv[1]
        if not number:
            number = 0.1
        else:
            number = float(number)
    generate(floor(number * 1000000))