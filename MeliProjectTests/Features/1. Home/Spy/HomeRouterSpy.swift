//
//  HomeRouterSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class HomeRouterSpy: HomeRoutingProtocol {
    var calledGoToDetail = false

    func goToDetail(from id: String) {
        calledGoToDetail = true
    }
}
