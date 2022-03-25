//
//  ViewController.swift
//  clickerApp
//
//  Created by JOHN BRUCKER on 3/15/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "segueToGame", sender: nil)
    }
    

}

