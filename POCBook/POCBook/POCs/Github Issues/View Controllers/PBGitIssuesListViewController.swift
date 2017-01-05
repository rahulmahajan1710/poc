//
//  PBGitIssuesListViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 23/12/16.
//  Copyright © 2016 rahul mahajan. All rights reserved.
//

import UIKit

class PBGitIssuesListViewController: PBViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK:- IB Outlets
    @IBOutlet weak var tableView: UITableView!

    //MARK:- ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "PBGitIssuesTableViewCell") as? PBGitIssuesTableViewCell
        if cell == nil {
            cell = PBGitIssuesTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CellIdentifier")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
