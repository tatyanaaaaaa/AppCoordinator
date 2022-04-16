//
//  DetailScreenViewController.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// события которые отправляем из `ТЕКУЩЕГО МОДУЛЯ` в  `ДРУГОЙ МОДУЛЬ`
protocol DetailScreenModuleOutput: AnyObject {
    
    /// Пользователь нажал `Закрыть экран`
    func didCloseModule()
}

/// события которые отправляем из `ДРУГОГО МОДУЛЯ` в  `ТЕКУЩИЙ МОДУЛЬ`
protocol DetailScreenModuleInput {
    
    /// Обработчик событий от `Детального экрана`
    var moduleOutput: DetailScreenModuleOutput? { get set }
    
    /// Цвет для вью
    var colorForView: UIColor? { get set }
}

/// Готовый модуль `Детального экрана`
typealias DetailScreenModule = UIViewController & DetailScreenModuleInput

/// Главный экран
final class DetailScreenViewController: DetailScreenModule {
    
    // MARK: - Internal property
    
    weak var moduleOutput: DetailScreenModuleOutput?
    var colorForView: UIColor? {
        didSet {
            moduleView.changeBackground(color: colorForView)
        }
    }
    
    // MARK: - Private property
    
    private let interactor: DetailScreenInteractorInput
    private let moduleView: UIView & DetailScreenViewInput
    private let factory: DetailScreenFactoryInput
    
    /// Инициализатор
    /// - Parameters:
    ///   - interactor: интерактор
    ///   - moduleView: вью
    ///   - factory: фабрика
    init(interactor: DetailScreenInteractorInput,
         moduleView: UIView & DetailScreenViewInput,
         factory: DetailScreenFactoryInput) {
        self.interactor = interactor
        self.moduleView = moduleView
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = moduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.getContent()
        title = Appearance().title
    }
}

// MARK: - MainScreenInteractorOutput

extension DetailScreenViewController: DetailScreenInteractorOutput {
    func didReceive(text: String) {
        factory.createTitle(text: text)
    }
}

// MARK: - MainScreenViewOutput

extension DetailScreenViewController: DetailScreenViewOutput {
    func presentNewScreenButtonAction() {
        moduleOutput?.didCloseModule()
    }
}

// MARK: - MainScreenFactoryOutput

extension DetailScreenViewController: DetailScreenFactoryOutput {
    func didReciveFull(text: String) {
        moduleView.setTitle(text: text)
    }
}

// MARK: - Appearance

private extension DetailScreenViewController {
    struct Appearance {
        let title = "ROUTING to Coordinator"
    }
}
