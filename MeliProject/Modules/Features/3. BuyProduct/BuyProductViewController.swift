//
//  BuyProductViewController.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import UIKit
import WebKit

class BuyProductViewController: UIViewController, WKUIDelegate {
    var webView: BuyProductView
    var interactor: BuyProductBusinessLogic?
    var webViewUrl: String
    
    init(webView: BuyProductView, url: String) {
        self.webView = webView
        self.webViewUrl = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Life Cycle
    override func loadView() {
        webView.webView.uiDelegate = self
        webView.webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        
        FirebaseManager.shared.openScreen(name: "meli-app-triz/web-view/buy-product")
    }
    
    func setup(interactor: BuyProductBusinessLogic) {
        self.interactor = interactor
    }
    
    // MARK: Interactor Functions
    func loadWebView() {
        interactor?.getWebView({ [weak self] webViewRequest in
            guard let webViewRequested = webViewRequest else { return }
            self?.webView.webView.load(webViewRequested)
        }, url: webViewUrl)
    }
}
extension BuyProductViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.hideLoading()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.webView.hideLoading()
    }
}
