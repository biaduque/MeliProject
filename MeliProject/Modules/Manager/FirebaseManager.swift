//
//  FirebaseManager.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics

protocol AnalyticsLogging {
    func logEvent(_ name: String, parameters: [String: Any]?)
}


extension Analytics: AnalyticsLogging {
    func logEvent(_ name: String, parameters: [String : Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
}


struct FirebaseLogger: AnalyticsLogging {
    func logEvent(_ name: String, parameters: [String : Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
}

final class FirebaseManager {

    static let shared = FirebaseManager()
    private let logger: AnalyticsLogging

    init(logger: AnalyticsLogging = FirebaseLogger()) {
        self.logger = logger
    }

    // MARK: - Eventos de Tela
    func openScreen(name: String) {
        logger.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: name,
            AnalyticsParameterScreenClass: String(describing: type(of: self))
        ])
        
        let event = "abriu-tela:\(name)"
        Crashlytics.crashlytics().log(event)
        reportToDev(event: event)
    }

    // MARK: - Eventos de Clique
    func clickButton(name: String, screen: String? = nil) {
        var params: [String: Any] = ["button_name": name]
        if let screen = screen {
            params["screen"] = screen
        }

        logger.logEvent("click_button", parameters: params)
        let event = "clique-no-botao: \(name) \(screen.map { "tela:\($0)" } ?? "")"
        Crashlytics.crashlytics().log(event)
        reportToDev(event: event)
    }

    // MARK: - Relato de Erro
    func errorReport(error: Error, _ context: String? = nil) {
        Crashlytics.crashlytics().record(error: error)
        if let context = context {
            let event = "erro-em-contexto:\(context)"
            Crashlytics.crashlytics().log(event)
            reportToDev(event: event)
        }
    }
    
    func reportToDev(event: String) {
        print("👩🏼‍💻 Enviou ao crashlytics evento >>>> Abriu tela: \(event)")
    }
}

