//
//  CommonDBHandler.swift
//  Dinible Restaurant
//
//  Created by shailesh parkhi on 12/3/18.
//  Copyright © 2018 Credible E-Commerce Solutions Private Limited. All rights reserved.
//

import Foundation
import SQLite3

class CommonDBHandler: NSObject {
    
    static let sharedCommonDBhandler = CommonDBHandler()
    
    
    func openDB() -> OpaquePointer? {

                let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
                let pathToDatabase = documentsDirectory.appending("/Name.db")

                let fileManager = FileManager.default

                let success = fileManager.fileExists(atPath: pathToDatabase)
                let databasePath =  Bundle.main.path(forResource: "Name", ofType: "db")
                if !success{

                    do {
                        // copy files from main bundle to documents directory
                        print("copy")
                        try
                            FileManager.default.copyItem(atPath: databasePath!, toPath: pathToDatabase)
                    } catch let error as NSError {
                        // Catch fires here, with an NSError being thrown
                        print("error occurred, here are the details:\n \(error)")
                    }
                }
        
                var db: OpaquePointer? = nil
                if sqlite3_open(pathToDatabase, &db) == SQLITE_OK {
                    print("Successfully opened connection to database at /\(pathToDatabase)")
                    return db
                } else {
                    print("Unable to open database. Verify that you created the directory described " +
                        "in the Getting Started section.")
        
                }
        return db
    }


    func closeDB() -> OpaquePointer? {

        let db: OpaquePointer? = nil

        
        if sqlite3_close(db) == SQLITE_OK {
            print("Successfully closed connection to database at")
            return db
        } else {
            print("Unable to close database. Verify that you created the directory described " +
                "in the Getting Started section.")
            
        }
        return db
    }
    
    
}
