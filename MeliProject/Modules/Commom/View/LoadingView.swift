//
//  LoadingView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//
import UIKit

class LoadingView: UIView {
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.distribution = .equalCentering
        return stack
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loading.tintColor = UIColor.meliYellow
        loading.color = UIColor.meliYellow
        loading.hidesWhenStopped = true
        return loading
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loading")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var message: UILabel = {
        let label = DSLabel.bodyStyle
        label.textColor = UIColor.caption
        label.textAlignment = .center
        label.text = "Carregando conteúdo..."
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func start() {
        image.isHidden = false
        message.isHidden = false
        spinner.startAnimating()
    }
    
    public func stop() {
        spinner.stopAnimating()
        message.isHidden = true
        image.isHidden = true
    }
}

extension LoadingView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(spinner)
        stackView.addArrangedSubview(message)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
        image.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(80)
        }

        message.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    func aditionalSetups() {
        
    }
}
