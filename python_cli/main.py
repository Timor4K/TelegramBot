import utils.prints as prints
import utils.tools as menu
import utils.colors as color
import methods.polindrom as polindrom
import methods.armstrong as armstrong
import methods.digits as digits
import methods.lower as lower
import methods.nationalize as nationalize

while True:
    menu.cls()
    prints.print_ascii_banner("Python CLI")
    print(color.green + color.bold + "               Main Menu" + color.cln)
    print(color.green + color.bold + "=======================================" + color.cln)
    print("  [1]    Palindrome - Check if the input is a palindrome")
    print("  [2]    Lower - Check if all characters in the input are lowercase")
    print("  [3]    Digits - Check if all characters in the input are digits")
    print('  [4]    Armstrong - Check if the input is an "Armstrong Number"')
    print('  [5]    Nationalize - Check the nationality probability of a given first name.')
    print("  [6]    Exit\n")

    user_input = input("Select an option: ").lower()

    if user_input == '6':
        menu.exit_program()
    elif user_input == '1':
        menu.cls()
        prints.print_ascii_banner("Polindrom")
        num=input("Enter the input")
        poli = polindrom.palindrome_num(num)
        print(poli)
        if num is None:
            if menu.restart_program():
                continue
            else:
                menu.exit_program()
        else:
            if menu.restart_program():
                continue
            else:
                menu.exit_program()
    elif user_input == '2':
        menu.cls()
        prints.print_ascii_banner("Lower")
        string = input("Enter the input: ")
        output=lower(string)
        print(output)
        if string is None:
            if menu.restart_program():
                continue
            else:
                menu.exit_program()
        else:
            if menu.restart_program():
                continue
            else:
                menu.exit_program()

    elif user_input == '3':
        menu.cls()
        prints.print_ascii_banner("Digits")
        digi = input("Enter the input: ")
        output= digits(digi)
        print(output)

        if digi is None:
            if menu.restart_program():
                continue
            else:
                menu.exit_program()
        if menu.restart_program():
            continue
        else:
            menu.exit_program()
    elif user_input == '4':
        menu.cls()
        prints.print_ascii_banner("Armstrong")
        num = input("Enter the input: ")
        output = armstrong(num)
        print(output)
        if output is None:
            if menu.restart_program():
                continue
            else:
                menu.exit_program()
        if menu.restart_program():
            continue
        else:
            menu.exit_program()
    elif user_input == '5':
        menu.cls()
        prints.print_ascii_banner("Nationalize")
        name = input("Enter the input: ")
        output = nationalize(name)
        
        if output is None:
            if menu.restart_program():
                continue
            else:
                menu.exit_program()
        if menu.restart_program():
            continue
        else:
            menu.exit_program()

    else:
        prints.error("Invalid input, please select an option from the provided list")
        if menu.restart_program():
            continue
        else:
            menu.exit_program()