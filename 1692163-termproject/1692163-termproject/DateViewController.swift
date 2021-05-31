//
//  DateViewController.swift
//  1692163-termproject
//
//  Created by 박경훈 on 2021/05/26.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var dateTableView: UITableView!
    @IBOutlet weak var ScheduleName: UITextField!
    
    var schedule: [String] = ["기말고사1","기말고사2","기말고사3","기말고사4","기말고사5","기말고사6"]
    var data: [String] = []
    var index : Int = -1;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dateTableView.dataSource = self
        dateTableView.delegate = self
        // Do any additional setup after loading the view.
        self.ScheduleName.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }


    @IBAction func EditTable(_ sender: UIBarButtonItem) {
        if dateTableView.isEditing == true{
            dateTableView.isEditing = false
            sender.title = "Edit"
        }else{
            dateTableView.isEditing = true
            sender.title = "Done"
        }
    }
    
    @IBAction func AddTable(_ sender: UIBarButtonItem) {
        schedule.append(String(self.ScheduleName.text!))
        self.ScheduleName.text = ""
        let indexPath = IndexPath(row: schedule.count-1, section: 0)
        self.dateTableView.insertRows(at: [indexPath], with: .automatic)
    }
}

extension DateViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let schedules = schedule[indexPath.row]
            let title = "Delete \(schedules)"
            let message = "\(schedules)를 정말 삭제하시겠습니까?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive){
                (action) in
                self.schedule.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true)
            
        }
    }

}
extension DateViewController{
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let from = schedule[sourceIndexPath.row]
        let to = schedule[destinationIndexPath.row]
        schedule[destinationIndexPath.row] = from
        schedule[sourceIndexPath.row] = to
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}
extension DateViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schedule.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
            let text: String = self.schedule[indexPath.row]
            cell.textLabel?.text = text

        return cell
    }
    
    
}
extension DateViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .lightGray
        index = indexPath.row
        ScheduleName.text = schedule[indexPath.row]
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .white
    }
}

extension DateViewController{
    @objc func textFieldDidChange(_ sender: Any?){
        if index > -1 {
        schedule[index] = (self.ScheduleName?.text)!
        dateTableView.reloadData()
        }
    }
}
