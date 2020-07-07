import Foundation

class FakeMarvelResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http//uneadresse")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http//uneadresse")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    class MarvelError: Error{}
    static let error = MarvelError()
    
    static var marvelCorrectData: Data {
        let bundle = Bundle(for: FakeMarvelResponseData.self)
        let url = bundle.url(forResource: "Marvel", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let marvelIncorrectData = "kjhibcdkljsnv".data(using: .utf8)!
}
