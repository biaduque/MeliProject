//
//  BuyProductFactory.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import WebKit
import UIKit

class BuyProductFactory {
    static func makeController(with path: String) -> UIViewController {
        let interactor = BuyProductInteractor()
        let viewController = BuyProductViewController(webView: BuyProductView(),
                                                             url: path)
        
        viewController.setup(interactor: interactor)
        
        return viewController
    }
}
