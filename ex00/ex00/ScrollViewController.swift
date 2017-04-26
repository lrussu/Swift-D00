//
//  ScrollViewController.swift
//  ex00
//
//  Created by Liudmila Russu on 4/25/17.
//  Copyright © 2017 Liudmila Russu. All rights reserved.
//



import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var passedImage: UIImageView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    


    
    var image:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if image != nil
        {
            self.passedImage.image = self.image
            
        }
        self.mainScrollView.minimumZoomScale = 1.0
        self.mainScrollView.minimumZoomScale = 6.0
        //self.automaticallyAdjustsScrollViewInsets = false
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.passedImage
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
