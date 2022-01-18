//
//  SeminarViewController.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import UIKit

class SeminarViewController: UIViewController {

    var viewModel: SeminarViewModel!

    @IBOutlet weak var lbResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateSeminar()
    }
    
    func updateSeminar() {
        lbResult.text = viewModel.allSeminarString()
    }
    
    @IBAction func addButtonTouched(_ sender: Any) {
        
        var alert: UIAlertController!
        let addActionHandler: (UIAlertAction) -> Void = { _ in
            let title = alert.textFields![0].text!
            let time = alert.textFields![1].text!
            self.viewModel.addSeminar(title: title, time: time)
            self.updateSeminar()
        }
        alert = UIAlertController(title: "제목 및 시간을 입력하세요.", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "제목"
            textField.becomeFirstResponder()
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "시간"
        })
        let addAction = UIAlertAction(title: "추가", style: UIAlertAction.Style.destructive, handler: addActionHandler)
        alert.addAction(addAction)
        present(alert, animated: true)
    }
    
    @IBAction func deleteAllButtonTouched(_ sender: Any) {
        viewModel.removeAllSeminar()
        updateSeminar()
    }
}
