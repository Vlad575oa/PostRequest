//
//  ViewController.swift
//  PostRequest
//
//  Created by user on 05.04.2023.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func Send1(_ sender: Any) {
    let course = [
      "name": "Networking",
      "imagerUrl": "image url",
      "numberOfLessons": "10",
      "numberOfTests": "8"
    ]

    NetworkManager.shared.postRequestOne(with: course, to: Link.postRequest1.rawValue) { result in
      switch result {
      case .success(let json):
        print(json)

      case .failure(let error):
        print(error)

      }
    }
  }

  @IBAction func Send2(_ sender: Any) {
    let user = ["username": "Ivan"]
    NetworkManager.shared.postRequestTwo(with: user, to: Link.postRequest2.rawValue) { result in
      switch result {
      case .success(let json):
        print(json)
      case .failure(let error):
        print(error)
      }
    }
  }

  @IBAction func Send3(_ sender: Any) {
    guard let imageData = UIImage(named: "ABC")?.pngData() else {
      return }
    let imageDict = ["data": imageData]

    NetworkManager.shared.postRequestTwo(with: imageDict, to: Link.postRequest2.rawValue) { result in
      switch result {
      case .success(let json):
        print(json)
      case .failure(let error):
        print(error)
      }

    }
  }
  
  
}

