# Exercice 0
# Faire une addition dans un registre

.text # <- segment de code.

# Exercice:
# On veux obtenir le nombre 64 modifier le code pour pouvoir avoir 64
# dans t0 à la fin du programme.

# Questions: C'est quoi un registre? (mettre un x dans la bonne réponse
#
# - [X] Une mémoire dans le processeur de 32 bits
# - [ ] Une variable dans la mémoire

mon_code: # <- Label
li   t0, 32 #load imediate: Charge un nombre sur max 12 bit dans un registre
addi t0, t0, 32 #Additionne operand1 un immediat et stock le resultat dans destination
#     |   \ operand1 
#  destination

# Bonus: avoir 64 dans un registre en une seule instruction
 
# li t3, 4294967295 #numero max sur 32bits

li t1, 64 #la plus simple et cool :)

addi t2, zero, 32
add t2, t2, t2 #addition entre op1 (t2); op(t2); on stock dans t2