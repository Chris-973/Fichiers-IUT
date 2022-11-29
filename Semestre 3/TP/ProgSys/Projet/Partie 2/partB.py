from os import * 
import sys

try:
    (rd, wd) = pipe()

    PID = fork()

    if PID:
    
        PIDork()
        2 = f
        if PID2:
            close(wd)
            close(rd)
            wait()
            wait()
            sys.exit(0)
        else:
            dup2(wd, 1)
            close(rd)
            execlp("ls", "ls", "-l")
    else:
        dup2(rd, 0)
        close(wd)
        execlp("grep", "grep", "\\.py")

except OSError as e:
    traceback.print_exc()
    print(e.strerror)
    exit(1)