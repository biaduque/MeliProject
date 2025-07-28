//
//  HomeViewController.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit
import RxSwift


class HomeViewController: UIViewController {
    //var coordinator: Coordinator?
    var styleView: HomeView?
    var router: HomeRoutingProtocol?
    var interactor: HomeBusinessLogic?
    
    private var page: Int = 1
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        interactor?.fetchRepoList(page: String(page))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: Suport functions
    func setup(router: HomeRoutingProtocol) {
        self.router = router
    }
    
    func setup(interactor: HomeBusinessLogic) {
        self.interactor = interactor
    }
    
    func setupController() {
        styleView?.setup(delegate: self)
    }
}

// MARK: Presenter functions
extension HomeViewController: ContentControllerProtocol {
    /// TO-DO: Adicionar modelo para lista de conteúdo
    func setupContent(with list: [Any]) {
        styleView?.setup(content: list)
    }
    
    func setupEmpty() {
        styleView?.setupEmpty()
    }
    
    func setupLoading() {
        styleView?.setupLoading()
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
    func didSelectItem() {
        print("Selecionou item")
    }
    
    func didRequestedNextPage() {
        page+=1
        interactor?.fetchRepoList(page: String(page))
    }
}
