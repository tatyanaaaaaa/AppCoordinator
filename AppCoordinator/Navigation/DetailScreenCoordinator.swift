//
//  DetailScreenCoordinator.swift
//  AppCoordinator
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от Coordinator `Детального экрана`
public protocol DetailScreenCoordinatorOutput: AnyObject { }

/// `Coordinator детального экрана`
public protocol DetailScreenCoordinatorInput {
    
    /// Обработчик событий от `Детального экрана`
    var moduleOutput: DetailScreenCoordinatorOutput? { get set }
    
    /// Цвет фона экрана
    var colorForView: UIColor? { get set }
}

/// `Coordinator protocol`
public typealias DetailScreenCoordinatorProtocol = Coordinator & DetailScreenCoordinatorInput

public final class DetailScreenCoordinator: DetailScreenCoordinatorProtocol {
    
    // MARK: - Public variables
    
    public var colorForView: UIColor?
    public weak var moduleOutput: DetailScreenCoordinatorOutput?
    
    // MARK: - Private variables
    
    private let navigationController: UINavigationController
    private var detailScreenModule: DetailScreenModule?
    
    // MARK: - Initialization
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public func
    
    public func start() {
        let detailScreenModule = DetailScreenAssembly().createModule()
        self.detailScreenModule = detailScreenModule
        self.detailScreenModule?.moduleOutput = self
        self.detailScreenModule?.colorForView = colorForView
        
        navigationController.pushViewController(detailScreenModule, animated: true)
    }
}

// MARK: - DetailScreenModuleOutput

extension DetailScreenCoordinator: DetailScreenModuleOutput {
    public func didCloseModule() {
        navigationController.popViewController(animated: true)
    }
}
