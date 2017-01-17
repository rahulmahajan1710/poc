//
//  PBPOCListViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 23/12/16.
//  Copyright © 2016 rahul mahajan. All rights reserved.
//

import UIKit

class PBPOCListViewController: PBViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK: - IB Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var weakSelf = self
        if PBSingleton.sharedInstance.pocList.count == 0 {
            PBSingleton.sharedInstance.readPOCFromPlist(plistName: PBConstants.FileNames.pocPlistFileName , completion: { (result  : Bool, info : Dictionary<String, Any>?) in
                if result == true {
                    weakSelf!.tableView.reloadData()
                }
                else{
                    print("\(info![PBConstants.KeyConstants.status]!)")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: - UITableViewDataSource & UITableViewDelegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PBSingleton.sharedInstance.pocList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "PBPOCListTableViewCell") as? PBPOCListTableViewCell
        if cell == nil {
            cell = PBPOCListTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "PBPOCListTableViewCell")
        }
        let poc = PBSingleton.sharedInstance.pocList[indexPath.row]
        cell!.textLabel!.text = poc.pocName
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poc = PBSingleton.sharedInstance.pocList[indexPath.row]
        PBSingleton.sharedInstance.loadPOC(poc: poc)
    }
    
   

}
