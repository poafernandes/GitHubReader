//
//  RepositoriesController.swift
//  GitHubReader
//
//  Created by Alexandre on 05/09/21.
//

import UIKit

class RepositoriesController: UITableViewController {
    
    var repositoryCellViewModels = [RepositoryCellViewModel]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Definindo barra de navegação e populando os dados da Table View
        setupNavigation()
        setupTableView()
        fetchData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryCellViewModels.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryCell
        let repositoryCellViewModel = repositoryCellViewModels[indexPath.row]
        cell.repositoryCellViewModel = repositoryCellViewModel
        return cell
    }
    
    fileprivate func fetchData() {
        
        //Busca de dados na API do Github e formatação do JSON conforme classe repositório
        Service.shared.fetchRepositories { (repositories, error) in
            if let error = error {
                print("Fail to retrieve repositories: ", error)
                return
            }
        
            //Mapeando os itens (cada repositório para as células da TableView
            self.repositoryCellViewModels = repositories?.map({ return RepositoryCellViewModel(repository: $0)}) ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        
        }
        
        //Teste com dados de exemplo
//        self.repositoryCellViewModels = mockData.repositories.map({
//            RepositoryCellViewModel(repository: $0)
//        })

//        self.tableView.reloadData()
    }
    
    fileprivate func setupNavigation(){
        navigationItem.title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    fileprivate func setupTableView(){
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        
        tableView.tableFooterView = UIView()
    }
}
