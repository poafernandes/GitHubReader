//
//  SQLiteUtils.swift
//  GitHubReader
//
//  Created by Kaique Monteiro on 30/08/21.
//
import UIKit
import FMDB

class SQLiteUtils {

    var databasePath = ""

    static var shared: SQLiteUtils = {
        let instance = SQLiteUtils()
        
        return instance
    }()

    private init() {
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory,
                       in: .userDomainMask)

        databasePath = dirPaths[0].appendingPathComponent("database.db").path
        
        //Removi a negaçao na hora de criar o banco de dados já que o Query verifica se a tabela existe antes de criar
        if filemgr.fileExists(atPath: databasePath as String) {

            let contactDB = FMDatabase(path: databasePath as String)

            if (contactDB.open()) {
                //TODO: Criar tabela para usar o banco
                let sqlCreationQuery = "CREATE TABLE if not exists saved_repositories(id INTEGER PRIMARY KEY AUTOINCREMENT, repo_id Integer, name Text, owner_id Int, owner_name Text, git_url Text, description Text, homepage_url Text, stargazers Int, watchers Int, open_issues Int)"
                print("criaçao")
                do{
                    try contactDB.executeUpdate(sqlCreationQuery, values: nil)
                }
                catch {
                    print("\(error.localizedDescription)")
                }
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            contactDB.close()
        }
    }

    //TODO: Criar insert, update, delete e select
    
    //Tudo que nao for select é update
    func selectRepositories() -> [Repository] {
        
        let database =  FMDatabase(path: self.databasePath as String)
        
        var repositories = [Repository]()
        
        if(database.open()){
            do {
                let retrieveRepositories = try database.executeQuery("select * from saved_repositories", values: nil)
                while retrieveRepositories.next() {
                    
                    let item: Repository = Repository(id: Int(retrieveRepositories.int(forColumn: "repo_id")), name: (retrieveRepositories.string(forColumn: "name")!), owner: Owner(id: Int(retrieveRepositories.int(forColumn: "owner_id")), login: retrieveRepositories.string(forColumn: "owner_name")!), git_url: retrieveRepositories.string(forColumn: "git_url") ?? "", description: retrieveRepositories.string(forColumn: "description"), homepage: retrieveRepositories.string(forColumn: "homepage_url"), stargazers_count: Int(retrieveRepositories.int(forColumn: "stargazers")), watchers_count: Int(retrieveRepositories.int(forColumn: "watchers")), open_issues_count: Int(retrieveRepositories.int(forColumn: "open_issues")))
                    
                    repositories.append(item)

                }
            }
            catch {
                print("\(error.localizedDescription)")
            }
        }
        
        database.close()
        
        return repositories
        
    }
    
    func insertRepository(repository: Repository){
        let database =  FMDatabase(path: self.databasePath as String)
        
        if(database.open()){
            do {
                try database.executeUpdate("INSERT INTO saved_repositories(repo_id, name, owner_id, owner_name, git_url, description, homepage_url, stargazers, watchers, open_issues) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", values: [repository.id, repository.name, repository.owner.id, repository.owner.login, repository.git_url, repository.description ?? "", repository.homepage ?? "", repository.stargazers_count, repository.watchers_count, repository.open_issues_count ])

            }
            catch {
                print("\(error.localizedDescription)")
            }
        
        database.close()
        }
    }

    func removeRepoitory(repository: Repository){
        let database =  FMDatabase(path: self.databasePath as String)

        if(database.open()){
            do {
                try database.executeUpdate("DELETE FROM saved_repositories WHERE repo_id WHERE ?", values: [repository.id])
            }
            catch {
                print("\(error.localizedDescription)")
            }
        
        database.close()
        }

    }
}
