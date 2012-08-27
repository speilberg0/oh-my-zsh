#!/bin/python

def explain():
    print "Usage: bar.py STRING REPEAT"
    print "Usage: bar.py REPEAT"
    print "  * STRING: string to repeat"
    print "  * REPEAT: number of repetitions"
    return


def main(args):
    default_str = '-'

    if len(args) == 0:
        return explain()
    elif len(args) == 1:
        try:
            print default_str * int(args[0])
        except ValueError:
            explain()
    elif len(args) == 2:
        try:
            print args[0] * int(args[1])
        except ValueError:
            explain()


if __name__ == '__main__':
    import sys
    main(sys.argv[1:])
