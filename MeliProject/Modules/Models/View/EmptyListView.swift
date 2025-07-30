//
//  EmptyListView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit
import SnapKit

class EmptyListView: UIView {
    var emptyCause: ErrorCause = .emptyList
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.distribution = .equalCentering
        return stack
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "empty-list")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var message: UILabel = {
        let label = DSLabel.titleStyle
        label.textColor = UIColor.title
        label.numberOfLines = 5
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
    
    func setEmpty(cause: ErrorCause) {
        image.image = UIImage(named: cause.image())
        message.text = cause.message()
        
        reloadInputViews()
    }
    
    public func hide() {
        self.isHidden = true
    }
}

extension EmptyListView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
    func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(message)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(160)
        }
        
        message.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func aditionalSetups() {
        //
    }
}
