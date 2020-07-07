import Foundation
import UIKit

extension UIViewController {
    // use case example : self.presentAlert(message: .errorIngredientneeded)
    //permet de gerer les alertes plus simplement dans les viewControllers
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Alerte", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension UIView{
    // convertit une UIView en UIImage
    func convertInImage(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: (image?.cgImage)!)
    }
}
    // MARK: - Extensions utiles en commentaire

/*
 extension UIView{
     // I use this function for the aesthetic of my views
     func addShadow(whiteView: UIView){
         whiteView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
         whiteView.layer.shadowRadius = 2.0
         whiteView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
         whiteView.layer.shadowOpacity = 2.0
         whiteView.layer.cornerRadius = 25.0
         
     }
 }
 
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
//recipeDetailImageView.downloaded(from: urlImage)
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async() {
                        self.image = image
                    }
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
}
*/

