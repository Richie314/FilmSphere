import sys
import subprocess

def execute_script(name, percentage=None):
    if not name:
        return ''
    script_name = name + '.py'
    out_name = name + '.sql'
    cmd = ['python', script_name]
    print ('Running \'' + script_name + '\' now...')
    if percentage:
        cmd.append(str(percentage))
    code = subprocess.Popen(cmd).wait()
    print('\t\'' + script_name + '\' finished with code ' + str(code) + '.')
    return out_name

def append_to_bundle(append_to, append_what):
    with open(append_to, 'a') as file_out, open(append_what, 'r') as file_in:
        for line in file_in:
            file_out.write(line + '\n')

def bundle_files(names, out_name):
    print('Genereting bundle \'' + out_name + '\'...')
    
    with open(out_name, 'w') as file:
        file.write('USE `FilmSphere`;\n\n')
        file.write('/*!SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0*/;\n')
        file.write('/*!SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0*/;\n')
        file.write('/*!SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE=\'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION\'*/;\n\n')
    
    for name in names:
        print('\tAppending \'' + name + '\' to bundle...')
        append_to_bundle(out_name, name)
    
    print('\tAppending last lines...')
    with open(out_name, 'a') as file:
        file.write('\n/*!SET SQL_MODE=@OLD_SQL_MODE*/;\n')
        file.write('/*!SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS*/;\n')
        file.write('/*!SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS*/;')
    print('Bundle \'' + out_name + '\' is ready!')
    

if __name__ == '__main__':
    if len(sys.argv) < 2:
        file_names = [
            'inserimenti-casuali.sql',
            'generi.sql',
            execute_script('area-contenuti'),
            execute_script('area-formato'),
            execute_script('area-utenti'),
            execute_script('area-streaming'),
            execute_script('ip-range')
        ]
    else:
        percentage = float(sys.argv[1])
        file_names = [
            'inserimenti-casuali.sql',
            'generi.sql',
            execute_script('area-contenuti', percentage=percentage),
            execute_script('area-formato', percentage=percentage),
            execute_script('area-utenti', percentage=percentage),
            execute_script('area-streaming', percentage=percentage),
            execute_script('ip-range')
        ]
    out_name = 'FilmSphere.sql'
    bundle_files(names=file_names, out_name=out_name)