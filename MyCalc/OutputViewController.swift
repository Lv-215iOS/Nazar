//
//  OutputViewController.swift
//  MyCalc
//
//  Created by AdminAccount on 12/14/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit

protocol OutputInterface {
    func outputInfo(info: String?)
}

class OutputViewController:UIViewController, OutputInterface{
    
    var mainViewController : ViewController? = nil
    //var mainViewController : OutputInterface? = nil
    
    @IBOutlet weak var display: UILabel!
        
    @IBOutlet weak var display2: UILabel!
    func outputInfo(info: String?){
        display.text = display.text! + info!
        display2.text = info!
    }
}
/*var displayValue: Double{
 get {
 return Double(display.text!)!
 }set {
 display.text = String(newValue)
 }
 }
 
 */
/*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == "OutputControllerEmbedSegue" {
 mainViewController = segue.source as? ViewController
 }
 }
 */

