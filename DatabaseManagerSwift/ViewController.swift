//
//  ViewController.swift
//  DatabaseManagerSwift
//
//  Created by shailesh parkhi on 3/27/19.
//  Copyright © 2019 Shailesh Parkhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var nameTableView: UITableView!
    var nameArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTableView.delegate = self
        nameTableView.dataSource = self
        
        nameArray = NameDBHandler.sharedInstance.getNameListFromDB()
        self.nameTableView.reloadData()
        self.nameTableView.tableFooterView = UIView.init()
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : nameArray.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell  = tableView.dequeueReusableCell(withIdentifier: "addNameCell") as! AddNameCell
            cell.addBtn.addTarget(self, action: #selector(addNameBTNClicked), for: .touchUpInside)
            return cell
            
        }else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "editDeleteNameCell") as! EditDeleteNameCell
            cell.nameLabel.text = nameArray[indexPath.row]
            cell.editBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editBTNClicked(button:)), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteBTNClicked(button:)), for: .touchUpInside)
            return cell
        }
        
    }
    
    @objc func editBTNClicked(button:UIButton) {
        let cell = nameTableView.cellForRow(at: IndexPath.init(row: button.tag, section: 1)) as! EditDeleteNameCell
        let changedArray = nameArray.filter{$0 != nameArray[button.tag]}
        if button.accessibilityHint == "1"{
            button.accessibilityHint = "2"
            cell.nameLabel.becomeFirstResponder()
            cell.editBtn.setImage(UIImage(named: "correctBtn"), for: .normal)
        }else if (cell.nameLabel.text?.count)! > 0 && !changedArray.contains(cell.nameLabel.text!){
            button.accessibilityHint = "1"
            NameDBHandler.sharedInstance.updateName(name: cell.nameLabel.text!)
            nameArray = NameDBHandler.sharedInstance.getNameListFromDB()
            nameTableView.reloadRows(at: [IndexPath.init(row: button.tag, section: 1)], with: .automatic)
            cell.editBtn.setImage(UIImage(named: "editBtn"), for: .normal)
        }
       
        
        
    }
    
    @objc func deleteBTNClicked(button:UIButton) {
        
        let cell = nameTableView.cellForRow(at: IndexPath.init(row: button.tag, section: 1)) as! EditDeleteNameCell
        NameDBHandler.sharedInstance.deleteNameFromDB(name: cell.nameLabel.text! as AnyObject)
        nameArray = NameDBHandler.sharedInstance.getNameListFromDB()
        self.nameTableView.reloadData()
    }
    
    @objc func addNameBTNClicked(){
        let cell = nameTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! AddNameCell
        
        if (cell.addNameTextField.text?.count)! > 0 && !NameDBHandler.sharedInstance.checkNameInDB(name: cell.addNameTextField.text!){
            NameDBHandler.sharedInstance.insertNameInDB(name: cell.addNameTextField!.text as AnyObject)
            cell.addNameTextField.text = ""
            nameArray = NameDBHandler.sharedInstance.getNameListFromDB()
            self.nameTableView.reloadData()
            
        }
    }
    
}


    


class AddNameCell:UITableViewCell{
    
    @IBOutlet var addNameTextField: UITextField!
    
    @IBOutlet var addBtn: UIButton!
    
    
}

class EditDeleteNameCell:UITableViewCell{
    
    @IBOutlet var nameLabel: UITextField!
    
    @IBOutlet var editBtn: UIButton!
    
    @IBOutlet var deleteBtn: UIButton!
}

