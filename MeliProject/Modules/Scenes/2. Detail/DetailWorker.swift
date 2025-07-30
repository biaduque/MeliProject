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

class DetailWorker: DetailWorkingProtocol {
    var session: URLSession = URLSession.shared
    
    func getDetail(with id: String) -> Observable<Item> {
        guard let url = DetailRequest.bindUrl(id: id) else {
            return Observable.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        
        return Observable.create { [weak self] observer -> Disposable in
            let task = self?.session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "No data", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(Item.self, from: data)
                    observer.onNext(response)
                    observer.onCompleted()
                    
                } catch {
                    /// Chamar mock provisório
                    observer.onNext(Item.mockiPhoneDetails().first(where: { item in
                        item.id == id
                    }) ?? Item.mockiPhone13Detail())
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

