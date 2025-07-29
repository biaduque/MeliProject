//
//  DSLabel.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit

class DSLabel {
    static var LargetitleStyleBold: UILabel {
        let label = UILabel()
        label.textColor = UIColor.title
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }
    
    static var titleStyle: UILabel {
        let label = UILabel()
        label.textColor = UIColor.title
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }

    static var bodyStyle: UILabel {
        let label = UILabel()
        label.textColor = UIColor.body
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }
    
    static var captionStyle: UILabel {
        let label = UILabel()
        label.textColor = UIColor.caption
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }
    
    static var highlightStyle: UILabel {
        let label = UILabel()
        label.textColor = UIColor.highlited
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }
    
    static var highlightStyleBold: UILabel {
        let label = UILabel()
        label.textColor = UIColor.highlited
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }
}
