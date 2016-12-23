//
//  PBPOCListViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 23/12/16.
//  Copyright © 2016 rahul mahajan. All rights reserved.
//

import UIKit

class PBPOCListViewController: PBViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PBSingleton.sharedInstance.pocList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "PBPocListTableViewCell") as? PBPocListTableViewCell
        if cell == nil {
            cell = PBPocListTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "PBPocListTableViewCell")
        }
        let poc = PBSingleton.sharedInstance.pocList[indexPath.row]
        cell!.textLabel!.text = poc.pocName
        return cell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
