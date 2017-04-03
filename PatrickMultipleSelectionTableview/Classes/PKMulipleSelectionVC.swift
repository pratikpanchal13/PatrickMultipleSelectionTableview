//
//  PKMulipleSelectionVC.swift
//  Pods
//
//  Created by indianic on 03/04/17.
//
//

import UIKit

open class PKMulipleSelectionVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
        //open Variable Declaration For Data Passing
        open var objGetSelectedIndex: [Int] = []                       // HomeVC
        
        open var backgroundColorHeaderView: UIColor       = UIColor.init(colorLiteralRed: 76.0/255.0, green: 82.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        open var backgroundColorDoneButton: UIColor       = UIColor.init(colorLiteralRed: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        open var backgroundColorTableView: UIColor        = UIColor.init(colorLiteralRed: 59.0/255.0, green: 65.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        open var backgroundColorSelectALlTitle: UIColor   = UIColor.white
        open var backgroundColorCellTitle: UIColor        = UIColor.init(colorLiteralRed: 87.0/255.0, green: 188.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        open var backgroundColorDoneTitle: UIColor        = UIColor.white
        
        open var isSelectAll : Bool = false
        open var passDataWithIndex:( _ arryData : Any, _ selectedIndex:NSMutableArray)->() = {_ in}
        
        @IBOutlet weak var tblView: UITableView!
        @IBOutlet weak var btnSelectAll: UIButton!
        @IBOutlet weak var viewHeader: UIView!
        @IBOutlet weak var btnDone: UIButton!
        @IBOutlet weak var imgSelectAll: UIImageView!
        @IBOutlet weak var viewContent: UIView!
        
        //open Local Variable Declaration
        open var arrContent: NSMutableArray = []
        open var selectedIndex: NSMutableArray = []
        
        //MARK: - View Life Cycle
        override open func viewDidLoad() {
            super.viewDidLoad()
            
            self.SetUpUI()   // Set UI
            
            tblView.allowsMultipleSelection = true
            tblView.tableFooterView = UIView(frame: .zero)
        }
        
        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            selectedIndex.addObjects(from: objGetSelectedIndex)
            for i in objGetSelectedIndex {
                let indexPath = IndexPath(row: i, section: 0)
                tblView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
            if(selectedIndex.count == arrContent.count){
                
                let imgUnCheck = UIImage(named:"Check", in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
                imgSelectAll.image = imgUnCheck
                isSelectAll = !isSelectAll;
            }
            self.tblView.reloadData()
        }
        
        //MARK: - Set Up UI
        open func SetUpUI()
        {
            self.tblView.backgroundColor = backgroundColorTableView
            self.btnSelectAll.setTitleColor(backgroundColorSelectALlTitle, for: UIControlState.normal)
            self.viewHeader.backgroundColor = backgroundColorHeaderView
            self.btnDone.backgroundColor = backgroundColorDoneButton
            self.btnDone.setTitleColor(backgroundColorDoneTitle, for: UIControlState.normal)
        }
        
        //MARK: - Button Action
        @IBAction func btnBackClicked(_ sender: Any) {
            self.willMove(toParentViewController: nil)
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
        
        @IBAction func btnSelectALL(_ sender: Any) {
            selectedIndex.removeAllObjects()
            if(!isSelectAll)
            {
                for i in arrContent {
                    selectedIndex.add(arrContent.index(of: i))
                }
            }
            
            let imgUnCheck = UIImage(named:"unCheck", in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
            let imgCheck = UIImage(named:"Check", in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
            
            let img:UIImage = (!isSelectAll ? imgCheck : imgUnCheck)!
            imgSelectAll.image = img
            isSelectAll = !isSelectAll
            tblView.reloadData()
        }
        
        @IBAction func btnDoneClicked(_ sender: Any) {
            let passingDataToHomeVC: NSMutableArray = []
            for i  in selectedIndex {
                passingDataToHomeVC.add(arrContent[i as! Int])
            }
            
            let strData = passingDataToHomeVC.componentsJoined(by: ",")
            UserDefaults.standard.set(selectedIndex, forKey: "indexPath")
            UserDefaults.standard.synchronize()
            
            self.passDataWithIndex(strData, selectedIndex)  // Passing Data Using Blocks to Parent VC
            
            self.willMove(toParentViewController: nil)
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
        
        open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 60.0;
        }
        
        open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrContent.count
        }
        
        open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell
            cell?.lblName.text = "\(arrContent[indexPath.row])"
            let aStrImg:String = selectedIndex.contains((indexPath.row)) ? "Check": "unCheck"
            let image = UIImage(named: aStrImg, in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
            cell?.imgVewCheckUnckeck.image = image;
            
            cell?.contentView.backgroundColor = backgroundColorTableView
            cell?.lblName.textColor = backgroundColorCellTitle
            return cell!
        }
        
        open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if selectedIndex.contains(indexPath.row){
                let index  = indexPath.row
                selectedIndex.remove(index)
            }else{
                let index  = indexPath.row
                selectedIndex.add(index)
            }
            if(isSelectAll && selectedIndex.count != arrContent.count){
                
                let imgUnCheck = UIImage(named:"unCheck", in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
                imgSelectAll.image = imgUnCheck
                isSelectAll = !isSelectAll;
            }else if(selectedIndex.count == arrContent.count){
                
                let imgCheck = UIImage(named:"Check", in: Bundle(for: PKMulipleSelectionVC.self), compatibleWith: nil)
                imgSelectAll.image = imgCheck
                isSelectAll = !isSelectAll;
            }
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
        
        //MARK: - View Touch Event
        override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                
                if touch.view != self.viewContent {
                    if touch.view != viewHeader.viewWithTag(1) {
                        if touch.view != imgSelectAll.viewWithTag(2) {
                            
                            self.willMove(toParentViewController: nil)
                            self.view.removeFromSuperview()
                            self.removeFromParentViewController()
                        }
                    }
                }
            }
            super.touchesBegan(touches, with:event)
        }
    }
    
    // TableView Cell
    open class Cell: UITableViewCell {
        @IBOutlet weak var lblName: UILabel!
        @IBOutlet weak var imgVewCheckUnckeck: UIImageView!
}
