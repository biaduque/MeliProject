//
//  ItemInfoType.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//
import Foundation

enum ItemInfoType: Int, CaseIterable {
    case title = 0
    case price = 1
    case originalPrice = 2
    case condition = 3
    case availability = 4
    case freeShipping = 5
    case sellerInfo = 6
    case attributes = 7
    
    var title: String {
        switch self {
        case .title: return "Produto"
        case .price: return "Preço"
        case .originalPrice: return "Preço Original"
        case .condition: return "Condição"
        case .availability: return "Disponibilidade"
        case .freeShipping: return "Frete"
        case .sellerInfo: return "Informações do Vendedor"
        case .attributes: return "Características"
        }
    }
    
    var icon: String {
        switch self {
        case .title: return "tag.fill" // Ou "text.bubble.fill"
        case .price: return "dollarsign.circle.fill" // Ou "banknote.fill"
        case .originalPrice: return "dollarsign.circle" // Versão outline para indicar menos proeminência
        case .condition: return "sparkle.magnifyingglass" // Para "novo" ou "usado"
        case .availability: return "shippingbox.fill" // Para estoque
        case .freeShipping: return "truck.box.fill" // Para frete grátis
        case .sellerInfo: return "person.crop.circle.fill" // Para informações do vendedor
        case .attributes: return "checklist.checked" // Para especificações/características
        }
    }
    
    func info(item: Item) -> String {
            switch self {
            case .title:
                return item.title

            case .price:
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                formatter.currencyCode = item.currencyID ?? "BRL"
                return formatter.string(from: NSNumber(value: item.price)) ?? "R$ -"

            case .originalPrice:
                let formatter = NumberFormatter()
                if let originalPrice = item.originalPrice {
                    formatter.numberStyle = .currency
                    formatter.currencyCode = item.currencyID ?? "BRL"
                    return formatter.string(from: NSNumber(value: originalPrice)) ?? ""
                }
                return formatter.string(from: NSNumber(value: item.price)) ?? "R$ -"

            case .condition:
                switch item.condition {
                case "new": return "Novo"
                case "used": return "Usado"
                default: return "Desconhecida"
                }

            case .availability:
                if let availableQuantity = item.availableQuantity {
                    return "Disponível: \(availableQuantity) unidade(s)"
                }
                return "Verificar disponibilidade"

            case .freeShipping:
                if let freeShipping = item.shipping?.freeShipping, freeShipping {
                    return "Frete Grátis!"
                }
                return "Frete a calcular"

            case .sellerInfo:
                if let seller = item.seller {
                    var info = "Vendedor ID: \(seller.id)"
                    if let status = seller.powerSellerStatus {
                        info += "\nStatus: \(status.capitalized)"
                    }
                    return info
                }
                return "Informações do vendedor não disponíveis"

            case .attributes:
                let relevantAttributes = item.attributes?.filter { attribute in
                    return ["BRAND", "MODEL", "CAPACITY", "RAM", "COLOR"].contains(attribute.id)
                }
                
                if let attributes = relevantAttributes, !attributes.isEmpty {
                    let formattedAttributes = attributes.compactMap { attr in
                        if let name = attr.name, let value = attr.valueName {
                            return "\(name): \(value)"
                        }
                        return nil
                    }.joined(separator: "\n")
                    return formattedAttributes.isEmpty ? "Não especificado" : formattedAttributes
                }
                return "Não especificado"
            }
        }
    
    func rowHeight() -> CGFloat{
        switch self {
        case .attributes:
            return 150
        default:
            return 75
        }
    }
}
