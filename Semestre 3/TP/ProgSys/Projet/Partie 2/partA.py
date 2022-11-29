from os import * 
import sys

try:
    fic = open(sys.argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0o644)

    buffer = read(0, 255)

    while len(buffer):
        write(fic, buffer)
        buffer = read(0, 255)

    close(fic)

except OSError as e:
    traceback.print_exc()
    print(e.strerror)
    exit(1)