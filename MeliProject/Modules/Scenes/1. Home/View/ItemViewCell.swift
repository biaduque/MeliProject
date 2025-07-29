//
//  ItemViewCell.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//


import UIKit

class ItemViewCell: UITableViewCell {
    static var identifier = "item-view-cell"
    
    lazy var itemImage: UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: "empty-image")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor.backgroundPrimary
        return image
    }()
    
    lazy var itemInfos: ItemInfosView = {
        let view: ItemInfosView = ItemInfosView()
        return view
    }()
    
    func setupContent(itemName: String) {
        itemInfos.setupContent(name: "", value: "", payment: "", shipping: true)
    }
}

extension ItemViewCell: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        aditionalSetups()
    }
    
    func setupHierarchy() {
        addSubview(itemImage)
        addSubview(itemInfos)
    }
    
    func setupConstraints() {
        itemImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100)
            make.leading.top.equalToSuperview().offset(20)
        }
        
        itemInfos.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(itemImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func aditionalSetups() {
        selectionStyle = .none
    }
}
