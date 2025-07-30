//
//  DetailViewModel.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

protocol DetailModel {
    var item: Item? { get set }
}

struct DetailViewModel: DetailModel {
    var item: Item?
}
