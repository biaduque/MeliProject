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
    var session: URLSession = URLSession.shared
    let imageCache = NSCache<NSNumber, UIImage>()
    
    func getItemList(searchedItem: String, page: String) -> Observable<SearchResult> {
        guard let request = ItemRequestBuilder.configuteRequest(itemSearched: searchedItem) else {
            return Observable.error(NSError(domain: "Invalid Request", code: -1, userInfo: nil))
        }
        
        return Observable.create { [weak self] observer -> Disposable in
            let task = self?.session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    observer.onError(error)
                    FirebaseManager.shared.errorReport(error: MeliAPIError.invalidURL)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "No data", code: -1, userInfo: nil))
                    FirebaseManager.shared.errorReport(error: MeliAPIError.invalidResponse)
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
                    guard let mockResult = self?.mockJsonSearchResult() else  { return }
                    observer.onNext(mockResult)
                    observer.onCompleted()
                    /// Chamar erro caso não consiga buscar os itens
                    observer.onError(error)
                    FirebaseManager.shared.errorReport(error: MeliAPIError.apiError(statusCode: 500, message: error.localizedDescription))
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
    
    func mockJsonSearchResult() -> SearchResult? {
        if let jsonString = MeliAPIManager.loadFileContent(from: "content_response", withExtension: "json") {
            if let decodedSearchResult = MeliAPIManager.decodeJSON(from: jsonString, as: SearchResult.self) {
                return decodedSearchResult
            } else {
                print("\nFalha ao decodificar SearchResult do arquivo.")
            }
        } else {
            print("\nNão foi possível carregar o conteúdo do arquivo JSON.")
        }
        return nil
    }
}
