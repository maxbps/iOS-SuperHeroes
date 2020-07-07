import Foundation

class FakeComicsResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http//uneadresse")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http//uneadresse")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    class ComicsError: Error{}
    static let error = ComicsError()
    
    static var comicsCorrectData: Data {
        let bundle = Bundle(for: FakeComicsResponseData.self)
        let url = bundle.url(forResource: "Comics", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let comicsIncorrectData = "kjhibcdkljsnv".data(using: .utf8)!
}

