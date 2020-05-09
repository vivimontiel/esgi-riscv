# Exercice 3
#
# Objectif: Additionner toutes les cases d'un tableau avec une boucle!
#
# A faire: complêter le programme à trou.
#
# Questions:
# 
# - Réussir à faire une boucle en assembleur.
# - Combien d'instructions sont telles faites au total avec votre boucle?
#   Reponse: 53 instructions au total :
#	Pre boucle: 9
#	Boucle: 5 x 8 + 1 = 41
#	Pre boucle: 3
#	TOTAL : 53 instructions

# Bonus:
# - Faire la boucle avec un compteur dans un exo 05_1_array_loop
# - Comment pourrions nous améliorer les performances de la boucle?
#   Documentez vous et proposez des solutions en citant les sources
#   pour les techniques que vous avez trouver.

.data

size_array_g: .word 8
array_g: .word 124, 256, 512, 2, 8, 4, 32, 1024

.text

###
# Méthode avec une boucle
###

la t0, size_array_g # t0: size <- *size_array
lw t0, 0(t0) # t0 <- *size_array; t0 = taille du tableau

# Il nous faut un registre pour la somme
# a0: sum <- 0
li a0, 0

# Pour faire une boucle il nous faut l'addresse de base du tableau
la t1, array_g

# Et calculer l'addresse de fin
# Une solution alternative est d'utiliser un registre pour faire
# un compteur de 0 à N taille du tableau (les deux me vont) :)
# Attention a pas melanger les deux solutions.
slli t0, t0, 2  # On multiplie par 4 pour respecter l'allignement 
add  t2, t1, t0 # On obtiens l'addresse de fin en fesant addrBase + size_array * 4

# On copie l'addresse de début pour avoir un itérateur qu'on
# Pourras incrémenter.
# t3 = @addrIterator
mv t3, t1

# Un label pour le début de la boucle
for:
  ##
  # Écrire une condition pour savoir si on continue la boucle.
  # Si le test réussi on sort de la boucle en sautant à end_for
  # pseudo codte
  # si addresse de fin = addresse courante alors stop sinon continue
  # Instruction: beq
  ##
  beq t3, t2, end_for
  ##
  # On charge depuis la mémorie la valeur à l'addresse courante dans notre tableau
  # et additionne a notre somme
  # Instruction: Indice chargement mémoire mot 32bits
  ##
  lw t4, 0(t3)
  ##
  # Addition entre la valeur de la case du tableau et notre somme.
  # Instruction: Indice Addition entre deux registres sans immédiat
  ##
  add a0, a0, t4
  ##
  # Increment de l'addresse du tableau
  # Instruction addi, attention rappel: 
  # entiers sur 32bits donc on index de 4 en 4.
  ##
  addi t3, t3, 4 # On addresse de 4 en 4 car on est sur des mots de 32bits.
  ###
  # On saute au début de la boucle pour tester si on continue.
  ###
  j for # On continue!
  # Un label pour la sortie de boucle

end_for:

li a7, 1  # numéro syscall	resultat_g: 380
add a0, a0, zero   # load desired value into argument register a0, using pseudo-op  
ecall 
# Affichez la somme ici!
# A faire par vous totalement:
# Afficher nos deux nombres dans la console
# indice: syscall printInt
