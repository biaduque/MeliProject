//
//  ViewStatusChangeProtocol.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

/// Possíveis estados alterativos de uma view
protocol StatusChangeProtocol {
    func updateContent()
    func setupLoading()
    func setupEmpty()
    func setupError()
}
