//
//  ViewController.swift
//  Picture
//
//  Created by 朱莹浩 on 5/6/16.
//  Copyright © 2016 朱莹浩. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var galleryScrollView: UIScrollView!
    @IBOutlet weak var galleryPageControl: UIPageControl!
    override func viewDidLoad() {
        let imageW:CGFloat = self.galleryScrollView.frame.size.width
        let imageH:CGFloat = self.galleryScrollView.frame.size.height
        var imageY:CGFloat = 0
        var totalCount: NSInteger = 4
        for index in 0 ..< totalCount {
            print(index)
            var imageView:UIImageView = UIImageView()
            let imageX: CGFloat = CGFloat(index) * imageW
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH)
            
            let name: String = String(format: "gallery%d", index + 1)
            imageView.image = UIImage(named: name)
            self.galleryScrollView.showsHorizontalScrollIndicator = false
            
            self.galleryScrollView.addSubview(imageView)
        }
        
        let contentW:CGFloat = imageW * CGFloat(totalCount)
        self.galleryScrollView.contentSize = CGSizeMake(contentW, 0)
        self.galleryScrollView.pagingEnabled = true
        self.galleryScrollView.delegate = self
        
        self.galleryPageControl.numberOfPages = totalCount
        self.addTimer()
    }
    func nextImage(sender:AnyObject!){//图片轮播；
        var page:Int = self.galleryPageControl.currentPage;
        print(page)
        if(page == 4){   //循环；
            page = 0;
        }else{
            page++;
        }
        let x:CGFloat = CGFloat(page) * self.galleryScrollView.frame.size.width;
        self.galleryScrollView.contentOffset = CGPointMake(x, 0);//注意：contentOffset就是设置ScrollView的偏移；
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //这里的代码是在ScrollView滚动后执行的操作，并不是执行ScrollView的代码；
        //这里只是为了设置下面的页码提示器；该操作是在图片滚动之后操作的；
        let scrollviewW:CGFloat = galleryScrollView.frame.size.width;
        let x:CGFloat = galleryScrollView.contentOffset.x;
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW);
        self.galleryPageControl.currentPage = page;
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeTimer();
    }
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer();
    }

    var timer:NSTimer!
        func addTimer(){   //图片轮播的定时器；
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "nextImage:", userInfo: nil, repeats: true);
    }
    func removeTimer(){
        self.timer.invalidate();
    }
}

