import Foundation
//Structure qui correspond a la reponse d'une personnage getMarvel()
struct MarvelInfo: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let urls: [URLElement]
    let comics: Comics
    let series: Comics
    let events: Comics
    let stories: Comics
}

struct Thumbnail: Codable {
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

struct URLElement: Codable {
    let type: String
    let url: String
}

struct Comics: Codable {
    let collectionURI: String
}
