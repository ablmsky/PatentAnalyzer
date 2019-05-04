//
//  CharViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 04/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//
import UIKit
import Foundation
import SPStorkController

class CharViewController: UIViewController{
    //var myScrollView = UIScrollView()
    //var myImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = UIColor.darkGray
        /*let imageToLoad = UIImage(named: "lol")
        myImageView = UIImageView(image: imageToLoad)
        myScrollView = UIScrollView(frame: self.view.bounds)
        myScrollView.addSubview(myImageView)
        myScrollView.contentSize = self.myImageView.bounds.size
        self.view.addSubview(myScrollView)*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

