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
    public var countriesResponedResult = APIPatentManager()
    @IBOutlet weak var buttonComplete: UIButton!
    @IBOutlet weak var labelYearTill: UILabel!
    @IBOutlet weak var labelYearFrom: UILabel!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonComplete.layer.cornerRadius = 5
        pickerView.dataSource = self
        pickerView.delegate = self
        countriesResponedResult.url = APIPatentManager.getURL(country: Country.Russia)
        dataAndResponse(url: countriesResponedResult.url, object: countriesResponedResult)
        print(countriesResponedResult.responseResult)
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0{
            return NSAttributedString(string: countrySource[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        if component == 1{
            return  NSAttributedString(string: String(yearsStraight[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return NSAttributedString(string: String (yearsReverse[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

