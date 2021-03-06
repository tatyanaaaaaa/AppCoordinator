//
//  MainScreenInteractor.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// события которые отправляем из Interactor в Presenter
protocol MainScreenInteractorOutput: AnyObject {
    
    /// `Были получены данные`
    /// - Parameter text: текст
    func didReceive(text: String)
}

/// события которые отправляем из Presenter в Interactor
protocol MainScreenInteractorInput {
    
    /// Загрузить контент
    func getContent()
}

/// Интерактор `Экрана выбора банка получателя`
final class MainScreenInteractor: MainScreenInteractorInput {
    
    weak var output: MainScreenInteractorOutput?
    
    func getContent() {
        let appearance = Appearance()
        output?.didReceive(text: appearance.someText)
    }
}

// MARK: - Appearance

private extension MainScreenInteractor {
    struct Appearance {
        let someText = "world"
    }
}
