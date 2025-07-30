//
//  HomeWorker.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import RxSwift
import UIKit

/// **HomeWorker**
/// Responsável por realizar o GET da url da lista de produtos de acordo com a url passada
protocol HomeWorkingProtocol: AnyObject {
    func getItemList(searchedItem: String, page: String) -> Observable<SearchResult>
}

class HomeWorker: HomeWorkingProtocol {
    let session: URLSession = URLSession.shared
    let imageCache = NSCache<NSNumber, UIImage>()
    
    func getItemList(searchedItem: String, page: String) -> Observable<SearchResult> {
        guard let request = ItemRequest.configuteRequest(itemSearched: searchedItem) else {
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
                    print("RES >>> ", response)
                    observer.onNext(response)
                    observer.onCompleted()
                    
                } catch {
                    /// Chamar mock provisório
                    observer.onNext(SearchResult.mockiPhoneSearchResults())
                    observer.onCompleted()
                    /// Chamar erro caso não consiga buscar os itens
                    observer.onError(error)
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
