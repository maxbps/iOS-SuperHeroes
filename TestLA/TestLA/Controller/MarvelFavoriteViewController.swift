import UIKit
import CoreData

class MarvelFavoriteViewController: UIViewController {
    
    var marvelService = MarvelService()
    var heroes: [Hero] = []
    var marvelResponse: [Result] = []
    
    @IBOutlet weak var marvelTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heroes = Hero.all
        if Hero.all.count == 0 {
            //Afin d'avoir une instruction pour l'utilisateur dans le cas ou aucun favori n'est present
            presentAlert(message: "No favorite yet")
        }
        marvelTableView.reloadData()
    }
}

    // MARK: - Extension UITableViewDatasource, UITableViewDelegate
extension MarvelFavoriteViewController: UITableViewDataSource, UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell else {
            print("erreur")
            return UITableViewCell()
        }
        let hero = heroes[indexPath.row]
        cell.configure(image: hero.picture!, name: hero.name!)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Hero.all.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            AppDelegate.viewContext.delete(heroes[indexPath.row])
            try? AppDelegate.viewContext.save()
            heroes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
//Cette fonction permet de faire une action quand l'utilisateur appuie sur une cellule
//Je l'ai utilisé afin de securisé le prepare for segue et m'assurer de bien faire la requete avant le changement de vue ( puisque sinon la vue change avant qu'il y ai eu le temps de lancer la requete)
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = self.marvelTableView.indexPathForSelectedRow else { return }
        MarvelURL.parameters = ""
        MarvelURL.idURL = "/" + String(Int(heroes[indexPath.row].id))
        marvelService.getMarvel { (success, marvelResponseJSON) in
            guard let marvel = marvelResponseJSON else {
                self.presentAlert(message: "Error with the response, please try later")
                print("error translateResponseJson")
                return
            }
            self.marvelResponse = marvel.data.results
            self.performSegue(withIdentifier: "marvelDetailsFromFavorite", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "marvelDetailsFromFavorite"{
            let succesVC = segue.destination as! MarvelDetailsViewController
            succesVC.marvelDetail = self.marvelResponse.first
        }
    }
}

