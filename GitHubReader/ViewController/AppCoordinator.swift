//
//  AppCoordinator.swift
//  GitHubReader
//
//  Created by Alexandre on 06/09/21.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
        
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        let viewController = repositoryListViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func repositoryViewController(repository: Repository) {
        let viewController = repositoryDetailViewController()
        viewController.repository = repository
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
