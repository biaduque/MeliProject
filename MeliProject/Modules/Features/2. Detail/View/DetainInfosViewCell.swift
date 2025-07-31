//
//  DetainInfosViewCell.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import UIKit

class DetailInfosViewCell: UITableViewCell {
    static var identifier = "detail-info-view-cell"
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var itemInfo: UILabel = {
        let label = DSLabel.titleStyle
        label.textColor = UIColor.body
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupContent(itemIcon: String, itemInfo: String) {
        self.itemInfo.text = itemInfo
        self.setupIcon(name: itemIcon)
        self.setupView()
        self.layoutSubviews()
    }
    
    func setupIcon(name: String) {
        let systemName = name
        if let systemImage = UIImage(systemName: systemName) {
            icon.image = systemImage
        } else {
            print("Erro: Ícone SF Symbol '\(systemName)' não encontrado.")
            icon.image = UIImage(systemName: "questionmark.circle.fill")
        }
        icon.tintColor = UIColor.meliYellow
        icon.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        icon.preferredSymbolConfiguration = config
    }
}

extension DetailInfosViewCell: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        aditionalSetups()
    }
    
    func setupHierarchy() {
        addSubview(icon)
        addSubview(itemInfo)
    }
    
    func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        itemInfo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-12)
        }
    }
    
    func aditionalSetups() {
        selectionStyle = .none
    }
}
