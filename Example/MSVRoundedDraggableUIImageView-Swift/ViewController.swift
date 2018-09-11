//  MSVViewController
//  MSVRoundedDraggableUIImageView
//
//  Created by sergemoskalenko on 08/16/2017.
//  Copyright (c) 2017 sergemoskalenko. All rights reserved.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//

import UIKit
import MSVRoundedDraggableUIImageView_Swift

class MSVViewController: UIViewController, MSVDraggableImageViewProtocol {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var switchView: UISwitch!
    var imageView: MSVDraggableImageView?
    @IBOutlet var imageViewOnTop: MSVRoundedDraggableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = MSVDraggableImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        imageView?.image = UIImage(named: "earth")
        imageView?.center = view.center
        imageView?.isUserInteractionEnabled = true
        imageView?.pinStartPoint()
        view.addSubview(imageView!)
        
        imageViewOnTop.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "http://camopu.rhorse.ru/MSVRoundedDraggableUIImageView")!)
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        imageView?.isMovedToStartPoint = sender.isOn
        if (imageView?.isMovedToStartPoint)! {
            imageView?.moveToStartPoint()
        }
        imageViewOnTop.isMovedToStartPoint = sender.isOn
        if imageViewOnTop.isMovedToStartPoint {
            imageViewOnTop.moveToStartPoint()
        }
    }

    func scrollDownTextView() {
        if (textView?.text.count)! > 0 {
            let bottom = NSRange(location: (textView?.text.count)! - 1, length: 1)
            textView?.scrollRangeToVisible(bottom)
        }
    }
    
    
    // MARK:  -- Delegate methods

    open func draggableImageView(_ sender: MSVDraggableImageView, didMovedTo point: CGPoint) {
        scrollDownTextView()
        print("didMovedTo: (\(Int(point.x)), \(Int(point.y)))")
        textView.textStorage.append(NSAttributedString(string: "didMovedTo: (\(Int(point.x)), \(Int(point.y)))\n"))
        scrollDownTextView()
    }
    
    open func draggableImageView(_ sender: MSVDraggableImageView, didMovedValue value: CGPoint) {
        scrollDownTextView()
        print("didMovedValue: (\(String(format: "%.2f",value.x)), \(String(format: "%.2f",value.y)))")
        textView.textStorage.append(NSAttributedString(string: "didMovedValue: (\(String(format: "%.2f",value.x)), \(String(format: "%.2f",value.y)))\n"))
        scrollDownTextView()
    }
    
    open func draggableImageView(_ sender: MSVDraggableImageView, willMovedToStart point: CGPoint) {
        scrollDownTextView()
         print("willMovedToStart: (\(Int(point.x)), \(Int(point.y)))")
        textView.textStorage.append(NSAttributedString(string: "willMovedToStart: (\(Int(point.x)), \(Int(point.y)))\n"))
        scrollDownTextView()
    }
    
    open func draggableImageView(_ sender: MSVDraggableImageView, didMovedToStart point: CGPoint) {
        scrollDownTextView()
         print("didMovedToStart: (\(Int(point.x)), \(Int(point.y)))")
        textView.textStorage.append(NSAttributedString(string: "didMovedToStart: (\(Int(point.x)), \(Int(point.y)))\n"))
        scrollDownTextView()
    }
    
}
