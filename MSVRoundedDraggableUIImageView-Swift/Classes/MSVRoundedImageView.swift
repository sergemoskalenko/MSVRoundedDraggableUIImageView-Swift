//  MSVRoundedImageView
//  Pods
//
//  Created by Serge Moskalenko on 16.08.17.
//  Copyright (c) 2017 sergemoskalenko. All rights reserved.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//

import UIKit

@IBDesignable
class MSVRoundedImageView: UIImageView {
    @IBInspectable var borderColor: UIColor?
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupValues()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupValues()
    }
    
    func setupValues() {
        updateLayerProperties()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        clipsToBounds = true
        layer.cornerRadius = min(frame.size.width, frame.size.height) / 2
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
    }
}
