//
//  ViewController.swift
//  SlideViews
//
//  Created by Omonayajo Oladapo Adeola on 05/06/2016.
//  Copyright © 2016 Prometheus Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startLocation:CGPoint = CGPoint()
    let slidableView:UIView = UIView()
    var startingPosition:CGFloat = 0.0
    
    var viewHeight:CGFloat = 0.0
    var viewWidth:CGFloat = 0.0
    var menuWidth:CGFloat = 0.0
    var menuHeight:CGFloat = 0.0
    
    var menuOpened:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHeight = self.view.frame.height
        viewWidth = self.view.frame.width
        
        menuWidth = viewWidth * 0.75  // Menu is 75% of the Screen Width
        menuHeight = viewHeight
        
        slidableView.frame = CGRect(x: 0.0, y: 0.0, width: menuWidth, height: menuHeight)
        slidableView.backgroundColor = UIColor.greenColor()
        
        
        self.view.addSubview(slidableView)
        
        let panRight = UIPanGestureRecognizer(target: self, action: "respondToPanGesture:")
        self.view.addGestureRecognizer(panRight)
    }
    
    override func viewDidAppear(animated: Bool) {
        closeMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func respondToPanGesture(gesture: UIPanGestureRecognizer) {
        
        let stopLocation = gesture.locationInView(self.view)
        let dx = stopLocation.x - startLocation.x
        
        let goingRight = dx > 0
        
        if (gesture.state == UIGestureRecognizerState.Began) {
            startLocation = gesture.locationInView(self.view)
        } else if (gesture.state == UIGestureRecognizerState.Changed) {
            
            if (goingRight && dx > 50 && !menuOpened) {
                openMenu()
            } else if (!goingRight && dx < -50 && menuOpened) {
                // Close the Menu
                closeMenu()
            }
        }
        
    }
    
    // Open Side Menu
    func openMenu() {
        UIView.animateWithDuration(1.0,
            animations: {
                self.slidableView.frame = CGRect(x: 0, y: 0, width: self.menuWidth, height: self.viewHeight)
            },
            completion: { _ in
                self.menuOpened = true
        })
    }
    
    // Close side menu
    func closeMenu() {
        UIView.animateWithDuration(1.0,
            animations: {
                self.slidableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.viewHeight)
            },
            completion: { _ in
                self.menuOpened = false
        })
    }

}

