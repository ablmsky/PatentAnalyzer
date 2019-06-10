# PatentAnalyzer
This is my  iOS app, about registered patents for country/region for year/years/period, with possibility of comparing countries. 

# Nowadays
demo version 2.1 

    - everything from previous version were fixed
    
    - keep in mind, sometimes data equals to 0, better to choose progressive countries 
    
    
# Bugs in this version
for function Picker
    
    - when you scroll too fast, and don't waiting,when value will be shown on label, then catch an error
    Sorry for this, but it's kinda of global problem, not a local things.
    
# Overall

So, what the goal?

This application - my university project (not my idea at all, actually)

What will be in this app?
I get data from worlbank.org get it and try to visualize all info.
Like in example with charts from Charts Pod https://cocoapods.org/pods/Charts
#
Stack of technology which will be here:
  
  First of all, MVVM arch.
  
  Some patterns like Observer
  
  RxSwift for async and MVVM (decided to don't use it)
  
  Working with a network (with Alamofire maybe)
  
  Some Interface unique libraries like Stork (already in app (ChartViewController))
  
  Working with JSON
  
  And try to follow SOLID rules.
#
  
Demo version 1.0 gif.

![](PatentAnalyzer.gif)

