//
//  RepositoryCellViewModel.swift
//  GitHubReader
//
//  Created by Alexandre on 05/09/21.
//

import Foundation
import UIKit

struct RepositoryCellViewModel {
    let name: String
    
    let ownerTextString: String
   //let stargazersText: String
    
    init(repository: Repository) {
        self.name = repository.name
        
        ownerTextString = "by: \(repository.owner.login)"
        //stargazersText = "🌟 \(repository.stargazers)"
    }
}
