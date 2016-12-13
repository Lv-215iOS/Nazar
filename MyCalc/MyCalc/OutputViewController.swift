//
//  MyViewConroll.swift
//  MyCalc
//
//  Created by AdminAccount on 12/12/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit

protocol OutputInterface {
    func Output()
}
class OutputViewController: UIViewController {
    
        var mainViewController : ViewController? = nil
    
    
    //@IBOutlet weak private var display: UILabel!


    

    /*var displayValue: Double{
        get {
            return Double(display.text!)!
        }set {
            display.text = String(newValue)
        }
    }

    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OutputControllerEmbedSegue" {
            mainViewController = segue.source as? ViewController
        }
    }


}
