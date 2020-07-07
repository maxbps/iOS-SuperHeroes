import UIKit
import Foundation
import Kingfisher

class MarvelDetailsFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var footerImage: UIImageView!
    @IBOutlet weak var footerTitle: UILabel!
    @IBOutlet weak var footerDescription: UILabel!
    
  
    func configureFooter(result: ComicResult){
        if result.thumbnail.url == "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"{
            footerImage.image =  #imageLiteral(resourceName: "mysterion")
        }else if let url = URL(string: result.thumbnail.url) {
            footerImage.kf.setImage(with: url)
        } else {
            footerImage.image = nil
        }
        footerTitle.text = result.title
        footerDescription.text = result.description
    }

}
