#! /usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright © 2014 Roman Bulakh <bulah.roman@gmail.com>

u""" Скрипт для произведения сквозного подключения к серверам, или же виртулкам. """

import pexpect
import os
import argparse

global pars

u""" Парсинг аргументов передаваемых скрипту. """
pars = argparse.ArgumentParser(description="Сквозной доступ для Mirohost", epilog="Для корректного подключения, нужно отключить авторизацию по паролям")
pars.add_argument("host", metavar="Host", type=str, help="Виртуалка для подключения")
arg = vars(pars.parse_args())

def main():
    u""" Основная функция, которая проверяет хост, на котором запускается данный скрипт. """
    global connection, noc
    if arg['host']:
        #work = os.uname()
        #if work[1] == 'noc.mirohost.net':
        #    connection = 'ssh -t '
        #    noc = True
        #else:
        noc = False
        connection = 'TERM=rxvt ssh -p 2211 -t noc ssh -t '
        connect()
    else:
        pars.print_help()

def connect():
    u""" Производим подключение к рутовой ноде, или же виртуалке. """
    connect = traceroute(arg['host'])
    if len(connect) == 2:
        host = connect[-1].split()[1].decode()
        if host == 'noc.mirohost.net':
            print("Повторное подключение к NOC")
        elif host.startswith('kuper'):
            os.system(connection + host + ' sudo -s')
        else:
            print("Данное подключение не предусметрено.")
    elif len(connect) == 3 and noc:
        host = connect[-1].split()[1].decode()
        if host == 'tiger.mirohost.net':
            os.system(connection + host)
        else:
            os.system(connection + host + ' sudo -s')
    elif len(connect) == 4:
        if noc:
            root = connect[-2].split()[1].decode()
            host = connect[-1].split()[1].decode()
            vs = host.split(".")
            try:
                if os.system(connection + root + ' sudo /usr/sbin/vzctl enter ' + vs[0]):
                    raise NameError('Connection not establisht')
            except NameError:
                print("Вход в VM не удался, переход к рутовой ноде:")
                os.system(connection + root + ' sudo -s')
        else:
            host = connect[-1].split()[1].decode()
            if host == 'noc.mirohost.net':
                os.system('TERM=rxvt ssh -p 2211 ' + host)
            else:
                os.system(connection + host + ' sudo -s')
    elif len(connect) == 5 and not noc:
        root = connect[-2].split()[1].decode()
        host = connect[-1].split()[1].decode()
        vs = host.split(".")
        try:
            if os.system(connection + root + ' sudo /usr/sbin/vzctl enter ' + vs[0]):
                raise NameError('Connection not establisht')
        except NameError:
            print("Вход в VM не удался, переход к рутовой ноде:")
            os.system(connection + root + ' sudo -s')
    else:
        print("Неправильный вывод Traceroute, проверьте подключение к сети, или имя сервера.")

def traceroute(host):
    u""" Парсим трасировку маршрута к хосту. """
    tracert = pexpect.spawn('traceroute -4 ' + host)
    line = tracert.readlines()
    return line

if __name__ == "__main__":
    main()
