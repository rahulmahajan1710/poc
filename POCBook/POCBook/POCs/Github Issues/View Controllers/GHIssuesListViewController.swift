//
//  GHIssuesListViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

let kIssueListVC                = "Github Issues"
let kIssueListCellIdentifier    = "GHIssuesTableViewCell"
let kCommentsVCIdentifier       = "GHCommentsViewController"

class GHIssuesListViewController: PBViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK:- IB Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        self.title = kIssueListVC
        if GHSingleton.sharedInstance.issues.count==0 {
            GHSingleton.sharedInstance.getGITIssue(completion: { (result, error) in
                DispatchQueue.main.async {
                    if result == true {
                        self.tableView.reloadData()
                    }
                    else{
                        print("\(error!.localizedDescription)")
                    }
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
        return GHSingleton.sharedInstance.issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: kIssueListCellIdentifier) as? GHIssuesTableViewCell
        if cell == nil {
            cell = GHIssuesTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: kIssueListCellIdentifier)
        }
        let gitIssue = GHSingleton.sharedInstance.issues[indexPath.row]
        cell!.issueNameLbl.text = gitIssue.title
        if gitIssue.body.characters.count>140 {
            let strEndIndex = gitIssue.body.index(gitIssue.body.startIndex, offsetBy: 140)
            cell!.issueDescLbl.text =  "\(gitIssue.body[gitIssue.body.startIndex...strEndIndex])..."
        }
        else{
            cell!.issueDescLbl.text = gitIssue.body
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentsVC = storyboard!.instantiateViewController(withIdentifier: kCommentsVCIdentifier ) as! GHCommentsViewController
        commentsVC.issue = GHSingleton.sharedInstance.issues[indexPath.row]
        navigationController!.pushViewController(commentsVC, animated: true)
    }
    
}

