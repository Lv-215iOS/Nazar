//
//  OutputViewController.swift
//  MyCalc
//
//  Created by AdminAccount on 12/14/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit



class OutputViewController:UIViewController, OutputInterface {
    
    var mainViewController : ViewController? = nil
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var display2: UILabel!
    
    func outputInfo(info: String?){
        display.text = display.text! + info!
        display2.text = info!
    }
}
