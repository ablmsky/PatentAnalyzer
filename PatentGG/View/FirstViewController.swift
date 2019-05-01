//
//  FirstViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 01/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController{
    @IBOutlet weak var okComplete: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        okComplete.layer.cornerRadius = 5
    }
}
