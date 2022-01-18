//
//  ViewController.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let seminarViewController = storyboard?.instantiateViewController(withIdentifier: "SeminarViewController") as! SeminarViewController
        seminarViewController.viewModel = SeminarViewModel()
        navigationController?.pushViewController(seminarViewController, animated: true)
    }
}

