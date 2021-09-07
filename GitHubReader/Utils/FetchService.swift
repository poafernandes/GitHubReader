//
//  FetchService.swift
//  GitHubReader
//
//  Created by Alexandre on 05/09/21.
//

import Foundation

class Service: NSObject {
    
    static let shared = Service()
    
    func fetchRepositories( completion: @escaping ([Repository]?, Error?) -> () ) {
        let fetchUrl = "https://api.github.com/search/repositories?q=language:Swift&sort=stars"
        guard let url = URL(string: fetchUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                print("Failed to retrieve repositories:", error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let repositoriesList = try JSONDecoder().decode(repositoriesList.self, from: data)
                DispatchQueue.main.async {
                    //completion(repositories, nil)
                }
                
                
                let repositories: [Repository] = repositoriesList.items
                completion(repositories, nil)
            }
            catch let jsonError{
                print("Failed to retrieve repositories", jsonError)
            }
        }.resume()
    }
}

struct repositoriesList: Decodable {
    let total_count: Int
    let items: [Repository]
}
