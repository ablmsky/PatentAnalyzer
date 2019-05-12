//
//  CharViewController.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 04/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//
import UIKit
import Foundation
import SPStorkController
import Charts

class ChartViewController: UIViewController, ChartViewDelegate{
    var viewModelData: ViewModelModelData?
    var myScrollView = UIScrollView()
    let coordX = 6.5//step for x coordinate on charts view
    var startingText: String?
    var chartViewFirst = BarChartView()
    var chartViewSecond = BarChartView()
    var textField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.setNeedsLayout()
        myScrollView.layoutIfNeeded()
        self.modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = UIColor.darkGray
        let screenSize: CGRect = self.view.bounds
        let screenWidth = screenSize.width
        
        chartViewFirst = BarChartView(frame: CGRect(x: coordX, y: 30, width: Double(screenWidth) - (coordX*2) , height: 450))
        textField = UITextView(frame: CGRect(x: coordX, y: 500, width: Double(screenWidth) - (coordX*2) , height: 100))
        chartViewSecond = BarChartView(frame: CGRect(x: coordX, y: 630, width: Double(screenWidth) - (coordX*2), height: 450))
        chartViewSecond.backgroundColor = UIColor.red
        
        if (viewModelData!.countryData == nil){
            chartViewFirst.noDataText = "Sorry, no available data"
            chartViewFirst.noDataTextColor = UIColor.white
            textField.backgroundColor = UIColor.darkGray
            startingText = " "
        }
        else{
            setChart(dataPoints: viewModelData!.reorginizedYears(), values: viewModelData!.reorginizedValues())
                textField.text = viewModelData?.allToString()
                startingText = textField.text
                textField.defaultValues()
                chartViewFirst.delegate = self
        }
        chartViewFirst.defaultValues()
        //
        
        myScrollView = UIScrollView(frame: self.view.bounds)
        myScrollView.addSubview(chartViewFirst)
        myScrollView.addSubview(textField)
        myScrollView.addSubview(chartViewSecond)
        myScrollView.contentSize = CGSize(width: self.myScrollView.frame.size.width ,height: 1500)
        self.view.addSubview(myScrollView)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        var dataEntries: [BarChartDataEntry] = []
        let formato:BarChartFormatter = BarChartFormatter(years: dataPoints)
        let xaxis:XAxis = XAxis()
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y:Double(values[i]))
            dataEntries.append(dataEntry)
            _ = formato.stringForValue(Double(i), axis: xaxis)
        }
        xaxis.valueFormatter = formato
        let chartDataSet = BarChartDataSet(values: dataEntries, label: viewModelData!.countryData!.country)
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartViewFirst.data = chartData
        chartViewFirst.xAxis.valueFormatter = xaxis.valueFormatter
        
    }
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        textField.text = "\nYear: \(getYearsByIndex(highlight.x)) - Number of Patents: \(Int(highlight.y))"
        textField.font = UIFont(name: textField.font!.fontName, size: 21)
        _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { timer in
            self.textField.text = self.startingText
        })
        
    }
    func getYearsByIndex(_ index: Double) -> String{
        var array = viewModelData!.reorginizedYears()
        return array[Int(index)]
    }
        
}

extension BarChartView{
    func defaultValues(){
        self.animate(xAxisDuration: 3.0)
        self.xAxis.drawAxisLineEnabled = false
        self.xAxis.drawGridLinesEnabled = false
        self.leftAxis.drawAxisLineEnabled = false
        self.leftAxis.drawGridLinesEnabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.xAxis.labelPosition = .bottom
        self.rightAxis.drawLabelsEnabled = false
        self.xAxis.labelTextColor = UIColor.white
        self.leftAxis.labelTextColor = UIColor.white
        self.legend.enabled = false
    }
}
extension UITextView{
    func defaultValues(){
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 15
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.font = UIFont(name: self.font!.fontName , size: 21)
        self.isEditable = false
    }
}
@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter{
    var years: [String]
    init(years: [String]){
        self.years = years
    }
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return years[Int(value)]
    }
}
