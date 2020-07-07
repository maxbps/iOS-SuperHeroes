import Foundation

class MarvelService {
    
    //Injection de dependance
    var task: URLSessionDataTask?
    private var marvelSession: URLSession
    
    init(marvelSession: URLSession = URLSession(configuration: .default)) {
        self.marvelSession = marvelSession
    }
    // MARK: - getMarvel
    //fonction qui permet de lancer une requete pour obtenir les personnages
    func getMarvel(callback: @escaping (Bool, MarvelInfo?) -> Void) {
        let marvelUrlInString = MarvelURL.marvelURL + MarvelURL.idURL + MarvelURL.key + MarvelURL.parameters
        guard let url = URL(string: marvelUrlInString) else { return }
        
        task?.cancel() // to cancel a task before a new request
        task = marvelSession.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            guard let marvelResponseJSON = try? JSONDecoder().decode(MarvelInfo.self, from: data) else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            DispatchQueue.main.async {
                callback(true, marvelResponseJSON)
            }
        }
        task?.resume()
    }
    // MARK: - getComics
    //fonction qui permet de lancer une requete qui permet d'obtenir les comcis, events et stories
    func getComics(callback: @escaping (Bool, ComicInfo?) -> Void) {
        let marvelUrlInString = MarvelURL.comicURL + MarvelURL.key
        guard let url = URL(string: marvelUrlInString) else { return }
        
        task?.cancel() // to cancel a task before a new request
        task = marvelSession.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            guard let comicResponseJSON = try? JSONDecoder().decode(ComicInfo.self, from: data) else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            DispatchQueue.main.async {
                callback(true, comicResponseJSON)
            }
        }
        task?.resume()
    }
}

