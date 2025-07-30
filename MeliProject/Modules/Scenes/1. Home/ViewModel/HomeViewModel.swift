//
//  HomeViewModel.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

protocol HomeModel {
    var items: SearchResult? { get set }
    var totalResults: Int { get set }

}

struct HomeViewModel: HomeModel {    
    var items: SearchResult?
    var totalResults: Int = 0
}
