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
    //remove to ViewModel
    //this part about initialization Values For PickerView
    private var countrySource = Country.returnAllCountries()
    private var yearsStraight = returnYearsValue(reverse: false)
    private var yearsReverse = returnYearsValue(reverse: true)

    public var viewModelData: ViewModelModelData?
    
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
            return countrySource.count
        }
        if component == 1{
            return yearsStraight.count
        }
        return yearsReverse.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //to ViewModel
        //cast types and init labels (connected to pickerView)
        let countrySelected = countrySource[pickerView.selectedRow(inComponent: 0)]
        labelView.text = countrySelected
        let yearFromSelected = yearsStraight[pickerView.selectedRow(inComponent: 1)]
        labelYearFrom.text = String(yearFromSelected)
        let yearTillSelected = yearsReverse[pickerView.selectedRow(inComponent: 2)]
        labelYearTill.text = String(yearTillSelected)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        //would need to change
        if component == 0{
            return NSAttributedString(string: countrySource[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        if component == 1{
            return  NSAttributedString(string: String(yearsStraight[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return NSAttributedString(string: String (yearsReverse[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

