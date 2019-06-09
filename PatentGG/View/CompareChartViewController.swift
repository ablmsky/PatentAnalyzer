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
    var myScrollView = UIScrollView()
    let coordX = 6.5//step for x coordinate on charts view
    var startingText: String?
    var chartViewFirst = BarChartView()
    var textField = UITextView()
    var group = DispatchGroup()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.setNeedsLayout()
        myScrollView.layoutIfNeeded()
        self.modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = UIColor.darkGray
        let screenSize: CGRect = self.view.bounds
        let screenWidth = screenSize.width
        
        //region init sizes
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        chartViewFirst = BarChartView(frame: CGRect(x: coordX, y: 30, width: Double(screenWidth) - (coordX*2) , height: 450))
        textField = UITextView(frame: CGRect(x: 5*coordX, y: 500, width: Double(screenWidth) - (coordX*10) , height: 300))
        
        chartViewFirst.noDataText = " "
        textField.defaultValues()
        
        self.group.notify(queue: .main){
            self.textField.text = self.viewModelDataFirstCountry?.allToString()
            self.textField.font = UIFont(name: self.textField.font?.fontName ?? UIFont.systemFontSize.description , size: 20)
            self.activityIndicator.stopAnimating()
            if (self.viewModelDataFirstCountry?.countryData != nil && self.viewModelDataSecondCountry?.countryData != nil){
                var yearPoints = self.viewModelDataFirstCountry!.reorginizedYears()
                var valuesFirst = self.viewModelDataFirstCountry!.reorginizedValues()
                valuesFirst.append(0)
                var valuesSecond = self.viewModelDataSecondCountry!.reorginizedValues()
                valuesSecond.append(0)
                yearPoints.append(String(Int(yearPoints[yearPoints.count-1]) ?? 0 + 1))
                self.textField.text = self.comparingsToString()
                self.setBarChart(dataPoints: yearPoints, valuesFirst: valuesFirst, valuesSecond: valuesSecond)
                
                self.startingText = self.textField.text
                self.chartViewFirst.defaultValues()

                self.chartViewFirst.legend.enabled = true
                self.textField.defaultValues()
                self.chartViewFirst.delegate = self
            }
            
        }
        
        myScrollView = UIScrollView(frame: self.view.bounds)
        myScrollView.addSubview(chartViewFirst)
        myScrollView.addSubview(textField)
        myScrollView.contentSize = CGSize(width: self.myScrollView.frame.size.width ,height: 830)
        self.view.addSubview(myScrollView)
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
    func comparingsToString() -> String{
        var stringToReturn: String
        let countries = "\(self.viewModelDataFirstCountry?.countryData?.country ?? "")  \t\t\t\(self.viewModelDataSecondCountry?.countryData?.country ?? "")\n\n"
        stringToReturn = String(countries)
        stringToReturn.append("Value: \t\t Year: \t\t Value:\n")
        if (viewModelDataFirstCountry?.countryData != nil && viewModelDataSecondCountry?.countryData != nil){
            for i in 0..<(viewModelDataFirstCountry?.countryData?.valuePerYear.count)!{
                stringToReturn.append(contentsOf: "\(viewModelDataFirstCountry!.countryData!.valuePerYear[i]!.value) \t\t\t \(viewModelDataFirstCountry!.countryData!.valuePerYear[i]!.year) \t\t\t \(viewModelDataSecondCountry!.countryData!.valuePerYear[i]!.value)\n")
            }
        }
        else{
            if(viewModelDataFirstCountry?.countryData == nil && viewModelDataSecondCountry?.countryData != nil){
                stringToReturn = "Sorry!\n data available only for \(viewModelDataSecondCountry?.countryData?.country)\n on this period :("
            }
            if(viewModelDataSecondCountry?.countryData == nil && viewModelDataFirstCountry?.countryData != nil){
                stringToReturn = "Sorry!\n data available only for \(viewModelDataFirstCountry?.countryData?.country)\n on this period :("
            }
            else{
                stringToReturn = "Sorry!\n no available data for both countries\n on this period :("
            }
        }
        return stringToReturn
    }
    
}

