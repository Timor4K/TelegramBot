import os
import utils.prints as prints
import utils.colors as colors

def cls():
    os.system('cls' if os.name == 'nt' else 'clear')

def exit_program():
    cls()
    print('\n' + colors.bold + colors.cyan + 'Goodbye!' + colors.cln)
    quit()

def restart_program():
    while True:
        go_again = input(
            colors.magenta + colors.bold + "\nRestart Python Cli Project" + colors.cln + colors.grey + "(y/n)? " + colors.cln).lower()
        if go_again == 'y':
            result = True
            break
        elif go_again == 'n':
            result = False
            break
        else:
            prints.error("Invalid input, please use y/n")
    return result