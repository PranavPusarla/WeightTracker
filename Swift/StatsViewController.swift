//
//  HomeViewController.swift
//  HelloWorld
//
//  Created by Chandrasekhar pusarla on 12/26/19.
//  Copyright © 2019 Pranav Pusarla. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    static var firstName: String?
    static var lastName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let graphButton = UIButton()
        graphButton.backgroundColor = .systemBlue
        graphButton.layer.cornerRadius = 24.0
        graphButton.setTitleColor(.white, for: .normal)
        graphButton.setTitle("Update Graph", for: .normal)
        graphButton.addTarget(self, action: #selector(displayGraph), for: .touchUpInside)
        graphButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(graphButton)
        graphButton.setTitleColor(.gray, for: .highlighted)
        
        NSLayoutConstraint.activate([
            graphButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48.0),
            graphButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
            graphButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -112.0),
            graphButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "Total Weight Progression"
        titleLabel.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
        ])
        
        var graphURL = ""
        let endpoint: String=("http://127.0.0.1:5000/total_weights_graph/"+StatsViewController.firstName!+"/"+StatsViewController.lastName!)
            guard let url = URL(string: endpoint) else {
                print("Error: cannot create url")
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
                    print("Error: did not receive data")
                    return
                }
                
                print(response)
                let responseData = String(data: responsed, encoding: String.Encoding.utf8)
                graphURL = responseData!
                print(graphURL)
                let totalGraphURL = URL(string: graphURL)!
                let session2 = URLSession(configuration: .default)

                let downloadPicTask = session2.dataTask(with: totalGraphURL) {data, response, error in
                    if let e = error {
                        print("Error downloading picture from url")
                    } else {
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded image with response code \(res.statusCode)")
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {let imageView = UIImageView(image: image!)
                                    imageView.frame.size = CGSize(width: self.view.frame.width, height: 400)
                                    imageView.center = self.view.center
                                self.view.addSubview(imageView)}
                            } else {
                                print("Couldn't get image: image is nil")
                            }
                        }
                    }
                }
                downloadPicTask.resume()
            })
            task.resume()
        
        let second_endpoint: String=("http://127.0.0.1:5000/weekly_weights_graph/"+StatsViewController.firstName!+"/"+StatsViewController.lastName!)
            guard let second_url = URL(string: second_endpoint) else {
                print("Error: cannot create url")
                return
            }
            let second_urlRequest = URLRequest(url: second_url)
            let second_session = URLSession.shared
            let second_task = second_session.dataTask(with: second_urlRequest, completionHandler: {data, response, error in
                guard error == nil else {
                    print(error)
                    return
                }
                guard let responsed = data else {
                    print("Error: did not receive data")
                    return
                }
                
                print(response)
                let responseData = String(data: responsed, encoding: String.Encoding.utf8)
                graphURL = responseData!
                print(graphURL)
                let totalGraphURL = URL(string: graphURL)!
                let session2 = URLSession(configuration: .default)

                let downloadPicTask = session2.dataTask(with: totalGraphURL) {data, response, error in
                    if let e = error {
                        print("Error downloading picture from url")
                    } else {
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded image with response code \(res.statusCode)")
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {let imageView = UIImageView(image: image!)
                                    imageView.frame = CGRect(x:50, y: 50, width: self.view.frame.width, height: 300)
                                self.view.addSubview(imageView)}
                            } else {
                                print("Couldn't get image: image is nil")
                            }
                        }
                    }
                }
                downloadPicTask.resume()
            })
            task.resume()
    }
    
    @objc func displayGraph(sender: UIButton) {
//            var index = full_name.firstIndex(of: " ")!
//            let first_name = full_name[..<index]
//            index = full_name.index(full_name.firstIndex(of: " ")!, offsetBy: 1)
//            let last_name = full_name[index...]
        var graphURL = ""
        let endpoint: String=("http://127.0.0.1:5000/total_weights_graph/"+StatsViewController.firstName!+"/"+StatsViewController.lastName!)
            guard let url = URL(string: endpoint) else {
                print("Error: cannot create url")
                return
            }
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
                guard error == nil else {
                    print(error)
                    return
                }
                guard let responsed = data else {
                    print("Error: did not receive data")
                    return
                }
                
                print(response)
                let responseData = String(data: responsed, encoding: String.Encoding.utf8)
                graphURL = responseData!
                print(graphURL)
                let totalGraphURL = URL(string: graphURL)!
                let session2 = URLSession(configuration: .default)

                let downloadPicTask = session2.dataTask(with: totalGraphURL) {data, response, error in
                    if let e = error {
                        print("Error downloading picture from url")
                    } else {
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded image with response code \(res.statusCode)")
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {let imageView = UIImageView(image: image!)
                                    imageView.frame.size = CGSize(width: self.view.frame.width, height: 400)
                                    imageView.center = self.view.center
                                self.view.addSubview(imageView)}
                            } else {
                                print("Couldn't get image: image is nil")
                            }
                        }
                    }
                }
                downloadPicTask.resume()
            })
            task.resume()
            
            
            
    }
}
