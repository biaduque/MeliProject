//
//  AuthManager.swift
//  MeliProject
//
//  Created by Beatriz Duque on 29/07/25.
//

import Foundation
import AuthenticationServices

// MARK: WIP - classe deve ser melhorada para orquestração, atualização e armazenamento seguro do token
class AuthManager: NSObject, ASWebAuthenticationPresentationContextProviding {
    
    // MARK: - Propriedades de Configuração
    let clientID: String = TokenManager.clientID
    let redirectURI: String = TokenManager.redirectURI
    let clientSecret: String = TokenManager.secret

    // MARK: - Propriedades de Instância
    private var webAuthSession: ASWebAuthenticationSession?
    private let apiManager: MeliAPIManagerProtocol

    // Inicializador
    init(apiManager: MeliAPIManagerProtocol) {
        self.apiManager = apiManager
        super.init()
    }

    // MARK: - Autenticação com Mercado Livre (Fluxo OAuth 2.0)

    /// 1. Construir a URL de autorização do Mercado Livre
    /// 2. Iniciar a sessão de autenticação web
    /// 3. Trocar o código de autorização por um token de acesso
    func startMercadoLivreAuth() {
        guard var authComponents = URLComponents(string: "https://auth.mercadolivre.com.br/authorization") else { return }
        authComponents.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "scope", value: "read_profile write_items")
        ]

        guard let authURL = authComponents.url else { return }

        webAuthSession = ASWebAuthenticationSession(url: authURL, callbackURLScheme: URL(string: redirectURI)?.scheme) { [weak self] callbackURL, error in
            guard let self = self else { return }

            if let error = error {
                FirebaseManager.shared.errorReport(error: error, "erro-na-autenticacao-web")
                return
            }

            guard let callbackURL = callbackURL,
                  let urlComponents = URLComponents(url: callbackURL, resolvingAgainstBaseURL: true),
                  let code = urlComponents.queryItems?.first(where: { $0.name == "code" })?.value else {
                FirebaseManager.shared.errorReport(error: MeliAPIError.invalidURL, "url-de-callback-inválida-ou-codigo-nao-encontrado")
                return
            }
          
            /// TO-DO: Melhoria: redirectURI ser uma API do backend,
            /// que então fará a requisição com o client_secret para o Mercado Livre.
            Task {
                do {
                    let tokenResponse = try await self.apiManager.requestAccessToken(
                        code: code,
                        clientID: self.clientID,
                        clientSecret: self.clientSecret,
                        redirectURI: self.redirectURI
                    )

                    // TO-DO:  Armazenar o token de forma segura (ex: Keychain)
                    // self.saveTokensToKeychain(accessToken: tokenResponse.accessToken, refreshToken: tokenResponse.refreshToken)
                    
                    self.apiManager.updateAccessToken(tokenResponse.accessToken)
                } catch {
                    /// TO-DO: Lidar com o erro de rede/API
                    FirebaseManager.shared.errorReport(error: error, "erro-ao-trocar-codigo-por-token")
                }
            }
        }

        webAuthSession?.presentationContextProvider = self
        webAuthSession?.prefersEphemeralWebBrowserSession = true // Para não persistir cookies de login
        webAuthSession?.start()
    }

    // MARK: - ASWebAuthenticationPresentationContextProviding
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first {
            return window
        }
        return ASPresentationAnchor()
    }
}
