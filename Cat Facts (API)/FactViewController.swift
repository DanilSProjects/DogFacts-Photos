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
    
    func fetchOnlineCatFact(completion: @escaping (DogFact?) -> Void) {
        let url = URL(string: "https://cat-fact.herokuapp.com/facts/random")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if  let data = data,
                let dogFact = try? jsonDecoder.decode(DogFact.self, from: data) {
               completion(dogFact)
            } else {
                completion(nil)
            }
            
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task.resume()
        
    }
    
    
    @IBAction func getCatFact(_ sender: Any) {
        fetchOnlineCatFact{ (dogFact) in
            if let dogeFact = dogFact {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.factLabel.text = dogeFact.text
                }
            }
            
        }
    }

}

