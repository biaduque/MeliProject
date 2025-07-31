//
//  HomeFactory.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit

protocol FactoryProtocol: AnyObject {
    static func makeController(with coordinator: MeliProjectCoordinator, aditionalInfos: Any?) -> UIViewController
}
