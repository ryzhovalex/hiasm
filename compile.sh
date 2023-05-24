#!/bin/bash
if [ -z $1 ]; then
    echo "Usage: ./asm64 <asmMainFile> (no extension)"
    exit
fi

if [ ! -e "src/$1.asm" ]; then
    echo "Error, $1.asm not found."
    echo "Note, do not enter file extensions."
    exit
fi

yasm -Worphan-labels -g dwarf2 -f elf64 -o obj/debug/$1.o -l obj/debug/$1.lst src/$1.asm && ld -g -o bin/debug/$1 obj/debug/$1.o
