//
//  DetailScreenFactory.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// события которые отправляем из Factory в Presenter
protocol DetailScreenFactoryOutput: AnyObject {
    
    /// Был получен готовый текст
    /// - Parameter text: готовый, сформированный `текст`
    func didReciveFull(text: String)
}

/// события которые отправляем из Presenter в Factory
protocol DetailScreenFactoryInput {
    
    /// Создает секции для отображения
    /// - Parameter text: `вторая часть готового текста`
    func createTitle(text: String)
}

/// Фабрика элментов `Главного Экрана`
final class DetailScreenFactory: DetailScreenFactoryInput {
    
    weak var output: DetailScreenFactoryOutput?
    
    func createTitle(text: String) {
        let fullText = "\(Appearance().title) \(text)"
        output?.didReciveFull(text: fullText)
    }
}

// MARK: - Appearance

private extension DetailScreenFactory {
    struct Appearance {
        let title = "это - "
    }
}
