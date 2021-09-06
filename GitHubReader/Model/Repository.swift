//
//  Repository.swift
//  GitHubReader
//
//  Created by Alexandre on 05/09/21.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let owner: Owner
    let git_url: String
    let description: String?
    var homepage: String?
    let stargazers_count: Int
    let watchers_count: Int
    let open_issues_count: Int
}

struct Owner: Decodable {
    let id: Int
    let login: String
}

//struct mockData {
//    
//    static let repositories = [sampleRepository, sampleRepository, sampleRepository]
//    
//    static let sampleRepository = Repository(id: 1,
//                                             name: "Repositorio",
//                                             ownerName: "Fulano",
//                                             url: "https://github.com",
//                                             description: "Lorem ipsum dolor sit amet",
//                                             externalUrl: "https://github.com",
//                                             stargazers: 3000,
//                                             watchers: 4000,
//                                             openIssues: 3)
//}

