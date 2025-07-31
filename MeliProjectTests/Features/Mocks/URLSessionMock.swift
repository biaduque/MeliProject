//
//  URLSessionMock.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import UIKit

class URLSessionMock: URLSession {
    var response: URLResponse?
    var data: Data?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskMock()
        task.completionHandler = { [weak self] in
            completionHandler(self?.data, nil, self?.error)
        }
        return task
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskMock()
        task.completionHandler = { [weak self] in
            completionHandler(self?.data, nil, self?.error)
        }
        return task
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    var completionHandler: (() -> Void)?

    override func resume() {
        completionHandler?()
    }
}
