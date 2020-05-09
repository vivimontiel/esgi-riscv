# Exercice 3

.data

# array: [1, 2, 3]
array_g: .word 124, 256, 512, 2, 8, 4, 32, 1024
size_array_g: 8

.text

main: 

#Preparer les arguments pour increment_array
#a0 : contient l'adresse du tableau 
la a0, array_g
		
# a1: contient la taille du tableau		
la a1, size_array_g 	# On recupere l'adresse de size_array_g dans a0
lw a1, 0(a1)	# On charge la valeur qui est a l'adresse de size

# Sauter dans la fonction increment_array
jal increment_array

##Call to exit syscall
li a7, 10
ecall
#Le programme s'arrete


# Fonction increment_array
# Arguments : 
# a0 : adresse du tableau a incrémenter 
# a1 : taille du tableau
#
# Return
# a0: return base address of array.
#
## Registres utilisées par la fonction:
# - t0: index sur le tableau
# - t1: a0[i] a l'itérateur du tableau
# - t2: addresse de base + index
increment_array:
 
li t0, 0 # index = 0
li t3, 0 # somme = 0
 
# Itérer sur notre array 
# - stop si fin du tableau
# - charger la valeur de a[i] dans t1
# - faire t1 = t1 + 1 
# - recharger t1 dans a[i]

for:
# stop si index >= size
beqz a1, end_for
add t2, a0, t0 # array + index : array[i]
# t1 <- a[i]
lw t1, 0(t2)

add t3, t3, t1

# t1 = t1 + 1
addi t1, t1, 1

# a[i] <- t1
sw t1, 0(t2)

# index + 1
addi t0, t0, 4 # index++   ## si on a un tableau a = [0, 1, 2] pour aller a a[0] c'est a + 0; a[1] = a + 4; a[2] a + 8
addi a1, a1, -1
j for

end_for:
## End increment_array

li a7, 1  # numéro syscall	resultat_g: 380
add a0, t3, zero   # load desired value into argument register a0, using pseudo-op  
ecall 

jr ra  	# ra : return address register , ça perment de sauvegarder le retour d'une fonction 
