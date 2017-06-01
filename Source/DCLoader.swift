//
//  DCLoader.swift
//  DCLoader
//
//  Created by Alex on 2017/5/31.
//  Copyright © 2017年 Alex. All rights reserved.
//

import UIKit

class DCLoader: UIView {
    
    private static let shard = DCLoader(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height/2-50, width: UIScreen.main.bounds.width, height: 100))
    
    enum LoaderStyle {
        case rotation
        case replace
    }
    
    private var imageSize = CGSize(width: 50, height: 50)
    
    private var loaderImages = [UIImage(named: "load.png")!]
    
    private var imageView = UIImageView()
    
    private var bgView: UIView = {
        let bV = UIView(frame: CGRect.init(x: UIScreen.main.bounds.width/2-50, y: 100/2-50, width: 100, height: 100))
        bV.backgroundColor = UIColor.groupTableViewBackground
        bV.layer.cornerRadius = 20
        return bV
    }()
    
    static func setLoaderWith(size: CGSize, images: [UIImage], backgroundView: UIView) {
        
        let loader = DCLoader.shard
        
        if images.count != 0 {
            loader.loaderImages = images
            loader.imageSize = size
        }
        
        if backgroundView.frame.size.width != 0 {
            loader.bgView = backgroundView
        }
    }
    
    private func replaceView() {
        self.imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        self.imageView.center = bgView.center
        
        self.imageView.animationImages = loaderImages
        
        self.imageView.animationDuration = 1
        
        self.imageView.animationRepeatCount = Int.max
        
        self.imageView.startAnimating()
        
        DCLoader.shard.addSubview(imageView)
        
        UIApplication.shared.keyWindow?.addSubview(DCLoader.shard)
    }
    
    private func rotationView() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 1 * Double.pi
        
        anim.duration = 0.5
        
        anim.repeatCount = MAXFLOAT
        
        anim.isRemovedOnCompletion = true
        
        self.imageView = UIImageView(frame: CGRect.init(x: bgView.frame.width/2-imageSize.width/2, y: bgView.frame.height/2-imageSize.height/2, width: imageSize.width, height: imageSize.height))
        
        self.imageView.image = loaderImages.first
        
        self.imageView.layer.add(anim, forKey: nil)
        
        bgView.addSubview(imageView)
        
        DCLoader.shard.addSubview(bgView)
        
        UIApplication.shared.keyWindow?.addSubview(DCLoader.shard)
    }
    
    static func showWith(type: LoaderStyle) {
        let loader = DCLoader.shard
        
        if type == .rotation {
            loader.rotationView()
        } else if type == .replace {
            loader.replaceView()
        }
    }
    
    static func hide() {
        DCLoader.shard.imageView.removeFromSuperview()
        DCLoader.shard.bgView.removeFromSuperview()
        DCLoader.shard.removeFromSuperview()
    }
}
