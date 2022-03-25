//
//  ViewControllerGame.swift
//  clickerApp
//
//  Created by JOHN BRUCKER on 3/15/22.
//

import UIKit
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ScoresAndNames {
    var name : String
    var age : Int
    init(name1: String, age1: Int){
        name = name1
        age = age1
    }
}

class ViewControllerGame: UIViewController {
    let database = Firestore.firestore()
    var timer = Timer()
    var bananas = 0
    var doub = false
    var trip = false
    var xtra = false
    var dcool = false
    var tcool = false
    var xcool = false
    var isTimerRunning = true
    var finalBanana = 0
    var howManyTimer = 0
    static var highScores : [Int] = []
    var nameScore : ScoresAndNames!
    //var alert = UIAlertController(title: "Enter Name", message: "Please Enter Your Name", preferredStyle: .alert)
    @IBOutlet weak var doubOut: UIButton!
    @IBOutlet weak var tripOut: UIButton!
    @IBOutlet weak var bananaOut: UILabel!
    @IBOutlet weak var timerOut: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        /*
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {
            [self,weak alert] (_) in let textField = alert!.textFields![0]
            
        }))
         */
        let docRef = database.document("high/scores")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {return}
            print("did this")
            let text = data["Score"] as? [Int] ?? [1] /*else {
                print("returned")
                return
            }
            */
            print("did this too")
            ViewControllerGame.highScores = text
            
            for each in ViewControllerGame.highScores {
                print(each)
                print("also did this")
            }
            print("ok so what the hell man")
        
    }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func timerAction(){
        howManyTimer = howManyTimer + 1
        if howManyTimer < 60 {
            if howManyTimer > 49 {
                timerOut.text = "Time Remaining: 0:0\(59-howManyTimer)"
            } else {
            timerOut.text = "Time Remaining: 0:\(59-howManyTimer)"
            }
        } else {
            timer.invalidate()
            finishedGame()
        }
    }
    
    @IBAction func bananaButton(_ sender: Any) {
        if trip == true {
            bananas = bananas + 3
            bananaOut.text = "Bananas: \(bananas)"
        } else if doub == true {
            bananas = bananas + 2
            bananaOut.text = "Bananas: \(bananas)"
        } else {
            bananas = bananas + 1
            bananaOut.text = "Bananas: \(bananas)"
        }
    }
    
    
    @IBAction func doubleBanana(_ sender: Any) {
        if bananas >= 15 {
            doub = true
            bananas = bananas - 15
            bananaOut.text = "Bananas: \(bananas)"
        } else {
            doubOut.setTitleColor(.red, for: .normal)
        }
    }
    
    @IBAction func tripleBanana(_ sender: Any) {
        if bananas >= 100 {
            trip = true
            bananas = bananas - 100
            bananaOut.text = "Bananas: \(bananas)"
        } else {
            tripOut.setTitleColor(.red, for: .normal)
        }
    }
    
    func finishedGame() {
        finalBanana = bananas
        if ViewControllerGame.highScores.count < 10 {
            ViewControllerGame.highScores.append(finalBanana)
            ViewControllerGame.highScores = ViewControllerGame.highScores.sorted().reversed()
            print(ViewControllerGame.highScores)
            
        } else {
            var isSmall = false
            for each in ViewControllerGame.highScores {
                if each > finalBanana {
                    isSmall = true
                    
                    return
                }
                
            }
            if isSmall == false {
                ViewControllerGame.highScores.append(finalBanana)
                ViewControllerGame.highScores = ViewControllerGame.highScores.sorted().reversed()
                print(ViewControllerGame.highScores)
                ViewControllerGame.highScores.remove(at: 10)
                
            }
        }
        let docRef = database.document("high/scores")
        docRef.setData(["Score":ViewControllerGame.highScores])
        timer.invalidate()
        print("sent data")
        performSegue(withIdentifier: "segueToScore", sender: nil)
    }

    @IBAction func segueButt(_ sender: Any) {
        finishedGame()
    }
    
    
    
    
    
}
