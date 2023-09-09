

if __name__ == "__main__":
    
    with open('tmp1.txt', 'r') as f:

        try:
            while True:
                line = next(f)
                cols = line.split(',')
                durata = 60 * int(cols[4].strip())
                n_line = f'{cols[0]},{cols[1]},{cols[2]},{cols[3]},{durata},{cols[5]},'
                print(n_line)
        except StopIteration:
            pass
