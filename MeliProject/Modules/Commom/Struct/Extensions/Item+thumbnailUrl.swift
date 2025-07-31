//
//  Item+image.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit

extension Item {
    /// Constrói a URL da imagem de miniatura (thumbnail) de um item.
    /// Retorna nil se o thumbnailID não estiver disponível ou for inválido.
    /// Padrão do Meli  para thumbnails: D_NQ_NP_2X_PREFIX-IMAGE_ID-T.jpg (T para thumbnail)
    func thumbnailUrl() -> String {
        guard let thumbnailId = self.thumbnailID else {
            return ""
        }
        
        let components = thumbnailId.split(separator: "-")
        guard components.count >= 2,
              let prefix = components.first else {
            return ""
        }
        
        let imageId = components.dropFirst().joined(separator: "-")
        
        
        
        let urlString = "https://http2.mlstatic.com/D_NQ_NP_2X_\(prefix)-\(imageId)-T.jpg"
        return urlString
    }

    /// Constrói a URL da imagem principal do produto, usando o primeiro item do array 'pictures'.
    /// Retorna nil se não houver imagens ou a URL for inválida.
    func mainPictureUrl() -> URL? {
        guard let firstPictureUrlString = self.pictures?.first?.url else {
            return nil
        }
        return URL(string: firstPictureUrlString)
    }
}
