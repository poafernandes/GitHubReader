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

        if !filemgr.fileExists(atPath: databasePath as String) {

            let contactDB = FMDatabase(path: databasePath as String)

            if (contactDB.open()) {
                //TODO: Criar tabela para usar o banco
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }


        }
    }

    //TODO: Criar insert, update, delete e select

}
