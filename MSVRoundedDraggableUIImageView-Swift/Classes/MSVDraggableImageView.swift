//  MSVDraggableImageView
//  Pods
//
//  Created by Serge Moskalenko on 16.08.17.
//  Copyright (c) 2017 sergemoskalenko. All rights reserved.
//  skype:camopu-ympo, https://github.com/sergemoskalenko
//

import UIKit

@objc public protocol MSVDraggableImageViewProtocol: NSObjectProtocol {
    @objc optional func draggableImageView(_ sender: MSVDraggableImageView, didMovedTo point: CGPoint)
    
    @objc optional func draggableImageView(_ sender: MSVDraggableImageView, didMovedValue value: CGPoint)
    
    @objc optional func draggableImageView(_ sender: MSVDraggableImageView, willMovedToStart point: CGPoint)
    
    @objc optional func draggableImageView(_ sender: MSVDraggableImageView, didMovedToStart point: CGPoint)
}

open class MSVDraggableImageView : UIImageView {
    open weak var delegate: MSVDraggableImageViewProtocol? = nil
    open var maxShiftX: CGFloat = 0.0
    open var maxShiftY: CGFloat = 0.0
    open var isMovedToStartPoint: Bool = false
    
    var isToched: Bool = false
    var startPoint = CGPoint.zero
    var oldFrame = CGRect.zero
    var pinFrame = CGRect.zero
    var maxShiftX2: CGFloat {
        var shift: CGFloat = maxShiftY
        if abs(shift) < 0.0001 {
            shift = UIScreen.main.applicationFrame.size.width / 2
        }
        return shift
    }
    var maxShiftY2: CGFloat {
        var shift: CGFloat = maxShiftX
        if abs(shift) < 0.0001 {
            shift = UIScreen.main.applicationFrame.size.height / 2
        }
        return shift
    }
    weak var superView: UIView?

    public required init() {
        super.init(frame: CGRect.zero)
        self.setUp()
    }

    public override init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func setUp() {
        isToched = false
        maxShiftX = 0
        maxShiftY = 0
        isMovedToStartPoint = true
        pinFrame = CGRect.zero
    }

    func update() {
        if (self.delegate != nil) {
            if (self.delegate?.responds(to: #selector(MSVDraggableImageViewProtocol.draggableImageView(_:didMovedValue:))))! {
                let x: CGFloat = frame.origin.x
                let y: CGFloat = frame.origin.y
                let xPin: CGFloat = pinFrame.origin.x
                let yPin: CGFloat = pinFrame.origin.y
                let value = CGPoint(x: 0.5 * (maxShiftX2 + x - xPin) / maxShiftX2, y: 0.5 * (maxShiftY2 + y - yPin) / maxShiftY2)
                delegate?.draggableImageView!(self, didMovedValue: value)
            }
            if (self.delegate?.responds(to: #selector(MSVDraggableImageViewProtocol.draggableImageView(_:didMovedTo:))))! {
                self.delegate?.draggableImageView!(self, didMovedTo: frame.origin)
            }
        }
    }

    func didMoveToStart() {
        if (self.delegate != nil) {
            if (self.delegate?.responds(to: #selector(MSVDraggableImageViewProtocol.draggableImageView(_:didMovedToStart:))))! {
                self.delegate?.draggableImageView!(self, didMovedToStart: frame.origin)
            }
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        startPoint = (touch?.location(in: superview))!
        if pinFrame.size.width < 0.001 && pinFrame.size.height < 0.001 {
            pinStartPoint()
        }
        isToched = true
        oldFrame = frame
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isToched {
            let touch: UITouch? = touches.first
            let currPoint: CGPoint? = touch?.location(in: superview)
            let newX: CGFloat? = oldFrame.origin.x + ((currPoint?.x)! - startPoint.x)
            let newY: CGFloat? = oldFrame.origin.y + ((currPoint?.y)! - startPoint.y)
            if abs(pinFrame.origin.x - newX!) < maxShiftX2 && abs(pinFrame.origin.y - newY!) < maxShiftY2 {
                frame = CGRect(x: newX!, y: newY!, width: oldFrame.size.width, height: oldFrame.size.height)
                update()
            }
        }
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        frame = oldFrame
        update()
        isToched = false
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isToched = false
        moveToStartPoint()
    }

    // MARK: -
    open func pinStartPoint() {
        pinFrame = frame
    }

    open func moveToStartPoint() {
        if !isMovedToStartPoint || (pinFrame.size.width < 0.001 && pinFrame.size.height < 0.001) {
            return
        }
        isUserInteractionEnabled = false
        if (self.delegate != nil) {
            if (self.delegate?.responds(to: #selector(MSVDraggableImageViewProtocol.draggableImageView(_:willMovedToStart:))))! {
                self.delegate?.draggableImageView!(self, willMovedToStart: self.pinFrame.origin)
            }
        }
        UIView.animate(withDuration: 0.25, animations: {() -> Void in
            self.frame = self.pinFrame
        }, completion: {(_ finished: Bool) -> Void in
            self.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                self.didMoveToStart()
            }
        })
        
        
    }
        
}
