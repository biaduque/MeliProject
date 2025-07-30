//
//  BuyProductView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit
import WebKit

class BuyProductView: UIView {
    var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        return webView
    }()
    
    lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.isHidden = false
        loading.start()
        return loading
    }()
    
    public func hideLoading() {
        loadingView.stop()
        loadingView.removeFromSuperview()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension BuyProductView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(webView)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(500)
        }
    }
    
    func aditionalSetups() {
        backgroundColor = .red
    }
}
