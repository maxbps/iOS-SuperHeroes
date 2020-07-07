@testable import TestLA
import XCTest


class ComicsTestCase: XCTestCase {
    
    func testGetComicsShouldFailedCallbackIfError() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: nil, response: nil, error: FakeComicsResponseData.error))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getComics { (succes, comics) in
            XCTAssertFalse(succes)
            XCTAssertNil(comics)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetComicsShouldFailedCallbackIfNoData() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getComics { (succes, comics) in
            XCTAssertFalse(succes)
            XCTAssertNil(comics)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetComicsShouldFailedCallbackIfIncorrectResponse() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: nil, response: FakeComicsResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getComics { (succes, comics) in
            XCTAssertFalse(succes)
            XCTAssertNil(comics)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetComicsShouldFailedCallbackIfIncorrectData() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: FakeComicsResponseData.comicsIncorrectData, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getComics { (succes, comics) in
            XCTAssertFalse(succes)
            XCTAssertNil(comics)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetComicsShouldFailedCallbackIfIncorrectDataAndResponseOK() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: FakeComicsResponseData.comicsIncorrectData, response: FakeComicsResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getComics { (succes, comics) in
            XCTAssertFalse(succes)
            XCTAssertNil(comics)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetComicsShouldSuccesCallbackIfCorrectDataAndResponseOK() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: FakeComicsResponseData.comicsCorrectData, response: FakeComicsResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getComics { (succes, comics) in
            let text = "Amazing Spider-Man (1999) #558 (Turner Variant)"
            XCTAssertTrue(succes)
            XCTAssertEqual(text, comics?.data.results[0].title)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }


}
