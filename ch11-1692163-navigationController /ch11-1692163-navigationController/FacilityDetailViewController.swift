//
//  FacilityDetailViewController.swift
//  ch11-1692163-navigationController 
//
//  Created by 박경훈 on 2021/05/15.
//

import UIKit

class FacilityDetailViewController: UIViewController {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var openPickView: UIPickerView!
    @IBOutlet weak var closePickerView: UIPickerView!
    @IBOutlet weak var bookingUnitPickerView: UIPickerView!

    var facility : Facility?
    var times: [Int]!
    var units: [Int]!
}
extension FacilityDetailViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facility = facility ?? Facility(random: true)
        nameTextField.text = facility!.name
        initPickerView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
   
}
extension FacilityDetailViewController{
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}

extension FacilityDetailViewController{
    func initPickerView(){
            times = []
            units = []
            for i in 0..<24{
                times.append(i)
            }
            for i in 1..<11{
                units.append(i)
            }
            
            openPickView.dataSource = self
            openPickView.delegate = self
            openPickView.selectRow(facility!.open, inComponent: 0, animated: true)
            
            closePickerView.dataSource = self
            closePickerView.delegate = self
            closePickerView.selectRow(facility!.close, inComponent: 0, animated: true)
            
            bookingUnitPickerView.dataSource = self
            bookingUnitPickerView.delegate = self
            bookingUnitPickerView.selectRow(facility!.unit-1, inComponent: 0, animated: true)
        }
    }

extension FacilityDetailViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView != bookingUnitPickerView{
            return times.count
        }
        return units.count
    }
}
extension FacilityDetailViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView != bookingUnitPickerView{
            return "\(times[row]) aclock"
        }
        return "\(units[row]) hours"
    }
}
extension FacilityDetailViewController{
    override func viewWillDisappear(_ animated: Bool) {
        facility!.name = nameTextField!.text!
        facility!.open = openPickView.selectedRow(inComponent: 0)
        facility!.close = closePickerView.selectedRow(inComponent: 0)
        facility!.unit = bookingUnitPickerView.selectedRow(inComponent: 0)+1
    }
}
