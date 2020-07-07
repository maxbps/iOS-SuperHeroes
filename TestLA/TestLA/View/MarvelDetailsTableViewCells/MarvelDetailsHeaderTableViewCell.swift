import UIKit
import Foundation
import Kingfisher

class MarvelDetailsHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerBlackView: UIView!
    @IBOutlet weak var headerName: UILabel!
    
    func configureHeader(result: Result){
        headerBlackView.layer.opacity = 0.8
        if result.thumbnail.url == "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"{
            headerImage.image =  #imageLiteral(resourceName: "mysterion")
        }else if let url = URL(string: result.thumbnail.url) {
            headerImage.kf.setImage(with: url)
        } else {
            headerImage.image = nil
        }
        headerName.text = result.name
    }
}
