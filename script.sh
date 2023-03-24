#!/bin/bash

read -p "Выберите способ резервного копирования dd, tar или git: " METHOD

read -p "Введите путь/имя файла, которое нужно заархивировать: " SOURCE

read -p "Введите время запуска скрипта: 1 - каждый час, 2 - каждый день, 3 - каждую неделю " PERIODICITY


case $METHOD in
        dd)
                read -p "Введите место назначения архива " DESTINATION
                dd if=$SOURCE of=$DESTINATION
                ;;
        tar)
                read -p "Ведите имя архива " NAME
                tar -cf $NAME.tar $SOURCE
                ;;
        git)
                git add $SOURCE
                git commit -m"backup $SOURCE"
                git push origin main
                ;;
esac

case $PERIODICITY in
        1)
                at now + 1 hour -f $0
                ;;
        2)
                at now + 1 day -f $0
                ;;
        3)
                at now + 1 week -f $0
                ;;
esac
