//
//  MVMRootViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 30/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class MVMRootViewController: PBViewController {

    @IBOutlet weak var faceView: MVMFaceView!{
        didSet{
            //Gesture with calling view's methods--//
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(MVMFaceView.changeScale(recognizer:))))
            
            //Gesture to change the view model in controller ---//
            let happierSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector (MVMRootViewController.increaseHappiness))
            happierSwipeGesture.direction = .up
            faceView.addGestureRecognizer(happierSwipeGesture)
            
            let sadderSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector (MVMRootViewController.decreaseHappiness))
            sadderSwipeGesture.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGesture)
            
            updateUI()
        }
    }
    
    var expression = MVMFacialExpressions( eyes : .Open , eyeBrows : .Relaxed , mouth : .Smile){
        didSet{
            updateUI()
        }
    }
    
    func increaseHappiness()  {
        expression.mouth = expression.mouth.happierMouth()
    }
    func decreaseHappiness()  {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    //MARK:- Gesture added on storboard ----//
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed : expression.eyes = .Open
            case .Squinting : break
            }
        }
    }
    
    private let mouthCurvatures = [MVMFacialExpressions.Mouth.Frown : CGFloat(-1.0) ,
                                   .Grin : CGFloat(0.5) , .Smile : CGFloat(1.0) , .Smirk : CGFloat(-0.5) , .Neutral : CGFloat(0.0) ]
    
    private let eyeBrowTilts = [MVMFacialExpressions.EyeBrows.Relaxed : CGFloat(0.5) , .Furrowed : CGFloat(-0.5) , .Normal : CGFloat(0.0)]
    
    private func updateUI(){
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed : faceView.eyesOpen = false
        case .Squinting : faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVVM"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
