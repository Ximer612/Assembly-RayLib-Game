import os

os.system(' "e:/Documenti/AIV 3 ANNO/On My Cpu/NASM/nasm.exe" -o ./game.bin -f win64  ./game.S ')

os.system(' D:/Users/Ximer/AppData/Local/Programs/Python/Python310/python.exe ".\game.py" .\game.bin .\game.exe')

os.system('.\game.exe')