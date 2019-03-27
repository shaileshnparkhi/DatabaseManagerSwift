

import Foundation
import SQLite3

/**
 
    Description: This class contains methods which handles database operations related to restaurant User
    StoryBoard:None
    Module : Registration,Profile,Notification,Review,Setting
 
 */

class NameDBHandler :NSObject{
    
    static let sharedInstance = NameDBHandler()
    
    
    /**
     * Method insertNameInDB()
     * input  param: name String
     * return : none
     * description: this method is used for inserting name in database file
     */
    
    func insertNameInDB(name:AnyObject) {
        var insertStatement: OpaquePointer? = nil
        
         let db = CommonDBHandler.sharedCommonDBhandler.openDB()
        
        let insertStatementString = "INSERT INTO Name (userName) VALUES (?);"
  
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let userName = name as! NSString
            sqlite3_bind_text(insertStatement, 1,userName.utf8String, -1,nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                   
                }else{
                    print("Could not insert row.")
                }
            
        } else {
            print("INSERT statement could not be prepared.")
        }
       
       sqlite3_finalize(insertStatement)
       sqlite3_close(db)
    }
    
    
    /**
     * Method getNameListFromDB()
     * input  param: none
     * return : none
     * description: this method is used for getting data from database  file
     
     */
    
    func getNameListFromDB() -> Array<String>  {
        var getStatement: OpaquePointer? = nil
        var nameArray:[String] = []
        let db = CommonDBHandler.sharedCommonDBhandler.openDB()
        
        let getStatementString = "SELECT *FROM Name;"
        if sqlite3_prepare_v2(db, getStatementString, -1, &getStatement, nil) == SQLITE_OK
        {
                while(sqlite3_step(getStatement) == SQLITE_ROW){
                    let userName = String(cString: sqlite3_column_text(getStatement, 0))
                    nameArray.append(userName)
                }
       
        }else{
            print("GET statement could not be prepared.")
        }
     
        sqlite3_close(db)
        
        return nameArray
    }
    
    
    func checkNameInDB(name:String) -> Bool {
        var getStatement: OpaquePointer? = nil
        var nameArray:[String] = []
        let db = CommonDBHandler.sharedCommonDBhandler.openDB()
        
        let getStatementString = "SELECT *FROM Name where userName = '\(name)';"
        if sqlite3_prepare_v2(db, getStatementString, -1, &getStatement, nil) == SQLITE_OK
        {
            while(sqlite3_step(getStatement) == SQLITE_ROW){
                let userName = String(cString: sqlite3_column_text(getStatement, 0))
                 nameArray.append(userName)
            }
            
        }else{
            print("GET statement could not be prepared.")
        }
        
        sqlite3_close(db)
        
        return nameArray.count > 0 ? true : false
        
    }
    
    /**
     * Method deleteAllNameFromDB()
     * input  param: none
     * return : none
     * description: this method is used for deleting name data from database file
     
     */
    
    func deleteAllNameFromDB() {
        var deleteStatement: OpaquePointer? = nil

        let db = CommonDBHandler.sharedCommonDBhandler.openDB()

        let deleteStatementString = "DELETE * FROM Name;"

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully Delete row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("Delete statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(deleteStatement)
        sqlite3_close(db)
    }
    
    
    func deleteNameFromDB(name:AnyObject) {
        var deleteStatement: OpaquePointer? = nil
        
        let db = CommonDBHandler.sharedCommonDBhandler.openDB()
        
        let deleteStatementString = "delete from Name where userName = '\(name)';"
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully Delete row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("Delete statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(deleteStatement)
        sqlite3_close(db)
    }
    
    
    /**
     * Method updateName()
     * input  param: name
     * return : none
     * description: this method is used for updating name in database after editing name
     
     */
    
    func updateName(name:String) {
        let updateStatementString = "UPDATE Name SET userName = '\(name)'"
         let db = CommonDBHandler.sharedCommonDBhandler.openDB()
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
}




