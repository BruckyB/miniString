//
//  ViewControllerScore.swift
//  clickerApp
//
//  Created by JOHN BRUCKER on 3/16/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewControllerScore: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let database = Firestore.firestore()
    var scores : [Int] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        tableView.delegate = self
        tableView.dataSource = self

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
            self.scores = text
            
            for each in self.scores {
                print(each)
                print("also did this")
            }
            print("ok so what the hell man")
            self.tableView.reloadData()
        
    }
            
        
    
        
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("yes")
        print(scores.count)
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomCell
        //doesnt print any of this
        print("yea")
        cell.scoreOut.text = "\(scores[indexPath.row])"
        print("nah")
        return cell
    }
    
    @IBAction func backButtonb(_ sender: Any) {
        performSegue(withIdentifier: "segueToStart", sender: nil)
    }
    
}
