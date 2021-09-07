//
//  Coordinator.swift
//  GitHubReader
//
//  Created by Alexandre on 06/09/21.
//

import UIKit

protocol Coordinator {
    //var navigationController: UINavigationController? { get set }
    
    //func eventOcurred(with type: Event)
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
