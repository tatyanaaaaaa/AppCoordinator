//
//  MainScreenAssembly.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Сборщик `Главного экрана`
public final class MainScreenAssembly {
    
    /// Собирает экран
    /// - Returns: собранный модуль
    public func createModule() -> MainScreenModule {
        
        let interactor = MainScreenInteractor()
        let view = MainScreenView()
        let factory = MainScreenFactory()
        
        let presenter = MainScreenViewController(interactor: interactor,
                                                 moduleView: view,
                                                 factory: factory)
        interactor.output = presenter
        view.output = presenter
        factory.output = presenter
        return presenter
    }
}
