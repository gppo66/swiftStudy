//
//  OtherViewController.swift
//  ch10-lab
//
//  Created by 박경훈 on 2021/05/10.
//

import UIKit

class OtherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func goBackAgain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
