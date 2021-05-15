//
//  ViewController.swift
//  ch09-1692163-tableView
//
//  Created by 박경훈 on 2021/04/12.
//

import UIKit

class FacilityGroupViewController: UIViewController {

    @IBOutlet weak var facilityTableView: UITableView!
    var facilityGroup : FacilityGroup!

    
}
    extension FacilityGroupViewController{
    @IBAction func editTable(_ sender: UIButton) {
        if facilityTableView.isEditing == true{
            facilityTableView.isEditing = false
            sender.setTitle("Edit",for: .normal)
        }else{
            facilityTableView.isEditing = true
            sender.setTitle("Done",for: .normal)
        }
    }
    @IBAction func AddFacility(_ sender: UIButton) {
        let facility = Facility(random: true)
        facilityGroup.addFacility(facility: facility)
        let indexPath = IndexPath(row: facilityGroup.count()-1, section: 0)
        facilityTableView.insertRows(at: [indexPath], with: .automatic)
    }
    
}

extension FacilityGroupViewController{
@IBAction func editTable1(_ sender: UIBarButtonItem) {
    if facilityTableView.isEditing == true{
        facilityTableView.isEditing = false
//        sender.setTitle("Edit",for: .normal)
        sender.title = "Edit"
    }else{
        facilityTableView.isEditing = true
//        sender.setTitle("Done",for: .normal)
        sender.title = "Done"
    }
}
@IBAction func AddFacility1(_ sender: UIBarButtonItem) {
    let facility = Facility(random: true)
    facilityGroup.addFacility(facility: facility)
    let indexPath = IndexPath(row: facilityGroup.count()-1, section: 0)
    facilityTableView.insertRows(at: [indexPath], with: .automatic)
}

}


extension FacilityGroupViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        facilityGroup = FacilityGroup()
//        facilityGroup.testData()
        
        facilityTableView.dataSource = self
        facilityTableView.delegate = self
//        facilityTableView.isEditing = true
        
        self.navigationItem.title = "Facility Group"
        
        
        
    }
}

extension FacilityGroupViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilityGroup.facilitys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "FacilityTableViewCell")!
        let facility = facilityGroup.facilitys[indexPath.row]
        cell.textLabel!.text = facility.name
        cell.detailTextLabel!.text = String.init(format: "%02d:00~%02d %dhours", facility.open,facility.close,facility.unit)
        cell.detailTextLabel?.textAlignment = .left
        cell.backgroundColor = .white
        return cell
    }
}

extension FacilityGroupViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .green
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .white
    }
}

extension FacilityGroupViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let facility = facilityGroup.facilitys[indexPath.row]
            let title = "Delete \(facility.name)"
            let message = "Are you sure ...."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Sure", style: .destructive){
                (action) in
                self.facilityGroup.removeFacility(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true)
            
        }
    }

}

extension FacilityGroupViewController{
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let from = facilityGroup.facilitys[sourceIndexPath.row]
        let to = facilityGroup.facilitys[destinationIndexPath.row]
        facilityGroup.modifyFacility(facility: from, index: destinationIndexPath.row)
        facilityGroup.modifyFacility(facility: to, index: sourceIndexPath.row)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}

extension FacilityGroupViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let facilityDetailViewController = segue.destination as! FacilityDetailViewController
        if let row = facilityTableView.indexPathForSelectedRow?.row{
            facilityDetailViewController.facility = facilityGroup.facilitys[row]
            
        }
    }
}

extension FacilityGroupViewController{
    override func viewDidAppear(_ animated: Bool) {
        print("FacilityGroupViewController.viewWillAppear")
        if let indexPath = facilityTableView.indexPathForSelectedRow{
            facilityTableView.reloadRows(at: [indexPath], with: .automatic)
            facilityTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            facilityTableView.cellForRow(at: indexPath)?.backgroundColor = .green
        }
    }
}
