//
//  BuyProductInteractor.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit

protocol BuyProductBusinessLogic: AnyObject {
    func getWebView(_ completion: @escaping ((_ webViewRequest: URLRequest?)->Void), url: String)
}

class BuyProductInteractor: BuyProductBusinessLogic {
    func getWebView(_ completion: @escaping ((URLRequest?) -> Void), url: String) {
        guard let myURL = URL(string: url) else {
            return completion(nil)
        }
        let myRequest = URLRequest(url: myURL)
        return completion(myRequest)
    }
}
