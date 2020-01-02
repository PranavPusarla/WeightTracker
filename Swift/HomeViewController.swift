//
//  HomeViewController.swift
//  HelloWorld
//
//  Created by Chandrasekhar pusarla on 12/29/19.
//  Copyright © 2019 Pranav Pusarla. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewHasBeenSet: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel()
        titleLabel.text = "Weight Tracker"
        titleLabel.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        titleLabel.textColor = .systemBlue
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
        ])

    }
    
    override func loadView() {
        super.loadView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!self.viewHasBeenSet) {
            DispatchQueue.main.async {
                self.present(LoginViewController(), animated: true, completion: nil)
            }
            viewHasBeenSet = true
        }
        
    }
    
    static func callAPI() {
        let endpoint: String = ("http://127.0.0.1:5000/total_loss/"+(StatsViewController.firstName!)+"/"+(StatsViewController.lastName!))
        guard let url = URL(string:endpoint) else {
            print("Error cannot create url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            
            guard error == nil else {
                print(error)
                return
            }
            guard let responsed = data else {
                print("Did not receive data")
                return
            }
            let responseData = String(data: responsed, encoding: String.Encoding.utf8)
            print(responseData)
            DispatchQueue.main.async {
                let label = UILabel()
                label.text = responseData
                label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(label)
            }
        })
        task.resume()
    }
}
