//
//  RepositoryCell.swift
//  GitHubReader
//
//  Created by Alexandre on 05/09/21.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    var repositoryCellViewModel: RepositoryCellViewModel! {
        didSet {
            textLabel?.text = repositoryCellViewModel.name
            detailTextLabel?.text = repositoryCellViewModel.ownerTextString
            //detailTextLabel?.text = repositoryCellViewModel.stargazersText

        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
