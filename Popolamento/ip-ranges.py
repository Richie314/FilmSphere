def generate():
    with open('asn-country-ipv4.csv', 'r') as file_in:
        with open('popola-ip-range.sql', 'w') as file_out:
            sql = 'USE `FilmSphere`;\n'
            sql += 'INSERT INTO `IPRange` (`Paese`, `Inizio`, `Fine`) VALUES'
            old_line = ''
            file_out.write(sql)
            for line_in in file_in:
                #Ip Start, Ip End, Country code
                ip_start, ip_end, country_code = line_in.split(',')
                ip_start = ip_start.strip()
                ip_end = ip_end.strip()
                country_code = country_code.strip()
                #print(ip_start, ip_end, country_code)
                assert len(country_code) == 2
                this_line = '(\'' + country_code.upper() + '\', Ip2Int(\'' + ip_start +'\'), Ip2Int(\'' + ip_end + '\'))'
                if len(old_line) == 0:
                    # First time we write, no comma
                    old_line = '\n\t' + this_line
                else:
                    old_line = ',\n\t' + this_line
                file_out.write(old_line)
            file_out.write(';\n')

                

if __name__ == '__main__':
    generate()