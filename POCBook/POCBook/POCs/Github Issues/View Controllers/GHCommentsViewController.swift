//
//  GHCommentsViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit


let kComments               =   "Comments"
let kCommentsCellIdentifier =   "GHCommentsTableViewCell"
    
class GHCommentsViewController: PBViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var commentsTableView: UITableView!
    private var comments = [GHIssueComment]()
    
    var issue : GHIssue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = kComments
        commentsTableView.estimatedRowHeight = 500
        commentsTableView.rowHeight = UITableViewAutomaticDimension
        
        if let comments = issue.comments {
            self.comments = comments
            commentsTableView.reloadData()
        }
        else{
            GHSingleton.sharedInstance.getCommentsOf(gitIssue: issue, completion: { (result, error) in
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
        var cell =  tableView.dequeueReusableCell(withIdentifier: kCommentsCellIdentifier) as? GHCommentsTableViewCell
        if cell == nil {
            cell = GHCommentsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: kCommentsCellIdentifier)
        }
        let comment = comments[indexPath.row]
        cell!.userNameLbl.text = comment.userName
        cell!.commentLbl.text = comment.body
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
