//
//  OutputViewController.swift
//  MyCalc
//
//  Created by AdminAccount on 12/14/16.
//  Copyright © 2016 AdminAccount. All rights reserved.
//

import UIKit



class OutputViewController: UIViewController, OutputInterface {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var display2: UILabel!
    
    func outputInfo(info: String?){
        display.text =  info!
    }
    
    func outputResult(result: String?){
        display2.text = result!
    }
}
