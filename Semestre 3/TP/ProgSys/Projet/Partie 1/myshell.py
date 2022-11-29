
import os


cmd = input('$ ')

# Tant que l'utilisateur ne rentre pas la commande exit le programme continue
while cmd != 'exit':

	# vérifie que la commande entrer par l'utilisateur contient bien des arguments 
	if cmd.strip() != '':
		#  récupération des arguments de la commandes en les séprant lorsqu'un espaces est rencontré
		args = cmd.split(' ')

		# vérifie si le dernier argument de la commande est &
		if args[-1] == '&':
			# on le suprimme de la liste des arguments
			args = args[:-1]
			# on initialise la variable background à True
			background = True
		# si ce n'est pas le cas
		else:
			# on initialise la variable background à False
			background = False

		# on créer un sous-processus qui s'occupera de l'exécution
		pid = os.fork()
		# vérifie que nous sommes dans le processus appelant
		if pid:
			
			if not background:
				# attente de la fin du processus fils
				codes = os.wait()
				
				while codes[0] != pid:
					
					codes = os.wait()
				
				exit_code = codes[1] // 256
				
				print(f'Processus {codes[0]} terminé avec le code de retour {exit_code}')
		# sinon si on est dans le processus appelé
		else:
			# on tente d'exécuter la commande demandée
			try:
				os.execvp(args[0], args)
			
			except OSError as e:
				# si une exception se produit on affiche un message d'erreur et on renvoit au processus appelant le code d'erreur
				print('Erreur lors de l\'appel :', e.strerror)
				os._exit(e.errno)


	cmd = input('$ ')


