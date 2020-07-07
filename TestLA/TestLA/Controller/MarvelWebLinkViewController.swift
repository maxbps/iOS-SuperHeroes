import UIKit
import WebKit

class MarvelWebLinkViewController: UIViewController {
    
    var marvelDetail: Result!
    

    @IBOutlet weak var marvelWebView: WKWebView!
    @IBOutlet weak var marvelActivityIndicator: UIActivityIndicatorView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            let url = URL(string: marvelDetail.urls.first!.url)
            let request = URLRequest(url: url!)
            title = marvelDetail.name
            marvelWebView.navigationDelegate = self
            marvelWebView.load(request)
        }
    }

    extension MarvelWebLinkViewController: WKNavigationDelegate {
        func webView(_ WebView: WKWebView, didFinish navigation: WKNavigation!) {
            //stop l'animation de l'indicateur d'activité
            //l'indicateur d'activité est utilisé pour une meilleure experience utilisateur
            marvelActivityIndicator.stopAnimating()
        }
    }
