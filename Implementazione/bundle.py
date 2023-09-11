def bundle():
    with open('Bundle.sql', 'w') as out:
        with open('AreaContenuti.sql', 'r') as file:
            for line in file:
                out.write(line)
        with open('AreaFormato.sql', 'r') as file:
            for line in file:
                out.write(line)
        with open('AreaUtenti.sql', 'r') as file:
            for line in file:
                out.write(line)
        with open('AreaStreaming.sql', 'r') as file:
            for line in file:
                out.write(line)


if __name__ == '__main__':
    bundle()