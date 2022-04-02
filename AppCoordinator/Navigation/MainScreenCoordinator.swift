//
//  MainScreenCoordinator.swift
//  AppCoordinator
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Обработчик событий от Coordinator `Главного экрана`
public protocol MainScreenCoordinatorOutput: AnyObject { }

/// `Coordinator главного экрана`
public protocol MainScreenCoordinatorInput {
    
    /// Обработчик событий от `Главного экрана`
    var moduleOutput: MainScreenCoordinatorOutput? { get set }
}

/// `Coordinator protocol`
public typealias MainScreenCoordinatorProtocol = Coordinator & MainScreenCoordinatorInput

public final class MainScreenCoordinator: MainScreenCoordinatorProtocol {

    // MARK: - Public variables
    
    /// Обработчик событий от Coordinator `Главного экрана`
    public weak var moduleOutput: MainScreenCoordinatorOutput?
    
    // MARK: - Private variables
    
    private let navigationController: UINavigationController
    private var mainScreenModule: MainScreenModule?
    private var detailCoordinator: Coordinator?
    
    // MARK: - Initialization
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public func
    
    public func start() {
        let mainScreenModule = MainScreenAssembly().createModule()
        self.mainScreenModule = mainScreenModule
        self.mainScreenModule?.moduleOutput = self
        
        navigationController.pushViewController(mainScreenModule, animated: true)
    }
    
    // MARK: - Private func
    
    private func presentDetailCoordinator(_ navigationController: UINavigationController,
                                          color: UIColor?) {
        let detailCoordinator = DetailScreenCoordinator(navigationController)
        self.detailCoordinator = detailCoordinator
        detailCoordinator.colorForView = color
        detailCoordinator.moduleOutput = self
        detailCoordinator.start()
    }
}

// MARK: - MainScreenModuleOutput

extension MainScreenCoordinator: MainScreenModuleOutput {
    public func userPressedChange(color: UIColor?) {
        presentDetailCoordinator(navigationController, color: color)
    }
}

// MARK: - DetailScreenCoordinatorOutput

extension MainScreenCoordinator: DetailScreenCoordinatorOutput { }
