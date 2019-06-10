//
//  CompareChartViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 28/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//
import UIKit
import Foundation
import SPStorkController
import Charts

class CompareChartViewController: UIViewController, ChartViewDelegate, UITextFieldDelegate{
    
    var viewModelDataFirstCountry: ViewModelModelData?
    var viewModelDataSecondCountry: ViewModelModelData?
    let coordX = 6.5//step for x coordinate on charts view
    var startingText: String?
    var chartViewFirst = BarChartView()
    var group = DispatchGroup()
    var activityIndicator = UIActivityIndicatorView()
    var backButton = UIButton()
    
    //region text window elements
    var textField = UITextView()
    var scrollView = UIScrollView()
    var firstCountryField = UITextView()
    var secondCountryField = UITextView()
    var yearsField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = UIColor.darkGray
        let screenSize: CGRect = self.view.bounds
        let screenWidth = screenSize.width
        
        //region init sizes
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        chartViewFirst = BarChartView(frame: CGRect(x: coordX, y: 80, width: Double(screenWidth) - (coordX*2) , height: 450))
        backButton = UIButton(frame: CGRect(x: 20, y: 57, width: 45, height: 10))
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.lightBlue, for: .normal)
        backButton.titleLabel!.font = .boldSystemFont(ofSize: 18)
        backButton.showsTouchWhenHighlighted = true
        backButton.addTarget(self, action: #selector(buttonBackPressed), for: .touchUpInside)
        
        chartViewFirst.noDataText = " "
        
        //region text window elements
        scrollView = UIScrollView(frame: CGRect(x: 5*coordX, y: 550, width: Double(screenWidth) - (coordX*10) , height: 270))
        
        textField = UITextView(frame: CGRect(x: 0, y: 0, width: scrollView.bounds.width , height: 270))
        
        firstCountryField = UITextView(frame: CGRect(x: 0, y: 0, width: 100 , height: 840))
        yearsField = UITextView(frame: CGRect(x: scrollView.bounds.width/2 - 50, y: 0, width: 100 , height: 840))
        secondCountryField = UITextView(frame: CGRect(x: scrollView.bounds.width - 100, y: 0, width: 100, height: 840))
        firstCountryField.defaultValues()
        firstCountryField.isScrollEnabled = false
        secondCountryField.isScrollEnabled = false
        yearsField.isScrollEnabled = false
        yearsField.defaultValues()
        secondCountryField.defaultValues()
        self.firstCountryField.font = UIFont(name: self.textField.font?.fontName ?? UIFont.systemFontSize.description , size: 30)
        
        scrollView.contentSize = CGSize(width: Double(screenWidth) - (coordX*10) ,height: 840)
        scrollView.backgroundColor = .gray
        scrollView.layer.cornerRadius = 5
        scrollView.addSubview(textField)
        scrollView.addSubview(firstCountryField)
        scrollView.addSubview(yearsField)
        scrollView.addSubview(secondCountryField)
        
        
        self.group.notify(queue: .main){
            self.comparingsToString()
            self.textField.font = UIFont(name: self.textField.font?.fontName ?? UIFont.systemFontSize.description , size: 20)
            self.textField.defaultValues()
            self.firstCountryField.font = UIFont(name: self.firstCountryField.font?.fontName ?? UIFont.systemFontSize.description , size: 18)
            self.secondCountryField.font = UIFont(name: self.secondCountryField.font?.fontName ?? UIFont.systemFontSize.description , size: 18)
            self.yearsField.font = UIFont(name: self.yearsField.font?.fontName ?? UIFont.systemFontSize.description , size: 18)
            self.activityIndicator.stopAnimating()
            if (self.viewModelDataFirstCountry?.countryData != nil && self.viewModelDataSecondCountry?.countryData != nil){
                var yearPoints = self.viewModelDataFirstCountry!.reorginizedYears()
                var valuesFirst = self.viewModelDataFirstCountry!.reorginizedValues()
                valuesFirst.append(0)
                var valuesSecond = self.viewModelDataSecondCountry!.reorginizedValues()
                valuesSecond.append(0)
                yearPoints.append(String(Int(yearPoints[yearPoints.count-1]) ?? 0 + 1))
                //self.comparingsToString()
                self.setBarChart(dataPoints: yearPoints, valuesFirst: valuesFirst, valuesSecond: valuesSecond)
                
                self.startingText = self.textField.text
                self.chartViewFirst.defaultValues()
                self.chartViewFirst.highlightPerTapEnabled = false
                self.chartViewFirst.legend.enabled = true
                //self.textField.defaultValues()
                self.textField.backgroundColor = .gray
                self.chartViewFirst.delegate = self
            }
            
        }
        
        self.view.addSubview(backButton)
        self.view.addSubview(chartViewFirst)
        self.view.addSubview(scrollView)
        
    }
    @objc func buttonBackPressed(sender: UIButton!) {
         self.dismiss(animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //region functions for BarChart
    func setBarChart(dataPoints: [String], valuesFirst: [Int], valuesSecond: [Int]) {
        
        var dataEntriesFirst: [BarChartDataEntry] = []
        var dataEntriesSecond: [BarChartDataEntry] = []
        let formato:BarChartFormatter = BarChartFormatter(years: dataPoints)
        let xaxis:XAxis = XAxis()
        for i in 0..<dataPoints.count {
            let dataEntryFirst = BarChartDataEntry(x: Double(i), y:Double(valuesFirst[i]))
            let dataEntrySecond = BarChartDataEntry(x: Double(i), y:Double(valuesSecond[i]))
            dataEntriesFirst.append(dataEntryFirst)
            dataEntriesSecond.append(dataEntrySecond)
            _ = formato.stringForValue(Double(i), axis: xaxis)
        }
        xaxis.valueFormatter = formato
        let chartDataSetFirst = BarChartDataSet(values: dataEntriesFirst, label: viewModelDataFirstCountry!.countryData!.country)
        let chartDataSetSecond = BarChartDataSet(values: dataEntriesSecond, label: viewModelDataSecondCountry!.countryData!.country)
        chartDataSetSecond.colors = [UIColor(red: 235/255, green: 89/255, blue: 147/255, alpha: 1)]
        chartDataSetFirst.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        let dataSets: [BarChartDataSet] = [chartDataSetFirst,chartDataSetSecond]
        let chartData = BarChartData(dataSets: dataSets)
       
        chartViewFirst.xAxis.valueFormatter = xaxis.valueFormatter
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        
        let groupCount = dataPoints.count - 1
        let startYear = 0
 
        
        chartData.barWidth = barWidth;
        chartViewFirst.xAxis.axisMinimum = 0
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        chartViewFirst.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        chartViewFirst.notifyDataSetChanged()
        chartViewFirst.data = chartData

    }
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        textField.text = "\nYear: \(getYearsByIndex(highlight.x)) - Number of Patents: \(Int(highlight.y))"
        textField.font = UIFont(name: textField.font!.fontName, size: 20)
        _ = Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false, block: { timer in
            self.textField.text = self.startingText
        })
        
    }
    
    func getYearsByIndex(_ index: Double) -> String{
        var array = viewModelDataFirstCountry!.reorginizedYears()
        return array[Int(index)]
    }
    func comparingsToString(){
        
        if (viewModelDataFirstCountry?.countryData != nil && viewModelDataSecondCountry?.countryData != nil){
            
            self.firstCountryField.text = "\(self.viewModelDataFirstCountry?.countryData?.country ?? "")\n"
            self.yearsField.text = "Years\n"
            self.secondCountryField.text = "\(self.viewModelDataSecondCountry?.countryData?.country ?? "")\n"
            for i in 0..<(viewModelDataFirstCountry?.countryData?.valuePerYear.count)!{
                self.firstCountryField.text.append("\(viewModelDataFirstCountry!.countryData!.valuePerYear[i]!.value)\n")
            
                self.secondCountryField.text.append("\(viewModelDataSecondCountry!.countryData!.valuePerYear[i]!.value)\n")
                self.yearsField.text.append("\(viewModelDataFirstCountry!.countryData!.valuePerYear[i]!.year)\n")
                
            }
            
        }
        else{
            self.firstCountryField.alpha = 0
            self.secondCountryField.alpha = 0
            self.yearsField.alpha = 0
            if(viewModelDataFirstCountry?.countryData == nil && viewModelDataSecondCountry?.countryData != nil){
                textField.text = "Sorry!\n data available only for \((viewModelDataSecondCountry?.countryData?.country)!)\n on this period :("
            }
            if(viewModelDataSecondCountry?.countryData == nil && viewModelDataFirstCountry?.countryData != nil){
                textField.text = "Sorry!\n data available only for \((viewModelDataFirstCountry?.countryData?.country)!)\n on this period :("
            }
            else{
                textField.text = "Sorry!\n no available data for both countries\n on this period :("
            }
        }
    }
    
}

