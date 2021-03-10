//
//  ConversionViewController.swift
//  ch03-1692163-convert
//
//  Created by 박경훈 on 2021/03/10.
//

import UIKit

class ConversionViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenfeitTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fahrenfeitTextfield.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        // Do any additional setup after loading the view.
        view.addGestureRecognizer(tapGesture)
    }
   
    @IBAction func fahrenheitEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            if let fahrenheitValue = Double(text){
                let celsiusValue = 5.0/9.0*(fahrenheitValue - 32.0)
                celsiusLabel.text = String.init(format: "%.2f",celsiusValue)
            }else{
                celsiusLabel.text = "???"
            }
        }
    }
    

}

extension ConversionViewController{
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer){
        fahrenfeitTextfield.resignFirstResponder()
    }
}

extension ConversionViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let exist = textField.text?.range(of: ".")
        let replace = string.range(of:".")
        if exist != nil && replace != nil{
            return false
        }
        return true
    }
}
