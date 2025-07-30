//
//  HomeViewModel.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

protocol HomeModel {
    var searchResult: SearchResult? { get set }
    var totalResults: Int { get set }

}

struct HomeViewModel: HomeModel {    
    var searchResult: SearchResult?
    var totalResults: Int = 0
}
