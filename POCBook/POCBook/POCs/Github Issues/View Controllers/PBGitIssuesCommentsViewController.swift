//
//  PBGitIssuesCommentsViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 16/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit


let vcTitle = "Comments"

class PBGitIssuesCommentsViewController: PBViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var commentsTableView: UITableView!
    
    var issue : PBGitIssue!
    
    private var comments = [PBGitIssueComment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = vcTitle
        commentsTableView.estimatedRowHeight = 500
        commentsTableView.rowHeight = UITableViewAutomaticDimension
        
        
        if let comments = issue.comments {
            self.comments = comments
            commentsTableView.reloadData()
        }
        else{
            
            PBSingleton.sharedInstance.getCommentsOf(gitIssue: issue, completion: { (result, error) in
                DispatchQueue.main.async {
                    if result == true {
                        self.comments = self.issue.comments!
                        self.commentsTableView.reloadData()
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
    
    
    //MARK: - UITableViewDataSource & UITableViewDelegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "PBGitIssuesCommentsTableViewCell") as? PBGitIssuesCommentsTableViewCell
        if cell == nil {
            cell = PBGitIssuesCommentsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "PBGitIssuesCommentsTableViewCell")
        }
        let comment = comments[indexPath.row]
        cell!.userNameLbl.text = comment.userName
        cell!.commentLbl.text = comment.body
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
