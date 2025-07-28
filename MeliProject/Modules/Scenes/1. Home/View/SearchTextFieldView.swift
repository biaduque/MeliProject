//
//  SearchTextFieldView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//


import UIKit
import SnapKit

protocol SearchFieldDelegate: AnyObject {
    func didSearch(state: SearchState, text: String)
    func showResults()
}

class SearchTextFieldView: UIView {
    var state: SearchState = .initialSearch {
        didSet {
            if state == .topViewSearch {
                setupConstraintsForSearch()
            }
        }
    }
    weak var delegate: SearchFieldDelegate?
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var searchField: UISearchTextField = {
        let field = UISearchTextField()
        field.placeholder = "Buscar..."
        field.addTarget(self, action: #selector(searchChanged(_:)), for: .editingChanged)
        return field
    }()
   
    
    lazy var message: UILabel = {
        let label = DSLabel.captionStyle
        label.text = "O seu buscador de produtos do Mercado Livre :)"
        label.textColor = UIColor.caption
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func hide() {
        self.removeFromSuperview()
    }
    
    @objc func searchChanged(_ textField: UITextField) {
        if let text = textField.text {
            state = text.isEmpty ? .initialSearch : .topViewSearch
            delegate?.didSearch(state: state, text: text)
        }
        
        delegate?.showResults()
    }
}

extension SearchTextFieldView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
    func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(searchField)
        stackView.addArrangedSubview(message)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(35)
        }
        
        message.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(searchField.snp.width).multipliedBy(0.5)
        }
    }
    
    func aditionalSetups() {
        //
    }
    
    func setupConstraintsForSearch() {
        message.removeFromSuperview()
        
        self.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        
        self.layoutIfNeeded()

    }
}
