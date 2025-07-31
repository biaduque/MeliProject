//
//  ItemInfosView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//


import UIKit
import SnapKit

class ItemInfosView: UIView {
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var itemName: UILabel = {
        let label = DSLabel.titleStyle
        label.textColor = UIColor.body
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    lazy var itemValue: UILabel = {
        let label = DSLabel.LargetitleStyleBold
        label.textColor = UIColor.body
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var itemPaymentConditions: UILabel = {
        let label = DSLabel.highlightStyle
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var freeShipping: UILabel = {
        let label = DSLabel.highlightStyleBold
        label.numberOfLines = 0
        label.text = "Frete grátis"
        label.textAlignment = .left
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setupContent(name: String, value: String, payment: String, shipping: Bool) {
        itemName.text = name
        itemValue.text = value
        itemPaymentConditions.text = payment
        freeShipping.isHidden = !shipping
    }
}

extension ItemInfosView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(itemName)
        stackView.addArrangedSubview(itemValue)
        stackView.addArrangedSubview(itemPaymentConditions)
        stackView.addArrangedSubview(freeShipping)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.edges.equalToSuperview()
        }
        itemName.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        itemValue.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        itemPaymentConditions.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        freeShipping.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
    
    func aditionalSetups() {
        //
    }
}
