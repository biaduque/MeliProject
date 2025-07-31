//
//  HomeViewController.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit
import RxSwift
import CoreLocation

class HomeViewController: UIViewController {
    var styleView: HomeView?
    var router: HomeRoutingProtocol?
    var interactor: HomeBusinessLogic?
    var authManager: AuthManager?
    
    let locationManager = CLLocationManager()
    private var page: Int = 1
    private var lastSearched: String = ""
    
    // MARK: Init
    init(view: HomeView) {
        styleView = view
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: LifeCycle
    override func loadView() {
        view = styleView
        FirebaseManager.shared.openScreen(name: "meli-app-triz/search-home")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        requestLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleView?.updateTableStyle()
    }
    
    // MARK: Suport functions
    func setup(auth: AuthManager) {
        self.authManager = auth
    }
    
    func setup(router: HomeRoutingProtocol) {
        self.router = router
    }
    
    func setup(interactor: HomeBusinessLogic) {
        self.interactor = interactor
    }
    
    func setupController() {
        styleView?.setup(delegate: self)
        
        ///WIP
       /// authenticateMeli()
    }
    
    // MARK: TO-DO
    /// WIP
    ///  Chama autenticação do usuário via login no MELI pelo browser
    ///  Funcionalidade ainda nao implementada e homologada
    /**
     func authenticateMeli() {
         if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
             sceneDelegate.authCoordinator?.startMercadoLivreAuth()
         }
     }
     */
    
    func requestLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: Presenter functions
extension HomeViewController: ContentControllerProtocol {
    func setupContent(with list: SearchResult) {
        styleView?.setup(content: list)
    }
    
    func setupEmpty() {
        styleView?.setupEmpty()
    }
    
    func setupLoading() {
        styleView?.setupLoading()
    }
    
    func hideLoading() {
        styleView?.hideLoading()
    }
    
    func setupError() {
        styleView?.setupError()
    }
    
    func updateView() {
        styleView?.updateContent()
    }
}

// MARK: Extensions
extension HomeViewController: HomeViewDelegate {
    func didSearch(item: String) {
        FirebaseManager.shared.clickButton(name: "buscou:\(item)")
        lastSearched = item
        interactor?.fetchItemList(search: item, page: String(page))
    }
    
    func didSelectItem(id: String) {
        FirebaseManager.shared.clickButton(name: "selecionou-item:\(id)")
        router?.goToDetail(from: id)
    }
    
    func didRequestedNextPage() {
        page+=1
        FirebaseManager.shared.clickButton(name: "solicitou-nova-pagina:\(page)")
        interactor?.fetchItemList(search: lastSearched, page: String(page))
    }
}


extension HomeViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
            FirebaseManager.shared.clickButton(name: "clicou-permintir-localizacao")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        FirebaseManager.shared.errorReport(error: error, "falha-localizacao")
    }
}
