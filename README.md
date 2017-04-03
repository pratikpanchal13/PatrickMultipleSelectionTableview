 
![alt text](https://github.com/pratikpanchal13/PatrickMultipleSelectionTableview/blob/master/Pratik.gif)

# PatrickMultipleSelectionTableview

[![CI Status](http://img.shields.io/travis/pratikpanchal131/PatrickMultipleSelectionTableview.svg?style=flat)](https://travis-ci.org/pratikpanchal131/PatrickMultipleSelectionTableview)
[![Version](https://img.shields.io/cocoapods/v/PatrickMultipleSelectionTableview.svg?style=flat)](http://cocoapods.org/pods/PatrickMultipleSelectionTableview)
[![License](https://img.shields.io/cocoapods/l/PatrickMultipleSelectionTableview.svg?style=flat)](http://cocoapods.org/pods/PatrickMultipleSelectionTableview)
[![Platform](https://img.shields.io/cocoapods/p/PatrickMultipleSelectionTableview.svg?style=flat)](http://cocoapods.org/pods/PatrickMultipleSelectionTableview)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 3.0
* Xcode 8
* iOS 9.0+

## Installation

#### [CocoaPods](http://cocoapods.org) (recommended)

MST1 is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile

````ruby
use_frameworks!

pod 'PatrickMultipleSelectionTableview', :git => 'https://github.com/pratikpanchal13/PatrickMultipleSelectionTableview.git'
````


## USAGE

import PatrickMultipleSelectionTableview in ViewController.swift

````ruby   
import PatrickMultipleSelectionTableview
````

To Show MulitpleSelection Controller in your Controller Call Function showMultipleSelection()
````ruby
func showMultipleSelectionTableview()
{

    let podBundle = Bundle(for: PKMulipleSelectionVC.self)
    let bundleURL = podBundle.url(forResource: "PatrickMultipleSelectionTableview", withExtension: "bundle")
    let bundle = Bundle(url: bundleURL!)!
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    let vc:PKMulipleSelectionVC = storyboard.instantiateViewController(withIdentifier: "PKMulipleSelectionVC") as! PKMulipleSelectionVC

    vc.arrContent = ["IPhone","IMac","IPad","MacBook","IPod","MacMini","Apple TV"]  // Pass Array Data
    vc.backgroundColorDoneButton        = UIColor.init(colorLiteralRed: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    vc.backgroundColorHeaderView        = UIColor.init(colorLiteralRed: 76.0/255.0, green: 82.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    vc.backgroundColorTableView         = UIColor.init(colorLiteralRed: 59.0/255.0, green: 65.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    vc.backgroundColorCellTitle         = UIColor.init(colorLiteralRed: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    vc.backgroundColorDoneTitle         = UIColor.white
    vc.backgroundColorSelectALlTitle    = UIColor.white

    // Get Selected Index from PKMultipleSelectionVC
    if let returnIndex = UserDefaults.standard.object(forKey: "indexPath") as? [Int] {
        vc.objGetSelectedIndex = returnIndex
    }

    // Data Passing Usning Block
    vc.passDataWithIndex = { arrayData, selectedIndex in
        self.btnClickeMe.setTitle("\(arrayData)", for: UIControlState.normal)
        UserDefaults.standard.set(arrayData, forKey: "data")
        UserDefaults.standard.synchronize()
    }

    vc.willMove(toParentViewController: self)
    self.view.addSubview(vc.view)
    self.addChildViewController(vc)
    vc.didMove(toParentViewController: self)
}
    
````

## Author

pratikpanchal131, pratik.panchal13@gmail.com

## License

PatrickMultipleSelectionTableview is available under the MIT license. See the LICENSE file for more info.
