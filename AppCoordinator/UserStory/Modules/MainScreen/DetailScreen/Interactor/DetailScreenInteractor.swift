//
//  DetailScreenInteractor.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// события которые отправляем из Interactor в Presenter
protocol DetailScreenInteractorOutput: AnyObject {
    
    /// `Были получены данные`
    /// - Parameter text: текст
    func didReceive(text: String)
}

/// события которые отправляем из Presenter в Interactor
protocol DetailScreenInteractorInput {
    
    /// Загрузить контент
    func getContent()
}

/// Интерактор `Экрана выбора банка получателя`
final class DetailScreenInteractor: DetailScreenInteractorInput {
    
    weak var output: DetailScreenInteractorOutput?
    
    func getContent() {
        let appearance = Appearance()
        output?.didReceive(text: appearance.someText)
    }
}

// MARK: - Appearance

private extension DetailScreenInteractor {
    struct Appearance {
        let someText = "НОВЫЙ ЭКРАН"
    }
}
