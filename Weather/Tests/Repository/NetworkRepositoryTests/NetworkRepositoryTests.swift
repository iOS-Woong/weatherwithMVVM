//
//  NetworkRepositoryTests.swift
//  NetworkRepositoryTests
//
//  Created by 서현웅 on 2023/06/02.
//

import XCTest
@testable import Weather

final class NetworkRepositoryTests: XCTestCase {
    var sut: NetworkRepository!
    
    override func setUpWithError() throws {
        sut = NetworkRepository()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: Success Case
    func test_request로_요청했을때_응답_stringDummy를_정상적으로_받아오는지() {
        // given
        let promise = expectation(description: "testDouble: Success")
        let url = URL(string: "stubEndPoint")!
        let data = "stringDummy".data(using: .utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummyData: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.request(url: url) { result in
            switch result {
            case .success(let data):
                let stringData = String(data: data, encoding: .utf8)
                XCTAssertEqual(stringData, "stringDummy")
                promise.fulfill()
            case .failure(let networkError):
                XCTFail(networkError.localizedDescription)
            }
        }
        wait(for: [promise], timeout: 10)
    }
    
    // MARK: Failure Case
    
    // NetworkError 00. invalidURL
    func test_request_url을_nil로_요청했을때_응답이_invalidURL로_실패하는지() {
        // given
        let promise = expectation(description: "testDouble: Failure_invalidURL")
        let url: URL? = nil
        let stubUrlSession = StubURLSession()
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.request(url: url) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                // then
                print(error)
                XCTAssertEqual(error, NetworkError.invalidURL)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
    }
    
    // NetworkError 01. invalidResponse
    func test_request_response를_nil로_전달받을때_응답이_invalidResponse로_실패하는지() {
        // given
        let promise = expectation(description: "testDouble: Failure_invalidResponse")
        let url = URL(string: "stubEndPoint")
        let data = "stringDummy".data(using: .utf8)
        let response: HTTPURLResponse? = nil
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummyData: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.request(url: url) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.invalidResponse)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
    }
    
    // NetworkError 02. invalidData
    func test_request_data를_nil로_전달받을때_응답이_invalidData로_실패하는지() {
        // given
        let promise = expectation(description: "testDouble: Failure_invalidData")
        let url = URL(string: "stubEndPoint")!
        let data: Data? = nil
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummyData: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.request(url: url) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.invalidData)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
    }
    
    // NetworkError 03. requestError
    func test_request_error가_nil이_아닐때_requestError으로_실패하는지() {
        // given
        let promise = expectation(description: "testDouble: Failure_requestError")
        let url = URL(string: "stubEndPoint")!
        let data = "stringDummy".data(using: .utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: NetworkError.requestError)
        let stubUrlSession = StubURLSession(dummyData: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.request(url: url) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                // then
                XCTAssertEqual(error, NetworkError.requestError)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
    }
    
    
    // NetworkError 04. responseError
    func test_request_responseStatusCode가_300_일때_responseError300으로_실패하는지() {
        // given
        let promise = expectation(description: "testDouble: Failure_responseError300")
        let url = URL(string: "stubEndPoint")!
        let response = HTTPURLResponse(url: url, statusCode: 300, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: nil, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummyData: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.request(url: url) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.responseError(code: 300, data: nil))
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
    }
}
