//
//  CategoryListHeaderView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class CategoryListHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundImage)
        addSubview(coverView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: CategoryModel! {
        didSet {
            backgroundImage.image = model.listImage
            coverView.backgroundColor = model.coverColor
            titleLabel.text = model.title
            subTitleLabel.text = model.subTitle
        }
    }
    
    var labelAlpha: CGFloat = 1{
        didSet {
            self.titleLabel.alpha = labelAlpha
            self.subTitleLabel.alpha = labelAlpha
        }
    }
    
        /// 背景图
    fileprivate lazy var backgroundImage: UIImageView = {
        var backgroundImage = UIImageView()
        backgroundImage.origin = CGPoint.zero
        backgroundImage.size = self.size
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
        /// 标题
    fileprivate lazy var titleLabel: UILabel = {
        var titleLable = UILabel()
        titleLable.origin = CGPoint(x: UIConstant.UI_MARGIN_20, y: self.center.y)
        titleLable.size = CGSize(width: self.width-2*UIConstant.UI_MARGIN_20, height: 20)
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.customFont_FZLTZCHJW(fontSize: 20)
        return titleLable
    }()
        // alpa
    fileprivate lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.origin = CGPoint.zero
        coverView.size = self.size
        return coverView
    }()
        /// 子标题
    fileprivate lazy var subTitleLabel: UILabel = {
        var subTitleLabel = UILabel()
        subTitleLabel.origin = CGPoint(x: self.titleLabel.x, y: self.titleLabel.frame.maxY+UIConstant.UI_MARGIN_10)
        subTitleLabel.size = self.titleLabel.size
        subTitleLabel.textColor = UIColor.white
        subTitleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return subTitleLabel
    }()
}
