# Exercice 2
# Notions:
#
# Pouvoir faire un saut conditionnel dans un programme ici
# tester l'egalité entre deux registres.
# Effectuer un branchement conditionnel puis non conditionnel.
# Puis afficher un message selon le résultat.

# Objectif du programe:
#
# Assigner des nombres dans des registres:
# - `t0` <- 5
# - `t1` <- 4
#
# Corriger les lignes avec des `???`.
.data

msg_eq: .asciz "Ces nombres sont egaux!"
msg_neq: .asciz "Ces nombres ne sont pas egaux"

.text

# En rust on aurais surement fait un truc du genre
# ```rust
# let a = 4;
# let b = 5;
# let msg = if a == b { "Ces nombres sont egaux!" } else { "Ces nombres ne sont pas egaux" };
# println!(msg);
# ```

### Ici à vous de jouer utiliser
# deux instructions à écrire pour charger 5 dans t0 et t1 dans 4.

# début du programme.
main:
li t0, 4
li t1, 5

# "bne" Branch if Not Equals: Saute si nos registres ne sont pas égaux.
bne t0, t1, not_eq # if t0 != t1 jump not_eq

# Cas égaux t0 == t1
la a0, msg_eq # msg <- "Ces nombres sont egaux!"
j end # On a fini donc on peut sortir du if.

# Cas Inégaux t0 != t1
not_eq:
la a0 msg_neq # msg <- "Ces nombres ne sont pas egaux"
j end

end:

# Affichage:
#
# Ici on souhaite afficher sur la console via un appel système.
# inspirez vous de l'exercice 01_syscall, le registre a0 doit contenir
# le numéro du syscall printString: 4 et a7 la chaine à afficher.

li a7, 4  # numéro syscall
ecall     # Quelle instruction doit-on utiliser pour faire un syscall?
