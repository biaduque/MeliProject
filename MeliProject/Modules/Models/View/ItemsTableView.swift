//
//  ItemsTableView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//
import UIKit

class ItemsTableView: UITableView {
    func setupStyle() {
        rowHeight = 120
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
    }
}
