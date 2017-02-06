//
//  SettingsViewController.swift
//  calculator
//
//  Created by Brandon Stone on 12/16/16.
//  Copyright © 2016 Brandon Stone. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var defaultTipPercentange: UISegmentedControl!
    @IBOutlet weak var roundSwitch: UISwitch!
    @IBOutlet weak var nightSwitch: UISwitch!
    
    let userDefaults = UserDefaults()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        roundSwitch.isOn = userDefaults.bool(forKey: "defaultRound")
        nightSwitch.isOn = userDefaults.bool(forKey: "defaultMode")
        defaultTipPercentange.selectedSegmentIndex = userDefaults.integer(forKey: "defaultTip")
        
        colorChanger()
    }
    
    @IBAction func changeDefault(_ sender: Any) {
        userDefaults.set(defaultTipPercentange.selectedSegmentIndex, forKey: "defaultTip")
        userDefaults.synchronize()
        
    }
    
    @IBAction func swithRound(_ sender: Any) {
        userDefaults.set(roundSwitch.isOn, forKey: "defaultRound")
        userDefaults.synchronize()
    }
    
    @IBAction func switchMode(_ sender: Any) {
        userDefaults.set(nightSwitch.isOn, forKey: "defaultMode")
        userDefaults.synchronize()
        
        colorChanger()
    }
    
    func colorChanger(){
        if(!(userDefaults.bool(forKey: "defaultMode"))){
            self.navigationController!.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = UIColor.blue
            self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
            self.view.backgroundColor = UIColor.white
            
            self.defaultTipPercentange.tintColor = UIColor.blue
            self.defaultLabel.textColor = UIColor.black
            self.roundLabel.textColor = UIColor.black
            self.nightLabel.textColor = UIColor.black
        }
        if(userDefaults.bool(forKey: "defaultMode")){
            self.navigationController!.navigationBar.barTintColor = UIColor.darkGray
            self.navigationController?.navigationBar.tintColor = UIColor.orange
            self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            self.view.backgroundColor = UIColor.darkGray
            
            self.defaultTipPercentange.tintColor = UIColor.orange
            self.defaultLabel.textColor = UIColor.white
            self.roundLabel.textColor = UIColor.white
            self.nightLabel.textColor = UIColor.white
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
