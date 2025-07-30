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
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
