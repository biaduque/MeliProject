//
//  AppDelegateTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//

import XCTest
import CoreData
@testable import MeliProject

// MARK: - Core Data Mocking
func createInMemoryPersistentContainer() -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "MeliProject")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType 
    description.shouldAddStoreAsynchronously = false

    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { (desc, error) in
        precondition(desc.type == NSInMemoryStoreType)
        if let error = error {
            fatalError("Falha ao criar o container em memória: \(error)")
        }
    }
    return container
}


// MARK: - Test Class

class AppDelegateTests: XCTestCase {

    var appDelegate: AppDelegate!
    var mockPersistentContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()
        appDelegate = AppDelegate()
        mockPersistentContainer = createInMemoryPersistentContainer()
        appDelegate.persistentContainer = mockPersistentContainer
    }

    override func tearDown() {
        appDelegate = nil
        mockPersistentContainer = nil
        super.tearDown()
    }

    // MARK: - Teste de Inicialização

    func test_didFinishLaunching_configuresWindow() {
        // Given 
        let application = UIApplication.shared
        
        // Then 
        XCTAssertNotNil(application.windows.first, "A window não deveria ser nula após a inicialização.")
        XCTAssertNotNil(application.windows[0].rootViewController, "A window deveria ter um rootViewController.")
    }

    // MARK: - Testes do Core Data

    func test_persistentContainer_isInitialized() {
        // Then
        XCTAssertNotNil(appDelegate.persistentContainer, "O persistentContainer não deveria ser nulo.")
        XCTAssertEqual(appDelegate.persistentContainer.name, "MeliProject", "O nome do container do Core Data está incorreto.")
    }

    func test_saveContext_whenContextHasNoChanges_doesNothing() {
        // Given 
        let context = mockPersistentContainer.viewContext
        XCTAssertFalse(context.hasChanges, "O contexto não deveria ter mudanças no início.")
        
        // When 
        appDelegate.saveContext()
        
        // Then 
        // Apenas verifico que não houve crash e que o estado permanece o mesmo.
        XCTAssertFalse(context.hasChanges, "O contexto ainda não deveria ter mudanças.")
    }
}
