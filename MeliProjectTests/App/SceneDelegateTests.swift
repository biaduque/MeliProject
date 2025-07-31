//
//  SceneDelegateTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//

import XCTest
@testable import MeliProject

class SceneDelegateTests: XCTestCase {

    var sceneDelegate: SceneDelegate!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        // Instancia o SceneDelegate para cada teste
        sceneDelegate = SceneDelegate()
        // Cria uma window para os testes
        window = UIWindow()
        sceneDelegate.window = window
    }

    override func tearDown() {
        sceneDelegate = nil
        window = nil
        super.tearDown()
    }
}
