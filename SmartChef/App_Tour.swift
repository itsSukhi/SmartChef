//
//  App_Tour.swift
//  SmartChef
//
//  Created by osx on 06/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

//**Initialising Variables ****

var timer: Timer!
var image_Array = NSMutableArray()

class App_Tour: UIViewController,UIScrollViewDelegate {

      // *** Outlets *****
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)

    }
    
    @IBOutlet weak var Scroll_View: UIScrollView!
    @IBOutlet weak var Pagecontrol: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image_Array = ["1","2","3"]
        

        //*****ScollView Functionality *****
        
        self.Scroll_View.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        
        let scrollViewWidth:CGFloat = self.Scroll_View.frame.width
        
        let scrollViewHeight:CGFloat = self.Scroll_View.frame.height
        
        
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight-30))
        imgOne.image = UIImage(named: "smart-chef-1")//image1
        imgOne.contentMode = .scaleAspectFit
        imgOne.layer.masksToBounds = true
        // ****** 2 *********
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight-30))
        imgTwo.image = UIImage(named: "start_page_01")//image2
        imgTwo.contentMode = .scaleAspectFit
        imgTwo.layer.masksToBounds = true
        
        // ******* 3 *********
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight-30))
        imgThree.image = UIImage(named: "start_page_02")//image3
        imgThree.contentMode = .scaleAspectFit
        imgThree.layer.masksToBounds = true
        
        // ******* 4 ************
        
        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:scrollViewHeight-30))
        imgFour.image = UIImage(named: "smart-chef-2")//image4..///apptour1
        imgFour.contentMode = .scaleAspectFit
        imgFour.layer.masksToBounds = true
        
        // ******* 5 ************
        
        let imgFive = UIImageView(frame: CGRect(x:scrollViewWidth*4, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgFive.image = UIImage(named: "smart-chef-3")//image5..//apptour2
        imgFive.contentMode = .scaleAspectFit
        imgFive.layer.masksToBounds = true
        
        // ******* 6 **************
        
        let imgSix = UIImageView(frame: CGRect(x:scrollViewWidth*5, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgSix.image = UIImage(named: "smart-chef-4")//image6
        imgSix.contentMode = .scaleAspectFit
        imgSix.layer.masksToBounds = true
        
        
        // ***** 7 ***************
        
        let imgSeven = UIImageView(frame: CGRect(x:scrollViewWidth*6, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgSeven.image = UIImage(named: "smart-chef-5")//image7
        imgSeven.contentMode = .scaleAspectFit
        imgSeven.layer.masksToBounds = true
        
       // ***** 8 *****************
        
        let imgEight = UIImageView(frame: CGRect(x:scrollViewWidth*7, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgEight.image = UIImage(named: "smart-chef-6")//image7
        imgEight.contentMode = .scaleAspectFit
        imgEight.layer.masksToBounds = true
        
        // ****** 9 ****************
        
        let imgNine = UIImageView(frame: CGRect(x:scrollViewWidth*8, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgNine.image = UIImage(named: "smart-chef-7")//image9
        imgNine.contentMode = .scaleAspectFit
        imgNine.layer.masksToBounds = true
        
        // ***** 10 ****************
        
        let imgTen = UIImageView(frame: CGRect(x:scrollViewWidth*9, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgTen.image = UIImage(named: "smart-chef-8")//image10
        imgTen.contentMode = .scaleAspectFit
        imgTen.layer.masksToBounds = true
        
        // ****** 11 ***************
        
        let imgEleven = UIImageView(frame: CGRect(x:scrollViewWidth*10, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgEleven.image = UIImage(named: "smart-chef-9")//image11
        imgEleven.contentMode = .scaleAspectFit
        imgEleven.layer.masksToBounds = true
        
        
        
        // ******** 12 **************
        
        let imgTwelwe = UIImageView(frame: CGRect(x:scrollViewWidth*11, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgTwelwe.image = UIImage(named: "smart-chef-10")//image12
        imgTwelwe.contentMode = .scaleAspectFit
        imgTwelwe.layer.masksToBounds = true
        
        
        // ******** 13 ***************
        
        let imgThirteen = UIImageView(frame: CGRect(x:scrollViewWidth*11, y:0,width:scrollViewWidth, height:scrollViewHeight-20))
        imgThirteen.image = UIImage(named: "smart-chef-11")//image13
        imgThirteen.contentMode = .scaleAspectFit
        imgThirteen.layer.masksToBounds = true
        
        // ******* 14 *****************
        
        let imgFourteen = UIImageView(frame: CGRect(x:scrollViewWidth*12, y:0,width:scrollViewWidth, height:scrollViewHeight-30))
        imgFourteen.image = UIImage(named: "image14")
        imgFourteen.contentMode = .scaleAspectFit
        imgFourteen.layer.masksToBounds = true
      
        
                
        self.Scroll_View.addSubview(imgOne)
        self.Scroll_View.addSubview(imgTwo)
        self.Scroll_View.addSubview(imgThree)
        self.Scroll_View.addSubview(imgFour)
        self.Scroll_View.addSubview(imgFive)
        self.Scroll_View.addSubview(imgSix)
        self.Scroll_View.addSubview(imgSeven)
        self.Scroll_View.addSubview(imgEight)
        self.Scroll_View.addSubview(imgNine)
        self.Scroll_View.addSubview(imgTen)
        self.Scroll_View.addSubview(imgEleven)
//        self.Scroll_View.addSubview(imgTwelwe)
        self.Scroll_View.addSubview(imgThirteen)
//        self.Scroll_View.addSubview(imgFourteen)
        
        
        self.Scroll_View.contentSize = CGSize(width:self.Scroll_View.frame.width * 12, height:0)// width = 13
        self.Scroll_View.delegate = self
        self.Pagecontrol.currentPage = 0
        
     // ***** Calling Function *************
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        
        // Do ay additional setup after loading the view.
    }

    // ***** Automatic Scroll ********
    
    func automaticScroll() {
        let pageWidth:CGFloat = self.Scroll_View.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.Scroll_View.contentOffset.x
        
        let currentPage:CGFloat = floor((Scroll_View.contentOffset.x-pageWidth/2)/pageWidth)+1
        
        var slideToX = contentOffset + pageWidth
        
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        
        print("Current Page is:\(Int(currentPage))")
        
        if Int(currentPage) == 0{
                    Pagecontrol.currentPage = 1
            
        }else if Int(currentPage) == 1{
            
            Pagecontrol.currentPage = 2
            timer.invalidate()

        }
        else if Int(currentPage) == 2{
            Pagecontrol.currentPage = 0
        }
        
        else{
            Pagecontrol.currentPage = 0
            
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 2.0, animations: { () -> Void in
                //     self.startButton.alpha = 1.0
            })
        }
        
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.Scroll_View.contentOffset.x = CGFloat(slideToX)
                
                
            }, completion: nil)
        }
    }

        
    
    //*****Scroll View Function *********
    
    func scrollViewDidEndDecelerating(_ Scroll_View: UIScrollView){
        //  Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = Scroll_View.frame.width
        let currentPage:CGFloat = floor((Scroll_View.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.Pagecontrol.currentPage = Int(currentPage);
        
        if Int(currentPage) == 0{
            
        }else if Int(currentPage) == 1{
         
        }else{
           
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                //     self.startButton.alpha = 1.0
            })
        }
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
