//
//  HomeViewModel.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

protocol HomeModel {
    var items: [Any]? { get set }
    var totalResults: Int { get set }

}

struct HomeViewModel: HomeModel {    
    var items: [Any]?
    var totalResults: Int = 0
}
