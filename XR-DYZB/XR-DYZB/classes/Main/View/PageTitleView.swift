//
//  PageTitleView.swift
//  XR-DYZB
//
//  Created by xueranit on 2019/4/30.
//  Copyright © 2019 xr. All rights reserved.
//

import UIKit

private let kscrollerLineH :CGFloat = 2

class PageTitleView: UIView {

    private var titles :[String]
//    懒加载
    
    private lazy var titleLbs : [UILabel] = [UILabel]()
    
    private var currentLbIndex : Int = 0
    
    private lazy var scroller : UIScrollView = {
        let scroller = UIScrollView()
        scroller.showsHorizontalScrollIndicator = false
        scroller.scrollsToTop = false
        scroller.isPagingEnabled = false
//        scroller.bounds = false
        
        return scroller
    }()
    
    private lazy var scrollerline : UIView = {
        
        let scrollerLine = UIView ()
        scrollerLine.backgroundColor = UIColor.orange
        
        return scrollerLine
        }()
    
   //自定义函数
     init(frame: CGRect,titles:[String]) {
        self.titles = titles;
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}

//设置UI界面
extension PageTitleView {
    private func setupUI() {
        
//        添加UIscroller
        addSubview(scroller)
        scroller.frame = bounds;
        
//        添加title对应的lb
        setTitleLb()
        setupBottomMenuAndScrollLine()
        
    }
    
    
    private func setTitleLb() {
        
        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - CGFloat(kscrollerLineH)
         let lableY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            
//            创建UILable
            let lable = UILabel()
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 15.0)
            lable.textColor = UIColor .darkGray
            lable.textAlignment = .center
            
//            shezhi设置位置
         
            let lableX : CGFloat = lableW * CGFloat(index)
           
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH);
            scroller.addSubview(lable)
            titleLbs.append(lable)
            
//            添加手势
            lable.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action:#selector(self.titleLbClick(tapGest:)))
            lable.addGestureRecognizer(tap)
        }
        
        
        
    }
    
    private func setupBottomMenuAndScrollLine(){
//        添加底线
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.lightGray
        let lineH :CGFloat = 0.5
        bottomView.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottomView)
        
//        添加scrollerLine
        scroller.addSubview(scrollerline)
//        先拿到第一个lable
//        guard  titleLbs.first != nil else{return}
        guard let firstLb = titleLbs.first else {
            return
        }
        firstLb.textColor = UIColor.orange
        
        scrollerline.frame = CGRect(x: firstLb.frame.origin.x, y: frame.height-kscrollerLineH, width: firstLb.frame.width, height: kscrollerLineH)
        
        
        
    }
    
}

//lable的点击s方法
extension PageTitleView {
    
    @objc private func titleLbClick(tapGest:UITapGestureRecognizer) {
        
        print("点击了事件")
        guard let currentLb = tapGest.view as? UILabel else {return}
        
        if currentLbIndex == currentLb.tag {
            return
        }
       
      
        let oldLb = titleLbs[currentLbIndex]
        oldLb.textColor = UIColor.darkGray
        currentLb.textColor = UIColor .orange
        
        currentLbIndex = currentLb.tag
        let scrollerLineX = CGFloat(currentLb.tag) * scrollerline.frame.width
        
        UIView.animate(withDuration: 0.15) {
            
            self.scrollerline.frame.origin.x = scrollerLineX
        }
        
        
    }
    
}
