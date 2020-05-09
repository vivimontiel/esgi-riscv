# Exercice 3
#
# Objectif: Jouer avec des entiers dans la mémoire pour commencer!
#
# A faire: complêter le programme à trou.
#
# Questions:
# 
# - Quelle est l'addresse de `num0`, `num1`, `resultat`?
#	num0: 0x10010000	num1: 0x10010004	resultat: 0x10010008
# - La dernière addresse du code votre programme
#	ecall : 0x00000073
# - Comment est coté en langage machine (hexadecimal) l'instruction: `lw  t1, 0(t0)`
#	0x0002a303
# - La mémoire est-elle dans le processeur?
#	Oui, il y a des petites unités de mémoire disposées dans le processeur qui sont les registres (merci Readme du cours :D )
# - Quand on accede à la mémoire par mots de 32 bits est accessible de combien en combien?
#	De 4 en 4
# - Quelle est la valeur dans la mémoire de la valeur à l'addresse `num0`
#    	hexa: 0x0000007c	decimal: 124
# Imagions un programme en C comme celui-ci: (dispo dans 03_memoire.c)
#
# ```C
# // On demande au compilateur de *pas optimiser* les
# // acces mémoires avec `volatile`.
# // En embarqué ou kernel c'est parfois indispensable.
# // Le reste du temps c'est contre-productif. ;)
# // `static` indique la variable est locale au fichier.
# static volatile int32_t num0 = 124;
# static volatile int32_t num1 = 256;
# static volatile int32_t result_g = 0;
#
# void main(void) {
#   // Notez que votre langage cache ici l'usage de pointeurs,
#   // en réalité on manipule de la mémoire ici.
#   // surtout si aucune optimisation a lieu.
#   result_g = num0 + num1;
# }
#```
# On déclare deux nombres de 32 bits dans la *mémoire*
# .word permet de specifier qu'on veux un mot de 32bits.

.data
# /!\ Attention! ce sont des variables globales en mémoire! /!\
num0_g: .word 124
num1_g: .word 256

# On souhaite charger le resultat de l'addition dans la memoire a
# l'adresse resultat:
resultat_g: .word 0

.text

main:

# ??? <- @num0
la t0, num0_g
# load word depuis l'addresse 0 + register dans le register t1
lw  t1, 0(t0)

# t2 <- @num1
la  t2, num1_g
# Quelle instruction permet de charger un mot mémoire?
lw t3, 0(t2)

# chargement de l'addresse du resultat.
la t4, resultat_g
# fait l'addition entre nos deux registres dans un registre.
add t5, t3, t1
# store word, stock le contenu du registre dans l'addresse à 0 + t4
sw t5, 0(t4)

# A faire par vous totalement:
# Afficher nos deux nombres dans la console
# indice: syscall printInt

li a7, 1  # numéro syscall	Prints: num0_g: .word 124
add a0, t1, zero   # load desired value into argument register a0, using pseudo-op
ecall 
 
li a7, 1  # numéro syscall	Prints: num1_g: .word 256
add a0, t3, zero   # load desired value into argument register a0, using pseudo-op  
ecall 

li a7, 1  # numéro syscall	Prints: resultat_g: 380
add a0, t5, zero   # load desired value into argument register a0, using pseudo-op  
ecall 


