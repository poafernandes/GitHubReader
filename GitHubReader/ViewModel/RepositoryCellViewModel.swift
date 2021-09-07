//
//  RepositoryCellViewModel.swift
//  GitHubReader
//
//  Created by Alexandre on 05/09/21.
//

import UIKit

final class RepositoryCellViewModel {
    
    var repository: Repository
    
    let name: String
    
    let ownerTextString: String
   //let stargazersText: String
    
    init(repository: Repository) {
        self.repository = repository
        self.name = repository.name
        
        ownerTextString = "by: \(repository.owner.login)"
    }
}
