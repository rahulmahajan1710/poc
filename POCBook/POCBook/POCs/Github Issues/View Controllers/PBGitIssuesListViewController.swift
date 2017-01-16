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
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        self.title = "Github Issues"
        if PBSingleton.sharedInstance.GITIssues.count==0 {
            PBSingleton.sharedInstance.getGITIssue(completion: { (result, error) in
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
        return PBSingleton.sharedInstance.GITIssues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "PBGitIssuesTableViewCell") as? PBGitIssuesTableViewCell
        if cell == nil {
            cell = PBGitIssuesTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "PBGitIssuesTableViewCell")
        }
        let gitIssue = PBSingleton.sharedInstance.GITIssues[indexPath.row]
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
        let commentsVC = storyboard!.instantiateViewController(withIdentifier: "PBGitIssuesCommentsViewController" ) as! PBGitIssuesCommentsViewController
        commentsVC.issue = PBSingleton.sharedInstance.GITIssues[indexPath.row]
        navigationController!.pushViewController(commentsVC, animated: true)
    }

}
