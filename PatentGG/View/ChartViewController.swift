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

class ChartViewController: UIViewController{
    var viewModelData: ViewModelModelData?
    var myScrollView = UIScrollView()
    let coordX = 6.5//step for x coordinate on charts view
    var chartViewFirst = BarChartView()
    var chartViewSecond = BarChartView()
    
    // var entry = BarChartDataEntry
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.setNeedsLayout()
        myScrollView.layoutIfNeeded()
        self.modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = UIColor.darkGray
        let screenSize: CGRect = self.view.bounds
        let screenWidth = screenSize.width
        chartViewFirst = BarChartView(frame: CGRect(x: coordX, y: 30, width: Double(screenWidth) - (coordX*2) , height: 450))
        chartViewSecond = BarChartView(frame: CGRect(x: coordX, y: 530, width: Double(screenWidth) - (coordX*2), height: 450))
        chartViewSecond.backgroundColor = UIColor.red
        //chartViewFirst.backgroundColor = UIColor.green
        //
        setChart(dataPoints: reorginizedData(forYearsTrue: true), values: reorginizedData(forYearsTrue: false))
        
        //
        
        myScrollView = UIScrollView(frame: self.view.bounds)
        myScrollView.addSubview(chartViewFirst)
        myScrollView.addSubview(chartViewSecond)
        myScrollView.contentSize = CGSize(width: self.myScrollView.frame.size.width ,height: 1200)
        self.view.addSubview(myScrollView)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func reorginizedData(forYearsTrue: Bool)->[Int]{//needed to remove to VM
        var array: [Int] = []
        if forYearsTrue{
            for element in viewModelData!.countryData!.valuePerYear{
                array.append(element!.year)
            }
        }
        else{
            for element in viewModelData!.countryData!.valuePerYear{
                array.append(element!.value)
            }
        }
        return array
    }
    func setChart(dataPoints: [Int], values: [Int]) {
        chartViewFirst.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(values[i]), y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: viewModelData!.countryData!.country)
        let chartData = BarChartData(dataSet: chartDataSet)
        chartViewFirst.data = chartData
    }
        
}

