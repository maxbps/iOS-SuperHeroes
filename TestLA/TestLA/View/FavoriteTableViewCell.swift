import UIKit
import Foundation
import Kingfisher
//le framework KingFisher permet de gerer plus facilement les requetes images

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var marvelImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(image: String, name: String){
        if image == "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"{
            marvelImage.image =  #imageLiteral(resourceName: "mysterion") //dans le cas ou c'est l'url de l'image par defaut "pas d'image associé"
        }else if let url = URL(string: image) {
            marvelImage.kf.setImage(with: url) //si c est une autre url alors je l'affiche
        } else {
            marvelImage.image = nil
        }
        marvelImage.layer.cornerRadius = marvelImage.frame.size.height / 2
        marvelImage.layer.borderColor = UIColor.red.cgColor
        marvelImage.layer.borderWidth = 2
        nameLabel.text = name
    }
}
