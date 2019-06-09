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
    var backButton = UIButton()
    var completeButton = UIButton()
    var countriesToCompare: [String]?
    var yearFrom,yearTill: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gettingValues = ValueViewModel()
        self.modalPresentationCapturesStatusBarAppearance = true
        let screenSize: CGRect = self.view.bounds
        let screenWidth = screenSize.width
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 30, width: screenWidth, height: 300))
        completeButton = UIButton(frame: CGRect(x: Double(screenWidth) - 65, y: 17, width: 45, height: 10))
        backButton = UIButton(frame: CGRect(x: 20, y: 17, width: 45, height: 10))
        backButton.setTitle("Back", for: .normal)
        backButton.showsTouchWhenHighlighted = true
        completeButton.setTitle("Done", for: .normal)
        completeButton.showsTouchWhenHighlighted = true
        
        completeButton.addTarget(self, action: #selector(buttonCompletePressed), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(buttonBackPressed), for: .touchUpInside)
        
        self.view.backgroundColor = .darkGray
        pickerView.dataSource = self
        pickerView.delegate = self
        self.view.addSubview(completeButton)
        self.view.addSubview(backButton)
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
    @objc func buttonBackPressed(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    @objc func buttonCompletePressed(sender: UIButton!) {
        
        let years = [yearFrom ?? 0, yearTill ?? 0]
        let controller = CompareChartViewController()
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async{
            group.enter()
            self.viewModelData = DataFromRequest(requestSource: SetRequest(variable: self.countriesToCompare![0]), years: years)// all getting data here
            controller.viewModelDataFirstCountry = self.viewModelData
            group.leave()
        }
        
        queue.async{
            group.enter()
            self.viewModelData = DataFromRequest(requestSource: SetRequest(variable: self.countriesToCompare![1]), years: years)// all getting data here
            //controller
            controller.viewModelDataSecondCountry = self.viewModelData//watch out how to delegate data to barchart groupped
            group.leave()
        }
        group.notify(queue: .main){
            self.countriesToCompare = nil
            self.yearFrom = nil
            self.yearTill = nil
        }
        
        controller.group = group
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        self.present(controller, animated: true,completion: nil)
        
        //self.dismiss(animated: true, completion: nil)
        
    }
}
