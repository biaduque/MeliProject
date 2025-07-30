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
    var urlItem: String = ""
    
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
        
        setupNavigationBarAppearance()
        setupNavigationButtons()
        
        interactor?.fetchDetail(id: self.detailId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //styleView?.updateTableStyle()
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
        self.urlItem = itemDetail.permalink ?? "https://www.mercadolivre.com.br"
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

extension DetailViewController {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.meliYellow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.overrideUserInterfaceStyle = .light
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Configuração dos Botões da Navigation Bar
    func setupNavigationButtons() {
        let shareImage = UIImage(systemName: "square.and.arrow.up")
        let shareButton = UIBarButtonItem(image: shareImage, style: .plain, target: self, action: #selector(shareButtonTapped))
        shareButton.tintColor = .black
        
        let cartImage = UIImage(systemName: "cart")
        let cartButton = UIBarButtonItem(image: cartImage, style: .plain, target: self, action: #selector(cartButtonTapped))
        cartButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [cartButton, shareButton]
    }
    
    // MARK: - Ações dos Botões
    @objc func shareButtonTapped() {
        let itemPermalink = self.urlItem
        if let url = URL(string: itemPermalink) {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        } else {
            print("Link inválido para compartilhar")
        }
    }
    
    @objc func cartButtonTapped() {
        router?.routeToBuyProduct(url: self.urlItem)
    }
    
}

// MARK: Extensions
extension DetailViewController: DetailViewDelegate {
    func didSelectSeeMore() {
        //
    }
}
