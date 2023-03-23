from sage.all import *

dihedral = DihedralGroup(1337)
dihedral_gen = dihedral.gens()[0]
dihedral_list = dihedral.list()
padder = 31337

enc = [277, 92, 775, 480, 160, 92, 31, 586, 277, 801, 355, 489, 801, 31, 62, 926, 725, 489, 160, 92,     31, 586, 277, 801, 355, 489, 1281, 62, 801, 489, 1175, 277, 453, 489, 453, 348, 725, 31, 348,     864, 864, 348, 453, 489, 737, 288, 453, 489, 889, 804, 96, 489, 801, 721, 775, 926, 1281, 631]

def unmap(index):
    return dihedral_list[index]

unmapped = [unmap(i) for i in enc]

def decrypt_byte(byte):
    for t in range(256):
        bits = bin(t * padder)[2:][::-1]
        answer = dihedral(())
        aggregator = dihedral(dihedral_gen)
        for bit in bits:
            if bit == "1":
                answer *= aggregator
            aggregator *= aggregator
        if answer == byte:
            return t

for b in unmapped:
    print(chr(decrypt_byte(b)), end="")
