//
//  PickDatesViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 09/06/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
import UIKit
import SPStorkController

class PickDatesViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    var viewModelData: ViewModelModelData?
    var gettingValues: ValueViewModel?
    
    var pickerView = UIPickerView()
    var completeButton = UIButton()
    var countriesToCompare: [String]?
    var yearFrom,yearTill: Int?
   
    
    var groupMain = DispatchGroup()
    var yearsToCompare: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingValues = ValueViewModel()
        self.modalPresentationCapturesStatusBarAppearance = true
        let screenSize: CGRect = self.view.bounds
        let screenWidth = screenSize.width
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 30, width: screenWidth, height: 300))
        
        completeButton = UIButton(frame: CGRect(x: Double(screenWidth) - 65, y: 17, width: 45, height: 10))
        completeButton.setTitle("Done", for: .normal)
        completeButton.titleLabel!.font = .boldSystemFont(ofSize: 18)
        completeButton.setTitleColor(.lightBlue, for: .normal)
        completeButton.showsTouchWhenHighlighted = true
        completeButton.addTarget(self, action: #selector(buttonCompletePressed), for: .touchUpInside)
        
        self.view.backgroundColor = .darkGray
        pickerView.dataSource = self
        pickerView.delegate = self
        self.view.addSubview(completeButton)
        self.view.addSubview(pickerView)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return gettingValues?.returnStraightYears().count ?? 0
        }
        
        return gettingValues?.returnReversYears().count ?? 0
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearFrom = gettingValues?.returnStraightYears()[pickerView.selectedRow(inComponent: 0)]
        
        yearTill = gettingValues?.returnReversYears()[pickerView.selectedRow(inComponent: 1)]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if component == 0{
            return  NSAttributedString(string: String(gettingValues!.returnStraightYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
            return  NSAttributedString(string: String(gettingValues!.returnReversYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    @objc func buttonCompletePressed(sender: UIButton!) {
        
        yearsToCompare = [yearFrom ?? 1980,yearTill ?? 2017]
        groupMain.leave()
        self.dismiss(animated: true, completion: nil)
    }
}

