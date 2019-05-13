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
    var chartViewSecond = PieChartView()
    var textField = UITextView()
    var descriptionToPieChart = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.setNeedsLayout()
        myScrollView.layoutIfNeeded()
        self.modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = UIColor.darkGray
        let screenSize: CGRect = self.view.bounds
        let screenWidth = screenSize.width
        //region init sizes
        chartViewFirst = BarChartView(frame: CGRect(x: coordX, y: 30, width: Double(screenWidth) - (coordX*2) , height: 450))
        textField = UITextView(frame: CGRect(x: coordX, y: 500, width: Double(screenWidth) - (coordX*2) , height: 100))
        chartViewSecond = PieChartView(frame: CGRect(x: coordX, y: 630, width: Double(screenWidth) - (coordX*2), height: 450))
        descriptionToPieChart = UILabel(frame: CGRect(x: coordX, y: 1050, width: Double(screenWidth) - (coordX*2), height: 50))
        //chartViewSecond.backgroundColor = UIColor.red
        //checking available data
        if (viewModelData!.countryData == nil){
            chartViewFirst.noDataText = "Sorry, no available data"
            chartViewSecond.noDataText = " "
            chartViewFirst.noDataTextColor = UIColor.white
            textField.backgroundColor = UIColor.darkGray
            startingText = " "
        }
        else{
            textField.text = viewModelData?.allToString()
            setBarChart(dataPoints: viewModelData!.reorginizedYears(), values: viewModelData!.reorginizedValues())
            setPieChart(dataPoints: viewModelData!.reorginizedYears(), values: viewModelData!.reorginizedValues())
            startingText = textField.text
            chartViewFirst.defaultValues()
            chartViewSecond.defaultValues()
            textField.defaultValues()
            chartViewFirst.delegate = self
            chartViewSecond.delegate = self
            descriptionToPieChart.text = "This chart demonstrate % from sum on period"
            descriptionToPieChart.defaultValues()
        }
        
        //adding elements to ScrollView
        myScrollView = UIScrollView(frame: self.view.bounds)
        myScrollView.addSubview(chartViewFirst)
        myScrollView.addSubview(textField)
        myScrollView.addSubview(chartViewSecond)
        myScrollView.addSubview(descriptionToPieChart)
        myScrollView.contentSize = CGSize(width: self.myScrollView.frame.size.width ,height: 1150)
        self.view.addSubview(myScrollView)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //region functions for BarChart
    func setBarChart(dataPoints: [String], values: [Int]) {
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
        chartDataSet.colors = ChartColorTemplates.joyful()
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartViewFirst.data = chartData
        chartViewFirst.xAxis.valueFormatter = xaxis.valueFormatter
        let ll = ChartLimitLine(limit: Double(viewModelData?.averageValue() ?? 0), label: "Average")
        ll.lineColor = UIColor.white
        chartViewFirst.rightAxis.addLimitLine(ll)
        ll.valueTextColor = UIColor.black
        self.textField.text.append("Average number: \(viewModelData!.averageValue())")
        
    }
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        textField.text = "\nYear: \(getYearsByIndex(highlight.x)) - Number of Patents: \(Int(highlight.y))"
        textField.font = UIFont(name: textField.font!.fontName, size: 20)
        _ = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false, block: { timer in
            self.textField.text = self.startingText
        })
        
    }
    func getYearsByIndex(_ index: Double) -> String{
        var array = viewModelData!.reorginizedYears()
        return array[Int(index)]
    }
    
    //region PieChart
    func setPieChart(dataPoints: [String], values: [Int]) {
        
        var dataEntries: [ChartDataEntry] = []
        //let sum = (viewModelData?.sumValue())!
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y:Double(values[i]))
            dataEntries.append(dataEntry)
            //(Double(values[i])/Double(sum)) * 100)
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: viewModelData!.countryData!.country)
        pieChartDataSet.colors = ChartColorTemplates.joyful()
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chartViewSecond.data = pieChartData
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25),
            .foregroundColor: UIColor.white
        ]
        let myAttrString = NSAttributedString(string: "\((viewModelData?.countryData!.country)!) in % ", attributes: attributes)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1.0
        formatter.percentSymbol = "%"
        formatter.zeroSymbol = ""
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        chartViewSecond.centerAttributedText = myAttrString
        //pieChartDataSet.drawIconsEnabled = true
        pieChartDataSet.drawValuesEnabled = true
       // chartViewSecond.drawEntryLabelsEnabled = true
        //chartViewSecond.drawMarkers = true// drawSliceTextEnabled = false
        pieChartData.setValueTextColor(.black)
    }
        
}

extension BarChartView{
    func defaultValues(){
        self.animate(xAxisDuration: 2.0)
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
extension PieChartView{
    func defaultValues(){
        self.animate(xAxisDuration: 3.0)
        self.rotationEnabled = false
        self.dragDecelerationEnabled = false
        self.legend.enabled = false
        self.entryLabelColor = UIColor.white
        self.holeColor = UIColor.darkGray
        self.usePercentValuesEnabled = true
    }
}
extension UITextView{
    func defaultValues(){
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 5
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.font = UIFont(name: self.font!.fontName , size: 20)
        self.isEditable = false
    }
}
extension UILabel{
    func defaultValues(){
        self.textColor = UIColor.white
        self.font = UIFont(name: self.font!.fontName , size: 16)
        self.backgroundColor = UIColor.darkGray
        self.textAlignment = NSTextAlignment.center
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
