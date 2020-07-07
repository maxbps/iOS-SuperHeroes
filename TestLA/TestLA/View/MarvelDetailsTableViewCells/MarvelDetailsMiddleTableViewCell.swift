import UIKit
import Foundation
import Kingfisher

class MarvelDetailsMiddleTableViewCell: UITableViewCell {
    @IBOutlet weak var middleDescription: UILabel!
    @IBOutlet weak var segmentedControlComics: UISegmentedControl!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    func configureMiddle(result: Result, isHeroalreadySave: Bool){
        middleDescription.text = result.description
        switch isHeroalreadySave{
        case true: saveButton.setImage(KFCrossPlatformImage(systemName: "heart.fill"), for: .normal)
        case false: saveButton.setImage(KFCrossPlatformImage(systemName: "heart"), for: .normal)
        }
        
    }

}
