//
//  RepositoryListViewController.swift
//  GitHubReader
//
//  Created by Alexandre on 05/09/21.
//

import UIKit

class repositoryListViewController: UITableViewController {
    
    weak var coordinator: AppCoordinator?
    
    var repositoryCellViewModels = [RepositoryCellViewModel]()
    
    var segmentedControl = UISegmentedControl()
    
    //Identificador auxiliar
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Definindo barra de navegação
        navigationItem.title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Criando e populando a table view
        setupTableView()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupSegmentedControl()
    }
    
    //Definindo o número necessário de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryCellViewModels.count
    }

    //Populando a tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryCell
        let repositoryCellViewModel = repositoryCellViewModels[indexPath.row]
        cell.repositoryCellViewModel = repositoryCellViewModel
        return cell
    }
    
    //Repassando o repositorio selecionado
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository: Repository = repositoryCellViewModels[indexPath.row].repository
        segmentedControl.removeFromSuperview()
        coordinator?.repositoryViewController(repository: repository)
    }

    fileprivate func fetchData() {
        //Busca de dados na API do Github e formatação do JSON conforme classe repositório
        Service.shared.fetchRepositories { (repositories, error) in
            if let error = error {
                print("Fail to retrieve repositories: ", error)
                return
            }

            //Mapeando os itens (cada repositório) para as células da TableView
            self.repositoryCellViewModels = repositories?.map({ return RepositoryCellViewModel(repository: $0)}) ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func fetchFavorites(){
        let getFavorites = SQLiteUtils.shared
        
        let favoritesRepositoires = getFavorites.selectRepositories()
        
        self.repositoryCellViewModels = favoritesRepositoires.map({ return RepositoryCellViewModel(repository: $0)})
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    //Definindo estilização da tabela e tamanho por linha
    fileprivate func setupTableView(){
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60

        tableView.tableFooterView = UIView()
    }
    
    func setupSegmentedControl(){
        let options = ["Repositories", "Favorites"]
        
        segmentedControl = UISegmentedControl(items: options)
        segmentedControl.addTarget(self, action: #selector(changeTableView), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        //Ficou bugado mas amanha trabalho cedo
        //definindo a entrada do segmented control na view do navigation controller pra ficar acima da UITableView
        navigationController?.view.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: (navigationController?.view.safeAreaLayoutGuide.topAnchor)!).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: (navigationController?.view.safeAreaLayoutGuide.widthAnchor)!).isActive = true
    }
    
    @objc func changeTableView(_ segmentedControl: UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            fetchData()
        case 1:
            fetchFavorites()
        default:
            fetchData()
        }
    }
}
