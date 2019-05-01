//
//  ViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 07/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    public var viewModelData: ViewModelModelData?
    public var gettingValues: ValueViewModel?
    
    @IBOutlet weak var buttonComplete: UIButton!
    @IBOutlet weak var labelYearTill: UILabel!
    @IBOutlet weak var labelYearFrom: UILabel!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func onButtonClick(_ sender: Any) {
        let years = [Int(labelYearFrom.text!)!,Int(labelYearTill.text!)!] //years to check
        viewModelData = DataFromRequest(requestSource: SetRequest(variable: labelView.text! ), years: years)
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

