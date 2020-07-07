import UIKit
import Foundation
import Kingfisher
//le framework KingFisher permet de gerer plus facilement les requetes images

class MarvelTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var marvelImage: UIImageView!
     
    func configure(result: Result){
        blackView.layer.opacity = 0.8
        if result.thumbnail.url == "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"{
            marvelImage.image =  #imageLiteral(resourceName: "mysterion") //dans le cas ou c'est l'url de l'image "pas d'image associé"
        }else if let url = URL(string: result.thumbnail.url) {
            marvelImage.kf.setImage(with: url) //si c est une autre url alors je l'affiche
        } else {
            marvelImage.image = nil 
        }
        nameLabel.text = result.name
    }
}
