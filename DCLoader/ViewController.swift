//
//  ViewController.swift
//  DCLoader
//
//  Created by Alex on 2017/5/31.
//  Copyright © 2017年 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rotationButton: UIButton!
    @IBOutlet weak var replaceButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var hideButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func rotationType(_ sender: Any) {
        showButton.isEnabled = true
        replaceButton.isEnabled = true
        rotationButton.isEnabled = false
        
        DCLoader.setLoaderWith(size: CGSize.init(width: 50, height: 50), images: [UIImage(named: "load.png")!], backgroundView: UIView())
    }
    
    @IBAction func replaceType(_ sender: Any) {
        showButton.isEnabled = true
        replaceButton.isEnabled = false
        rotationButton.isEnabled = true
        
        DCLoader.setLoaderWith(size: CGSize.init(width: 200, height: 50), images: [UIImage(named: "数据上传1")!, UIImage(named: "数据上传2")!, UIImage(named: "数据上传3")!], backgroundView: UIView())
    }
    
    @IBAction func showLoader(_ sender: Any) {
        if !replaceButton.isEnabled {
            DCLoader.showWith(type: .replace)
        } else if !rotationButton.isEnabled {
            DCLoader.showWith(type: .rotation)
        } else {
            print("请选择")
        }
        
        hideButton.isEnabled = true
        showButton.isEnabled = false
        rotationButton.isEnabled = false
        replaceButton.isEnabled = false
    }
    
    @IBAction func hideLoader(_ sender: Any) {
        showButton.isEnabled = true
        hideButton.isEnabled = false
        rotationButton.isEnabled = true
        replaceButton.isEnabled = true
        DCLoader.hide()
    }
}

