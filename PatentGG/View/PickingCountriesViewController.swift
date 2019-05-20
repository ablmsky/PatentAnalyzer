//
//  PickingContriesViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 18/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
import UIKit

class PickingCountriesViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    //changebale init
    public var gettingValues: ValueViewModel?
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var askingLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var optionalLabel: UILabel!
    
    var countriesToCompare: [String]?
    var yearsToCompare: [String]?
    
    
    
    @IBAction func onButtonCompletedPressed(_ sender: Any) {
        switch countriesToCompare?.count ?? 0{
        case 0: countriesToCompare?.append(countryLabel.text!)
                yearsToCompare?.append(yearLabel.text!)
                completeButton.setTitle("Complete", for: .normal)
                askingLabel.text = "Choose comparable country and year"
                optionalLabel.text = "till"
            
            
        case 1: countriesToCompare?.append(countryLabel.text!)
                yearsToCompare?.append(yearLabel.text!)
                if (countriesToCompare![0].elementsEqual (countriesToCompare![1])){
                    bounce(self)
                    countriesToCompare!.remove(at: 1)
                }
        default: print("Problem with reading from View on PickingCountries")
        }
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingValues = ValueViewModel()
        askingLabel.startBlink()
        completeButton.layer.cornerRadius = 5
        countriesToCompare = []
        yearsToCompare = []
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return gettingValues?.returnCountrySource().count ?? 0
        }
        
        return gettingValues?.returnStraightYears().count ?? 0
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstCountrySelected = gettingValues?.returnCountrySource()[pickerView.selectedRow(inComponent: 0)]
        countryLabel.text = firstCountrySelected
        let yearFromSelected = gettingValues?.returnStraightYears()[pickerView.selectedRow(inComponent: 1)]
        yearLabel.text = String(yearFromSelected!)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0{
            return NSAttributedString(string: (gettingValues?.returnCountrySource()[row])! , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return  NSAttributedString(string: String(gettingValues!.returnStraightYears()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    
    @IBAction func bounce(_ sender: AnyObject){
        let bounds = completeButton.bounds
        let color = completeButton.backgroundColor
        let text = askingLabel.text
        askingLabel.text = "You can't compare same"
        completeButton.backgroundColor = UIColor.red
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { timer in
            self.completeButton.backgroundColor = color
            self.askingLabel.text = text
        })
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.completeButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        }) { (success:Bool) in
            if success {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.completeButton.bounds = bounds
                })
                
            }
        }
        
    }

}


