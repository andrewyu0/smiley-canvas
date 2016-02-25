//
//  ViewController.swift
//  Canvas
//
//  Created by Andrew Yu on 2/24/16.
//  Copyright © 2016 Andrew Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!

    // Faces
    @IBOutlet weak var happyFaceControlImageView: UIImageView!
    @IBOutlet weak var winkyFaceControlImageView: UIImageView!
    @IBOutlet weak var laughingFaceControlImageView: UIImageView!
    @IBOutlet weak var sadFaceControlImageView: UIImageView!
    @IBOutlet weak var toungeFaceControlImageView: UIImageView!
    @IBOutlet weak var deadFaceControlImageView: UIImageView!

    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint?
    var trayCenterWhenClosed: CGPoint?

    var newlyCreatedFaceCenter: CGPoint!
    var newlyCreatedFace : UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenClosed = trayView.center
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y:trayView.center.y + 172)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)

        let point = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)

        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")

            trayOriginalCenter = trayView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            
            UIView.animateWithDuration(0.5,
                delay: 0.0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.2,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations:{
            
                
                    if(velocity.y > 0){
                        self.trayView.center = self.trayCenterWhenOpen!
                    }else{
                        self.trayView.center = self.trayCenterWhenClosed!
                    }
                },
                completion: nil)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
        }
        
    }
    
    
    
    @IBAction func onFaceImagePanGesture(sender: UIPanGestureRecognizer) {

        

        // Gesture recognizers know the view they are attached to
        if let faceImage = sender.view as? UIImageView {
            let point = sender.locationInView(view)
            let translation = sender.translationInView(view)
            let velocity = sender.velocityInView(view)
            
            
            if sender.state == UIGestureRecognizerState.Began {
                print("Gesture began at: \(point)")
                
                
                // Create a new image view that has the same image as the one currently panning
                newlyCreatedFace = UIImageView(image: faceImage.image)
                newlyCreatedFaceCenter = faceImage.center
                
                // Add the new face to the tray's parent view.
                view.addSubview(newlyCreatedFace)
                
                // Initialize the position of the new face.
                newlyCreatedFace.center = faceImage.center
                
                // Since the original face is in the tray, but the new face is in the
                // main view, you have to offset the coordinates
                newlyCreatedFace.center.y += faceImage.frame.origin.y + self.view.center.y
                
                // Programmatically
                newlyCreatedFace.userInteractionEnabled = true
                let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onNewFacePan")
                newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
                
                //print(trayView.center.y)
                
            } else if sender.state == UIGestureRecognizerState.Changed {
                print("Gesture changed at: \(point)")
                newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceCenter.x + translation.x, y: newlyCreatedFaceCenter.y + translation.y + view.center.y + faceImage.frame.origin.y)
                
            } else if sender.state == UIGestureRecognizerState.Ended {
                print("Gesture ended at: \(point)")
            }
            
        }
        


    }
    


    func onNewFacePan() {
        print("I'm a face pan")
        newlyCreatedFace.transform = CGAffineTransformMakeScale(2, 2)
        
//        
//        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
//            panGestureRecognizer.view!.transform = CGAffineTransformMakeScale(2, 2)
//        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
//
//        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
//
//        }
    }


}

