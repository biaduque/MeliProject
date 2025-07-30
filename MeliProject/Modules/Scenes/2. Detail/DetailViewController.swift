//
//  DetailViewController.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import UIKit
import RxSwift

class DetailViewController: UIViewController {
    var styleView: DetailView?
    var router: DetailRoutingProtocol?
    var interactor: DetailBusinessLogic?
    var authManager: AuthManager?
    
    let detailId: String
    
    private var page: Int = 1
    
    // MARK: Init
    init(view: DetailView, id: String) {
        styleView = view
        detailId = id 
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: LifeCycle
    override func loadView() {
        view = styleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        
        interactor?.fetchDetail(id: self.detailId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleView?.updateTableStyle()
    }
    
    // MARK: Suport functions
    func setup(auth: AuthManager) {
        self.authManager = auth
    }
    
    func setup(router: DetailRoutingProtocol) {
        self.router = router
    }
    
    func setup(interactor: DetailBusinessLogic) {
        self.interactor = interactor
    }
    
    func setupController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        styleView?.setup(delegate: self)
    }
}

// MARK: Presenter functions
extension DetailViewController: ContentControllerProtocol {
    func setupContent(with itemDetail: Item) {
        styleView?.setup(content: itemDetail)
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
extension DetailViewController: DetailViewDelegate {
    func didSelectSeeMore() {
        print("Selecionou ver mais")
    }
}
