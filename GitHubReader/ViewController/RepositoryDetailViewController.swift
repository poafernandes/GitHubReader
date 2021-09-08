//
//  RepositoryDetailViewController.swift
//  GitHubReader
//
//  Created by Alexandre on 06/09/21.
//

import UIKit

class repositoryDetailViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var repository: Repository?
    
    var detailView: RepositoryDetailView { return self.view as! RepositoryDetailView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = repository?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        detailView.saveButton.addTarget(self, action: #selector(saveRepository), for: .touchUpInside)
        detailView.removeButton.addTarget(self, action: #selector(removeRepository), for: .touchUpInside)


        fillData()
    }
    
    override func loadView() {
        self.view = RepositoryDetailView(frame: UIScreen.main.bounds)
    }
    
    @objc func saveRepository(){
        
        let saveRepo = SQLiteUtils.shared
        
        saveRepo.insertRepository(repository: repository!)
    }
    
    @objc func removeRepository(){
        
        let saveRepo = SQLiteUtils.shared
        
        saveRepo.removeRepoitory(repository: repository!)
    }
    
    private func fillData(){
        detailView.setIntoStackView(button: detailView.saveButton, label: nil)
        detailView.setIntoStackView(button: detailView.removeButton, label: nil)


        detailView.setLabelIntoStackView(type: "header", label: "Owner:")
        detailView.setLabelIntoStackView(type: "content", label: (repository?.owner.login)!)
        
        detailView.setLabelIntoStackView(type: "header", label: "Git Url:")
        detailView.setLabelIntoStackView(type: "content", label: (repository?.git_url)!)
        
        detailView.setLabelIntoStackView(type: "header", label: "Description:")
        if(repository?.description == nil){
            detailView.setLabelIntoStackView(type: "content", label: "None")
        } else {
            detailView.setLabelIntoStackView(type: "content", label: (repository?.description)!)
        }
        
        detailView.setLabelIntoStackView(type: "header", label: "Homepage:")
        if(repository?.homepage != nil){
            detailView.setLabelIntoStackView(type: "content", label: (repository?.homepage)!)
        } else {
            detailView.setLabelIntoStackView(type: "content", label: "None")
        }
        
        detailView.setLabelIntoStackView(type: "header", label: "Stargazers:")
        detailView.setLabelIntoStackView(type: "content", label: "🌟 \(repository!.stargazers_count)")
        
        detailView.setLabelIntoStackView(type: "header", label: "Watchers:")
        detailView.setLabelIntoStackView(type: "content", label: "👁 \(repository!.watchers_count)")

        detailView.setLabelIntoStackView(type: "header", label: "Open Issues:")
        detailView.setLabelIntoStackView(type: "content", label: "❗️ \(repository!.open_issues_count)")
    }
    
    
    
    
}

