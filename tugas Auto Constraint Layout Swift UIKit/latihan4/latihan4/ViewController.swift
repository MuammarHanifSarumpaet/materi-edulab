//
//  ViewController.swift
//  latihan4.
//
//  Created by iCodeWave Community on 28/02/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnTapped(_ sender: Any) {
    
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
//        ?self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
    @IBAction func btnTapper(_ sender: Any) {
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
//        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func preview(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier:
        "thirdViewController") as! thirdViewController
//        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}

