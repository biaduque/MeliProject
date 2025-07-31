//
//  DetailWorker.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import RxSwift
import UIKit

protocol DetailWorkingProtocol: AnyObject {
    func getDetail(with id: String) -> Observable<Item>
}
/// **DetailWorker**
/// Responsável por realizar o GET da url do detalhe do produto  de acordo com o id passado
class DetailWorker: DetailWorkingProtocol {
    var session: URLSession = URLSession.shared
    
    func getDetail(with id: String) -> Observable<Item> {
        guard let url = DetailRequestBuilder.bindUrl(id: id) else {
            return Observable.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        
        return Observable.create { [weak self] observer -> Disposable in
            let task = self?.session.dataTask(with: url) { data, response, error in
                
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
                    let response = try JSONDecoder().decode(Item.self, from: data)
                    observer.onNext(response)
                    observer.onCompleted()
                    
                } catch {
                    /// Chamar mock provisório
                    guard let detailMock = self?.mockJsonDetailResult() else { return }
                    observer.onNext(detailMock.first(where: { item in
                        item.id == id
                    }) ?? detailMock[0])
                    observer.onCompleted()
                    /// Chamar erro caso não consiga buscar os itens
                    FirebaseManager.shared.errorReport(error: MeliAPIError.apiError(statusCode: 500, message: error.localizedDescription))
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
    
    func mockJsonDetailResult() -> [Item]? {
        if let jsonString = MeliAPIManager.loadFileContent(from: "detail_response", withExtension: "json") {
            if let decodedDetailResponse = MeliAPIManager.decodeJSON(from: jsonString, as: [Item].self) {
                return decodedDetailResponse
            } else {
                print("\nFalha ao decodificar DetailResponse do arquivo.")
            }
        } else {
            print("\nNão foi possível carregar o conteúdo do arquivo JSON.")
        }
        return nil
    }
}

