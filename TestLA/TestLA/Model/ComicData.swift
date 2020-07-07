import Foundation
//Structure qui correspond a la reponse d'une requete comics,events et stories getComics()
struct ComicInfo: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

struct DataClass: Codable {
    let results: [ComicResult]
}


struct ComicResult: Codable {
    
    let title: String
    let description: String?
    let thumbnail: ComicThumbnail
    
}

struct ComicThumbnail: Codable {
    let path: String
    let ext: String

    var url: String {
        return path + "." + ext
    }

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }

}

