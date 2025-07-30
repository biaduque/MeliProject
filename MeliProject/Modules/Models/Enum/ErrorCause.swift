//
//  ErrorCause.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

/// Utilizado para mensagens de erro ao usuário
///**case emptyList** ::: quando a lista é recebida vazia
///**case apiError**::: quando a lista está vazia por algum erro de API retornado
enum ErrorCause {
    case emptyList
    case apiError
    
    func message() -> String {
        switch self {
        case .emptyList:
            return "Oh, parece que não encontramos nenhum resultado para essa busca. Que tal tentar outro termo?"
        case .apiError:
            return "Algo deu errado na conexão da sua conta com o Meli. Por favor, tente novamente."
        }
    }
    
    func image() -> String {
        switch self {
        case .emptyList:
            return "empty-list"
        case .apiError:
            return "api-error"
        }
    }
}
