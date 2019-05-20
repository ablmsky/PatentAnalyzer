//
//  RegionsViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 20/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
import UIKit

class RegionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    public var gettingValues: ValueViewModel?
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingValues = ValueViewModel()
        completeButton.layer.cornerRadius = 5
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return gettingValues?.returnRegionSource().count ?? 0
        }
        
        return gettingValues?.returnStraightYears().count ?? 0
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstCountrySelected = gettingValues?.returnRegionSource()[pickerView.selectedRow(inComponent: 0)]
        countryLabel.text = firstCountrySelected
        let yearFromSelected = gettingValues?.returnStraightYears()[pickerView.selectedRow(inComponent: 1)]
        yearLabel.text = String(yearFromSelected!)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if component == 0{
            return NSAttributedString(string: (gettingValues?.returnRegionSource()[row])! , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return  NSAttributedString(string: String(gettingValues!.returnStraightYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
