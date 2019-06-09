//
//  PickingContriesViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 18/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
import UIKit
import SPStorkController

class PickingCountriesViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    public var viewModelData: ViewModelModelData?
    public var gettingValues: ValueViewModel?
    //public var compareCountries: 
    
    @IBOutlet weak var comparableCountryLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var askingLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var optionalLabel: UILabel!
    
    var countriesToCompare = ["",""]
    
    
    @IBAction func onButtonCompletedPressed(_ sender: Any) {
        countriesToCompare[0] = countryLabel.text ?? ""
        countriesToCompare[1] = comparableCountryLabel.text ?? ""
        if (countriesToCompare[0].elementsEqual(countriesToCompare[1])){
            bounce(self)
            countriesToCompare[1] = ""
        }
        else{
            let controller = PickDatesViewController()
            let transitionDelegate = SPStorkTransitioningDelegate()
            transitionDelegate.customHeight = 400
            controller.transitioningDelegate = transitionDelegate
            controller.modalPresentationStyle = .custom
            controller.countriesToCompare = self.countriesToCompare
            self.present(controller, animated: true,completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingValues = ValueViewModel()
        askingLabel.startBlink()
        completeButton.layer.cornerRadius = 5
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
        return gettingValues?.returnCountrySource().count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstCountrySelected = gettingValues?.returnCountrySource()[pickerView.selectedRow(inComponent: 0)]
        countryLabel.text = firstCountrySelected
        let secondCountrySelected = gettingValues?.returnCountrySource()[pickerView.selectedRow(inComponent: 1)]
        comparableCountryLabel.text = String(secondCountrySelected!)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
       
        if component == 0{
            return NSAttributedString(string: (gettingValues?.returnCountrySource()[row])! , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return  NSAttributedString(string: String(gettingValues!.returnCountrySource()[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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




