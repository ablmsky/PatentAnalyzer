//
//  RegionsViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 20/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import UIKit
import SPStorkController

class RegionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    public var gettingValues: ValueViewModel?
    public var viewModelData: ViewModelModelData?
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var labelYearTill: UILabel!
    @IBOutlet weak var labelYearFrom: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func onButtonClick(_ sender: Any) {
        let controller = ChartViewController()
        let years = [Int(labelYearFrom.text!)!,Int(labelYearTill.text!)!] //years to check
        let text = self.countryLabel.text!
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
        super.viewDidLoad()
        gettingValues = ValueViewModel()
        completeButton.layer.cornerRadius = 5
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return gettingValues?.returnRegionSource().count ?? 0
        }
        if component == 1{
            return gettingValues?.returnStraightYears().count ?? 0
        }
        return gettingValues?.returnReversYears().count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let countrySelected = gettingValues?.returnRegionSource()[pickerView.selectedRow(inComponent: 0)]
        countryLabel.text = countrySelected
        let yearFromSelected = gettingValues?.returnStraightYears()[pickerView.selectedRow(inComponent: 1)]
        labelYearFrom.text = String(yearFromSelected!)
        let yearTillSelected = gettingValues?.returnReversYears()[pickerView.selectedRow(inComponent: 2)]
        labelYearTill.text = String(yearTillSelected!)
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0{
            return NSAttributedString(string: (gettingValues?.returnRegionSource()[row])! , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        if component == 1{
            return  NSAttributedString(string: String(gettingValues!.returnStraightYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return NSAttributedString(string: String (gettingValues!.returnReversYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
}
    
    
        


