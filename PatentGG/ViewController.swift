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
    private var countrySource = Country.returnAllCountries()
    private var yearsStraight = returnYearsValue(reverse: false)
    private var yearsReverse = returnYearsValue(reverse: true)
    @IBOutlet weak var labelYearTill: UILabel!
    @IBOutlet weak var labelYearFrom: UILabel!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let countrySelected = countrySource[pickerView.selectedRow(inComponent: 0)]
        labelView.text = countrySelected
        let yearFromSelected = yearsStraight[pickerView.selectedRow(inComponent: 1)]
        labelYearFrom.text = String(yearFromSelected)
        let yearTillSelected = yearsReverse[pickerView.selectedRow(inComponent: 2)]
        labelYearTill.text = String(yearTillSelected)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return countrySource[row]
        }
        if component == 1{
            return  String(yearsStraight[row])
        }
        return String (yearsReverse[row])
    }
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let countrySelected = countriesArray[pickerView.selectedRow(inComponent: 0)]
        let stateNumberSelected = stateNumbersArray[pickerView.selectedRow(inComponent: 1)]
        lblPickerSelection.text = "\(countrySelected) has \(stateNumberSelected) number of states."
    }*/
    /*
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     if component == 0 {
     return countriesArray.count
     }
     return stateNumbersArray.count
     }
     
     //MARK:- UIPickerViewDelegates methods
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
     if component == 0 {
     return countriesArray[row]
     }
     return stateNumbersArray[row]
     }
 */
}

