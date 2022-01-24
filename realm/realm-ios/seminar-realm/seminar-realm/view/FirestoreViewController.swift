//
//  FirestoreViewController.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/19.
//

import Foundation
import UIKit

class FirestoreViewController: UIViewController {
    var viewModel: FirestoreViewModel!

    @IBOutlet weak var lbResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
    }
    
    func updateSeminar() {
        lbResult.text = viewModel.allSeminarString()
    }
    
    @IBAction func getDataButtonTouched(_ sender: Any) {
//        viewModel.getDB()
//        self.updateSeminar()
//
//         Next Step (Bolts)
        viewModel.getDBTask().continueOnSuccessWith { [self] result in
            lbResult.text = viewModel.allSeminarString(seminarArr: result)
        }
    }
    
    @IBAction func addDataButtonTouched(_ sender: Any) {
        viewModel.addDB()
    }
}
