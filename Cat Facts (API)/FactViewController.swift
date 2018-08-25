//
//  FactViewController.swift
//  Cat Facts (API)
//
//  Created by Daniel on 25/8/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class FactViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var factLabel: UILabel!
    
    var seenFacts: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchOnlineDogFact(completion: @escaping (DogFact?) -> Void) {
        let url = URL(string: "https://dog-api.kinduff.com/api/facts")!
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
    
    func fetchDogGif (completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: "https://api.thedogapi.com/v1/images/search?format=src&mime_types=image/gif")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let image = UIImage.gif(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task.resume()
        
    }
    
    @IBAction func getCatFact(_ sender: Any) {
        fetchOnlineDogFact{ (dogFact) in
            if let dogeFact = dogFact {
                DispatchQueue.main.async {
                    self.factLabel.text = dogeFact.text[0]
                    self.seenFacts.append(dogeFact.text[0])
                    print (self.seenFacts)
                }
            }
            
        }
        
        fetchDogGif { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.gifImageView.image = image
                }
            }
        }
        
        
    }
    

    @IBAction func histButton(_ sender: Any) {
        performSegue(withIdentifier: "goToHistory", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHistory" {
            let destination = segue.destination as! HistoryTableViewController
            destination.pastFacts = seenFacts
        }
    }
}

