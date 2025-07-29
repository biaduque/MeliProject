//
//  HomeWorker.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import RxSwift
import UIKit

/// **HomeWorker**
/// Responsável por realizar o GET da url da lista de reposiórios de acordo com a url passada
protocol HomeWorkingProtocol: AnyObject {
    func getRepoList(page: String) -> Observable<SearchResult>
}

class HomeWorker: HomeWorkingProtocol {
    let session: URLSession = URLSession.shared
    let imageCache = NSCache<NSNumber, UIImage>()
    
    func getRepoList(page: String) -> Observable<SearchResult> {
        guard let request = ItemRequest.configuteRequest(itemSearched: "iphone") else {
            return Observable.error(NSError(domain: "Invalid Request", code: -1, userInfo: nil))
        }
        
        return Observable.create { [weak self] observer -> Disposable in
            let task = self?.session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "No data", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(SearchResult.self, from: data)
                    
                    print(response)
                    observer.onNext(response)
                    observer.onCompleted()
                    
                } catch {
                    observer.onNext(AuthManager.mockiPhoneSearch())
                    observer.onCompleted()
                    //observer.onError(error)
                }
            }
            
            task?.resume()
            
            return Disposables.create {
                task?.cancel()
            }
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.instance)
    }
}
