//
//  ItemViewCell.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//


import UIKit

class ItemViewCell: UITableViewCell {
    static var identifier = "item-view-cell"
    
    lazy var itemName: UILabel = {
        let name = DSLabel.titleStyle
        name.text = "Nome do item"
        return name
    }()
    
    func setupContent(itemName: String, description: String, forks: Int, stars: Int) {
        self.itemName.text = itemName
    }
}

extension ItemViewCell: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        aditionalSetups()
    }
    
    func setupHierarchy() {
        addSubview(itemName)
  
    }
    
    func setupConstraints() {
        itemName.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
        }
    }
    
    func aditionalSetups() {
        selectionStyle = .none
    }
}
