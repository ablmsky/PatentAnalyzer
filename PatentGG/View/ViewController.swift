//
//  ViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 07/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import UIKit
import SPStorkController

class ViewController: UIViewController {
    
    public var viewModelData: ViewModelModelData?
    public var gettingValues: ValueViewModel?
    
    @IBOutlet weak var buttonComplete: UIButton!
    @IBOutlet weak var labelYearTill: UILabel!
    @IBOutlet weak var labelYearFrom: UILabel!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func onButtonClick(_ sender: Any) {
        let controller = ChartViewController()
        let years = [Int(labelYearFrom.text!)!,Int(labelYearTill.text!)!] //years to check
        let text = self.labelView.text!
        let group = DispatchGroup()
        group.enter()
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async{
            
            self.viewModelData = DataFromRequest(requestSource: SetRequest(variable: text), years: years)// all getting data here
            //controller
            controller.viewModelData = self.viewModelData
            group.leave()
            
        }
        
        controller.group = group
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        self.present(controller, animated: true,completion: nil)
    }
    override func viewDidLoad() {
        gettingValues = ValueViewModel()
        super.viewDidLoad()
        buttonComplete.layer.cornerRadius = 5
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func returnDataToNextView()->ViewModelModelData?{
        return viewModelData
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return gettingValues?.returnCountrySource().count ?? 0
        }
        if component == 1{
            return gettingValues?.returnStraightYears().count ?? 0
        }
        return gettingValues?.returnReversYears().count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let countrySelected = gettingValues?.returnCountrySource()[pickerView.selectedRow(inComponent: 0)]
        labelView.text = countrySelected
        let yearFromSelected = gettingValues?.returnStraightYears()[pickerView.selectedRow(inComponent: 1)]
        labelYearFrom.text = String(yearFromSelected!)
        let yearTillSelected = gettingValues?.returnReversYears()[pickerView.selectedRow(inComponent: 2)]
        labelYearTill.text = String(yearTillSelected!)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0{
            return NSAttributedString(string: (gettingValues?.returnCountrySource()[row])! , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        if component == 1{
            return  NSAttributedString(string: String(gettingValues!.returnStraightYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return NSAttributedString(string: String (gettingValues!.returnReversYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
extension UIColor {
    static var lightBlue = UIColor.init(red: 21/255, green: 125/255, blue: 249/255, alpha: 1)
}
