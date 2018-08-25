//
//  FactViewController.swift
//  Cat Facts (API)
//
//  Created by Daniel on 25/8/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class FactViewController: UIViewController {

    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var factLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getCatFact(_ sender: Any) {
        let url = URL(string: "https://dog-api.kinduff.com/api/facts")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if  let data = data, let dataString = String(data:data, encoding: .utf8) {
                print (dataString)
            }
            
        }
        task.resume()
        
    }

}

