//
//  ViewController.swift
//  1692163-termproject
//
//  Created by 박경훈 on 2021/05/26.
//

import UIKit
import FSCalendar


class ViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        calendar.delegate = self
    }


}

extension ViewController:FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        guard let pv = self.storyboard?.instantiateViewController(identifier: "DateViewController") as? DateViewController else {return}
        
//        pv.modalPresentationStyle = .fullScreen
//        self.present(pv, animated: true,completion: nil)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let navController = UINavigationController(rootViewController: pv)
//        pv.dateLabel.text = dateFormatter.string(from: date)
//        navController.navigationItem.title = dateFormatter.string(from: date)
        self.present(navController, animated: true, completion: nil)
    }
}
