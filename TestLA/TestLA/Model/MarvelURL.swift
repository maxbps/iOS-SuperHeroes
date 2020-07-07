import Foundation
//Structure qui contient les parties d'URL permettant de lancer les requetes personnages, comics, events et stories
struct MarvelURL {
    
    static let marvelURL = "http://gateway.marvel.com/v1/public/characters"
    static var comicURL = ""
    static let key = "?ts=1&apikey=e6e7953b8f47630c9a4fef0532b649cd&hash=5f7a18fdf9a83c7a277503d9e8e60a75"
    static var parameters = "" //&nameStartsWith=spider-man
    static var idURL = ""
}
