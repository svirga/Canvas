//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Simona Virga on 2/21/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController
{

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x , y: trayView.center.y + trayDownOffset)

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func didPanTray(_ sender: Any)
    {
        let location = (sender as AnyObject).location(in: view)
        let velocity = (sender as AnyObject).velocity(in: view)
        let translation = (sender as AnyObject).translation(in: view)
        
        if (sender as AnyObject).state == .began
        {
            trayOriginalCenter = trayView.center
            
            print("Gesture began")
        }
        else if (sender as AnyObject).state == .changed
        {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            print("Gesture is changing")
        }
        else if (sender as AnyObject).state == .ended
        {
            var velocity = (sender as AnyObject).velocity(in: view)
            print("Gesture ended")
            
            if (velocity.y > 0)
            {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            }
            else
            {
                UIView.animate(withDuration: 0.4)
                {
                    self.trayView.center = self.trayUp
                }
            }
            
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer)
    {
        let location = (sender as AnyObject).location(in: view)
        let velocity = (sender as AnyObject).velocity(in: view)
        let translation = (sender as AnyObject).translation(in: view)
        
        if (sender as AnyObject).state == .began
        {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            newlyCreatedFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
             newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            print("Gesture began")
        }
        else if (sender as AnyObject).state == .changed
        {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            print("Gesture is changing")
        }
        else if (sender as AnyObject).state == .ended
        {
            print("Gesture ended")
        }
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer)
    {
        let translation = sender.translation(in: view)
        if sender.state == .began {
            print("Gesture began")
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center 
            
        } else if sender.state == .changed {
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            print("Gesture ended")
            
        }
    }
    
    

}
