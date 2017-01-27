//
//  GHIssuesListViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit



class GHIssuesListViewController: PBViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK:- IB Outlets
    @IBOutlet private weak var tableView: UITableView!
    private var issueList = [GHIssueMO]()
    
    //MARK:- ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        self.title = GHConstants.kIssueListVC
        
        let sortDesc = NSSortDescriptor(key: GHConstants.updatedAt, ascending: true)
        
        GHCoreDataController.sharedInstance.fetchData(entityName: GHConstants.kIssueEntity , sortDescriptors: nil) { (result, issueList, error) in
            if result {
                if let list = issueList {
                    if list.count > 0 {
                        DispatchQueue.main.async {
                            self.issueList = list as! [GHIssueMO]
                            self.tableView.reloadData()
                        }
                    }
                    else{
                    }
                }
                else{
                }
            }
            else{
            }
        }
    }
    
    func fetchDataFromDB() -> Void {
        
    }
    
    func fetchDataFromNetwork() -> Void {
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
        return issueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier:GHConstants.kIssueListCellIdentifier) as? GHIssuesTableViewCell
        if cell == nil {
            cell = GHIssuesTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: GHConstants.kIssueListCellIdentifier)
        }
        let gitIssue = issueList[indexPath.row]
        cell!.issueNameLbl.text = gitIssue.title
        if gitIssue.body!.characters.count>140 {
            let strEndIndex = gitIssue.body!.index(gitIssue.body!.startIndex, offsetBy: 140)
            cell!.issueDescLbl.text =  "\(gitIssue.body![gitIssue.body!.startIndex...strEndIndex])..."
        }
        else{
            cell!.issueDescLbl.text = gitIssue.body!
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentsVC = storyboard!.instantiateViewController(withIdentifier:GHConstants.kCommentsVCIdentifier ) as! GHCommentsViewController
        commentsVC.issue = issueList[indexPath.row]
        navigationController!.pushViewController(commentsVC, animated: true)
    }
    
}

