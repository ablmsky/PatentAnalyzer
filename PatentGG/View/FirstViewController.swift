//
//  FirstViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 01/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import UIKit
import SpriteKit

class FirstViewController: UIViewController{
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var okComplete: UIButton!
    @IBOutlet weak var askingLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        okComplete.layer.cornerRadius = 5
        textField.layer.cornerRadius = 15
        textField.setGradientBackground(colorOne: UIColor.darkGray, colorTwo: UIColor.lightGray)
        previewButton.layer.cornerRadius = 5
        askingLabel.startBlink()
        textField.isEditable = false 
    }
}
extension UILabel {
    func startBlink() {
        UIView.animate(withDuration: 1.5,
                       delay:0.0,
                       options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
                       animations: { self.alpha = 0 },
                       completion: nil)
    }
}
extension UITextView{
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 7.5]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
//may use it for some uncorrect data, animation like: password isn't right
/*@IBAction func bounce(_ sender: AnyObject){
 let bounds = previewButton.bounds
 UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
 self.previewButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
 }) { (success:Bool) in
 if success {
 
 UIView.animate(withDuration: 0.5, animations: {
 self.previewButton.bounds = bounds
 })
 
 }
 }
 }*/
