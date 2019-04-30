//
//  pageContentview.swift
//  XR-DYZB
//
//  Created by xueranit on 2019/4/30.
//  Copyright © 2019 xr. All rights reserved.
//

import UIKit
private let pagecontentCellID = "pagecontentCellID"

class pageContentview: UIView {
    
    private var viewControllers : [UIViewController]
    private weak var parentViewController : UIViewController?
    
    private lazy var collectionView : UICollectionView = { [weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout:layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: pagecontentCellID)
        
        return collectionView


    }()
    

     init(frame: CGRect,viewControllers:[UIViewController],parentViewController:UIViewController?) {
        
        self.viewControllers = viewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        self .setUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension pageContentview {
    
    private func setUI() {
        
//        将所有的控制器添加到福控制器中
        for childVC in viewControllers {
            
            parentViewController?.addChild(childVC)
            
        }
        
//        添加一个collectionView
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension pageContentview : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pagecontentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let Viewcontroller = viewControllers[indexPath.row]
        Viewcontroller.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(Viewcontroller.view)
        
        return cell
        
    }
    
    
}
