
import UIKit
import CoreData

class MarvelDetailsViewController: UIViewController {
    
    var marvelService = MarvelService()
    var marvelDetail: Result!
    var comicsToDisplay: ComicInfo!
    var isHeroAlreadySaveBool: Bool = false
    var index = 0
    
    override func viewWillAppear(_ animated: Bool) {
        request(url: marvelDetail.comics.collectionURI)
        isHeroAlreadySave()
        self.detailTableView.reloadData()
    }
    
    @IBOutlet var allViews: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    
    //Afin de faire la bonne requete en fonction du segmentedControl
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: request(url: marvelDetail.comics.collectionURI)
        case 1: request(url: marvelDetail.series.collectionURI)
        case 2: request(url: marvelDetail.events.collectionURI)
        default:
            break
        }
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let imageToShare = allViews.convertInImage(allViews)
        let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(activityVC, completed, returnedItem, error) in
        }
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func linkButton(_ sender: UIButton) {
        performSegue(withIdentifier: "marvelLink", sender: self)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        saveHero(heroId: marvelDetail!.id, heroName: marvelDetail.name, heroPicture: marvelDetail!.thumbnail.url)
    }
    
    func request(url: String){
        MarvelURL.comicURL = url
        marvelService.getComics { (success, comicResponseJSON) in
            guard let comic = comicResponseJSON else {
                self.presentAlert(message: "Error with the response, please try later")
                print("error")
                return
            }
            self.comicsToDisplay = comic
            self.detailTableView.reloadData()
        }
    }
    
    //fonction qui sauvegarde ou supprime une entité de la memoire
    func saveHero(heroId: Int, heroName: String, heroPicture: String){
        isHeroAlreadySave()
        switch isHeroAlreadySaveBool{
        case true:
            AppDelegate.viewContext.delete(Hero.all[index])
            isHeroAlreadySaveBool = false
        case false:
            let hero = Hero(context: AppDelegate.viewContext)
            hero.id = Int32(heroId)
            hero.name = heroName
            hero.picture = heroPicture
            isHeroAlreadySaveBool = true
        }
        try? AppDelegate.viewContext.save()
        detailTableView.reloadData() //Pour modifier l'apparance du boutton saveButton
    }
    
    //fonction qui check si il y a deja une entite de sauvegarde
    func isHeroAlreadySave(){
        var count = -1
        isHeroAlreadySaveBool = false
        for coreHero in Hero.all {
            count += 1
            if coreHero.id == marvelDetail.id{
                index = count
                isHeroAlreadySaveBool = true
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "marvelLink"{
            let succesVC = segue.destination as! MarvelWebLinkViewController
            succesVC.marvelDetail = marvelDetail
        }
    }
    
}

// MARK: - Extension UITableViewDatasource
extension MarvelDetailsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let marvel = marvelDetail else {
            print("erreur")
            return UITableViewCell() }
        guard let comic = comicsToDisplay else{
            return UITableViewCell()}
        
        //configuration de la premiere cellule
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as? MarvelDetailsHeaderTableViewCell else {
                return UITableViewCell()
            }
            cell.configureHeader(result: marvel)
            return cell
        }
        //configuration de la deuxieme cellule
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "middleCell", for: indexPath) as? MarvelDetailsMiddleTableViewCell else {
                return UITableViewCell()
            }
            cell.configureMiddle(result: marvel, isHeroalreadySave: isHeroAlreadySaveBool)
            return cell
        }
        //configuration des autres cellules
        if indexPath.row > 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as? MarvelDetailsFooterTableViewCell else {
                return UITableViewCell()
            }
            cell.configureFooter(result: comic.data.results[indexPath.row - 2])
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comic = comicsToDisplay else { return 0 }
        return comic.data.results.count + 2 //+2 car il y a deux cellules autres que les comics
    }
}



