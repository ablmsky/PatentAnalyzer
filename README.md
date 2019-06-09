# PatentAnalyzer
This is my  iOS app, about patent. 

# Nowadays
demo version 2.0 

    - function for comparing countries were added
    
    - some interface update
    
    - also left: changing API-working (response from server needed to be checking on errors), checking internet connection
    - FIX THIS SHITTY BUG, idk how, but will try

# Bugs in this version
for function "compare countries"
    
    - when you choosed smthng and got your info on screen, if you decide to go back, so firstly, before choosing date (only date for example), you need to go on first picker (where you choosing country). In another way you'll catch error:(
    Sorry for this, will fix as soon as i can.
    
# Overall

So, what the goal?

This application - my university project (not my idea at all, actually)

What will be in this app?
I get data from worlbank.org parse it and try to visualize all info.
Like in example with charts from Charts Pod https://cocoapods.org/pods/Charts
#
Stack of technology which will be here:
  
  First of all, MVVM arch.
  
  Some patterns like Observer
  
  RxSwift for async and MVVM (decided to don't use it)
  
  Working with a network (with Alamofire maybe)
  
  Some Interface uniques libraries like Stork (already in app (ChartViewController))
  
  Working with JSON
  
  And try to follow SOLID rules.
#
  
Demo version 1.0 Watch gif.

![](PatentAnalyzer.gif)

