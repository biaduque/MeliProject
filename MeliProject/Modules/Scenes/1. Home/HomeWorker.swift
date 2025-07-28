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
    func getRepoList(page: String) -> Observable<Any>
}

class HomeWorker: HomeWorkingProtocol {
    let session: URLSession = URLSession.shared
    let imageCache = NSCache<NSNumber, UIImage>()
    
    func getRepoList(page: String) -> Observable<Any> {
       
        return Observable.create { [weak self] observer -> Disposable in
            observer.onNext("")
            observer.onCompleted()
            
            return Disposables.create {
                ""
            }
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: MainScheduler.instance)
    }
}
