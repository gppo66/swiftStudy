//
//  ViewController.swift
//  ch10-lab
//
//  Created by 박경훈 on 2021/05/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotowithDirect(_ sender: UIButton) {
        print("gotoOtherWithDirect")
        
    }
    @IBAction func gotowithSegue(_ sender: UIButton) {
        print("gotoOtherWithSegue")
        performSegue(withIdentifier: "ghpark", sender: self)
        
    }
    @IBAction func gotowithPresent(_ sender: UIButton) {
        print("gotoOtherWithPresent")
//        let vc = storyboard?.instantiateViewController(identifier: "otherId")
        let vc = storyboard?.instantiateViewController(identifier: "otherId"){
            (coder) -> UIViewController? in
            
            let x = OtherViewController(coder: coder)
            
            return x
        }
        present(vc!, animated: true, completion: nil)
        
    }
    @IBAction func gotowithPush(_ sender: UIButton) {
        print("gotoOtherWithPush")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
    }
    

}

