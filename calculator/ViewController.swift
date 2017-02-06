//
//  ViewController.swift
//  calculator
//
//  Created by Brandon Stone on 12/14/16.
//  Copyright © 2016 Brandon Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var timeDate: UILabel!
    @IBOutlet weak var viewFade: UIView!
    @IBOutlet weak var currencySign: UILabel!
    
    let userDefaults = UserDefaults()
    var dateFormatter = DateFormatter()
    let timePassed = NSDate()
    var currSign = NSLocale.current.currencySymbol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencySign.text = currSign
        self.billField.becomeFirstResponder()
        dateFormatter.dateFormat = "MM/dd"
        self.timeDate.text = "Today's Date: " + dateFormatter.string(from: Date())
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currSign = NSLocale.current.currencySymbol
        
        /*var time = NSDate.init()
         if (userDefaults.object(forKey: "time") != nil){
         time = userDefaults.object(forKey: "time") as! NSDate
         print(time.timeIntervalSinceNow)
         }
         
         if(time.timeIntervalSinceNow <= 600 && billAmount != 0){
         billField.text = String(format: "%.2f", billAmount)
         }*/
        
        //Sets all Labels and the segment control back to last
        tipControl.selectedSegmentIndex = userDefaults.integer(forKey: "defaultTip")
        billField.text = userDefaults.string(forKey: "savedLastAmount")
        tipLabel.text = userDefaults.string(forKey: "savedLastTip")
        totalLabel.text = userDefaults.string(forKey: "savedLastTotal")
        
        //Makes sure that if the bill field has text the animation still comes up
        animateView(num: 0)
        
        colorChanger()
    }

    @IBAction func calculateTip(_ sender: Any) {
        let billAmount = billField.text
        
        //Basic Calculations
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let bill = Double(billAmount!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = currSign! + String(format: "%.2f", roundUp(total: total))
        
        //Saves last texts
        userDefaults.set(billAmount, forKey: "savedLastAmount")
        userDefaults.set(tipLabel.text, forKey: "savedLastTip")
        userDefaults.set(totalLabel.text, forKey: "savedLastTotal")
        userDefaults.synchronize()
        
        animateView(num: 1)
    }
    
    //Slide Up/Down Animation
    func animateView(num: Int){
        if(num == 0){
            if(billField.text != ""){
                UIView.animate(withDuration: 0.1, delay: 0, options: [UIViewAnimationOptions.curveEaseIn],animations: {
                    self.viewFade.frame.origin.y = 225.0
                }, completion: nil)
            }
        }
        if(num == 1){
            if(billField.text != ""){
                UIView.animate(withDuration: 0.3, delay: 0.2, options: [UIViewAnimationOptions.curveEaseIn],animations: {
                    self.viewFade.frame.origin.y = 225.0
                }, completion: nil)}
            if(billField.text == ""){
                UIView.animate(withDuration: 0.1, delay: 0, options: [UIViewAnimationOptions.curveEaseIn],animations: {
                    self.viewFade.frame.origin.y = 500.0
                }, completion: nil)
            }
            
        }
    }
    
    func roundUp(total: Double) -> Double{
        var total = total
        
        if(userDefaults.bool(forKey: "defaultRound")){
            let temp = Double(Int(total))
            
            if(total != temp){
                total = Double(Int(total)) + 1
            }
            else{
                total = Double(Int(total))
            }
        }
        
        return total
    }
    
    /*func currencyChanger(total: Double)-> Double{
     var total = total
     
     if(currSign == "$"){
     total = roundUp(total: total)
     }
     return total
     }*/
    
    func colorChanger(){
        if(!(userDefaults.bool(forKey: "defaultMode"))){
            self.navigationController!.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = UIColor.blue
            self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
            self.view.backgroundColor = UIColor.white
            
            self.tipControl.tintColor = UIColor.blue
            self.billField.tintColor = UIColor.black
            self.billField.textColor = UIColor.black
            self.tipLabel.textColor = UIColor.black
            self.totalLabel.textColor = UIColor.black
            self.timeDate.textColor = UIColor.black
            self.currencySign.textColor = UIColor.black
        }
        if(userDefaults.bool(forKey: "defaultMode")){
            self.navigationController!.navigationBar.barTintColor = UIColor.darkGray
            self.navigationController?.navigationBar.tintColor = UIColor.orange
            self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            self.view.backgroundColor = UIColor.darkGray
            
            self.tipControl.tintColor = UIColor.orange
            self.billField.tintColor = UIColor.white
            self.billField.textColor = UIColor.white
            self.tipLabel.textColor = UIColor.white
            self.totalLabel.textColor = UIColor.white
            self.timeDate.textColor = UIColor.orange
            self.currencySign.textColor = UIColor.white
        }
    }

}

