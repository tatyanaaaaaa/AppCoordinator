//
//  RootApplicationCoordinator.swift
//  AppCoordinator
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

public final class RootApplicationCoordinator: Coordinator {
    
    // MARK: - Private variables
    
    private let window: UIWindow?
    private var mainScreenCoordinator: Coordinator?
    
    // MARK: - Initialization
    
    public init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Public func
    
    public func start() {
        let navigationController = UINavigationController()
        let mainScreenCoordinator = MainScreenCoordinator(navigationController)
        self.mainScreenCoordinator = mainScreenCoordinator
        mainScreenCoordinator.start()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
