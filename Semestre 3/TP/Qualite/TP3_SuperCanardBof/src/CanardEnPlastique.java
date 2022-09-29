
/**
 * @author bruel
 *
 */

public class CanardEnPlastique extends Canard {

	@Override
	public void afficher() {
		System.out.println("Je suis un CanardEnPlastique!");
	}

	@Override
	public void voler() {
		//Ne rien faire, ou alors dire System.out.println("Je ne vole pas!");
	}
}
