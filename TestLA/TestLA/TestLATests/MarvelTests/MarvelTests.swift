@testable import TestLA
import XCTest


class MarvelTestCase: XCTestCase {
    
    func testGetMarvelShouldFailedCallbackIfError() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: nil, response: nil, error: FakeMarvelResponseData.error))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getMarvel { (succes, marvel) in
            XCTAssertFalse(succes)
            XCTAssertNil(marvel)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetMarvelShouldFailedCallbackIfNoData() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getMarvel { (succes, marvel) in
            XCTAssertFalse(succes)
            XCTAssertNil(marvel)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetMArvelShouldFailedCallbackIfIncorrectResponse() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: nil, response: FakeMarvelResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getMarvel { (succes, marvel) in
            XCTAssertFalse(succes)
            XCTAssertNil(marvel)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetMArvelShouldFailedCallbackIfIncorrectData() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: FakeMarvelResponseData.marvelIncorrectData, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getMarvel { (succes, marvel) in
            XCTAssertFalse(succes)
            XCTAssertNil(marvel)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetMArvelShouldFailedCallbackIfIncorrectDataAndResponseOK() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: FakeMarvelResponseData.marvelIncorrectData, response: FakeMarvelResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getMarvel { (succes, marvel) in
            XCTAssertFalse(succes)
            XCTAssertNil(marvel)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetMArvelShouldSuccesCallbackIfNoErrorAndCorrectData() {
        let marvelService = MarvelService(
            marvelSession: URLSesionFake(data: FakeMarvelResponseData.marvelCorrectData, response: FakeMarvelResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        marvelService.getMarvel { (succes, marvel) in
            let text = "Spider-Man"
            XCTAssertTrue(succes)
            XCTAssertEqual(text, marvel!.data.results[0].name)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
}
