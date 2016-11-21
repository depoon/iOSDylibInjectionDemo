//
//  PatchManager.swift
//  PokemonGoHacking
//
//  Created by Kenneth Poon on 31/8/16.
//
//

import Foundation

open class PatchManager: NSObject {
    
    var hijackingSubviews = [UIView]()
    
    override init(){
        super.init()
        self.setupViewsForLoading()
        
    }
    
    fileprivate func setupViewsForLoading(){
        guard let delegate = UIApplication.shared.delegate else{
            return
        }
        guard let window = delegate.window else {
            return 
        }
        let label = UILabel(frame: CGRect(x: 0,y: 80, width: window!.frame.size.width, height: 50))
        label.text = "<---- iOS Dev Scout Rocks ---->"
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.5)
        label.tag = 29999
        
        self.hijackingSubviews.append(label)
        
        let buttonImage = self.imageFromColor(size: CGSize(width: 40,height: 40), color: UIColor(red: 1, green: 1, blue: 0, alpha: 0.5))
        
        let nButton = UIButton(frame: CGRect(x: 40,y: 150, width: 40, height: 40))
        nButton.setTitle("N", for: .normal)
        nButton.setTitleColor(UIColor.black, for: .normal)
        nButton.titleLabel!.textAlignment = .center
        nButton.setImage(buttonImage, for: .normal)
        nButton.addTarget(self, action: #selector(self.moveN), for: .touchUpInside)
        nButton.tag = 29998
        
        
        let wButton = UIButton(frame: CGRect(x: 0, y:190, width: 40, height: 40))
        wButton.setTitle("W", for: .normal)
        wButton.setTitleColor(UIColor.black, for: .normal)
        wButton.titleLabel!.textAlignment = .center
        wButton.setImage(buttonImage, for: .normal)
        wButton.addTarget(self, action: #selector(self.moveW), for: .touchUpInside)
        wButton.tag = 29997
        
        let sButton = UIButton(frame: CGRect(x: 40, y: 230, width: 40, height: 40))
        sButton.setTitle("S", for: .normal)
        sButton.setTitleColor(UIColor.black, for: .normal)
        sButton.titleLabel!.textAlignment = .center
        sButton.setImage(buttonImage, for: .normal)
        sButton.addTarget(self, action: #selector(self.moveS), for: .touchUpInside)
        sButton.tag = 29996
        
        let eButton = UIButton(frame: CGRect(x: 80, y: 190, width: 40, height: 40))
        eButton.setTitle("E", for: .normal)
        eButton.setTitleColor(UIColor.black, for: .normal)
        eButton.titleLabel!.textAlignment = .center
        eButton.setImage(buttonImage, for: .normal)
        eButton.addTarget(self, action: #selector(self.moveE), for: .touchUpInside)
        eButton.tag = 29995
        
        self.hijackingSubviews.append(nButton)
        self.hijackingSubviews.append(wButton)
        self.hijackingSubviews.append(sButton)
        self.hijackingSubviews.append(eButton)

    }
    
    @objc open func hijackAppWindow(){
        for _:Int in 0...20 {

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.displayDisplayLabel()
            }
        }
    }
    
    fileprivate func displayDisplayLabel(){
        guard let delegate = UIApplication.shared.delegate else{
            return
        }
        guard let window = delegate.window else {
            return 
        }
        for hijackingView in hijackingSubviews {
            if let existingHijackView = window?.viewWithTag(hijackingView.tag) {
                existingHijackView.removeFromSuperview()
            }
            window?.addSubview(hijackingView)
        }
        
    }
    
    private func imageFromColor(size: CGSize, color: UIColor) -> UIImage{
        UIGraphicsBeginImageContext(CGSize(width: size.width, height: size.height))
        
        UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 3).addClip()
        
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage!;
    }


}

extension PatchManager{
    
    func moveN(){
        var currentCoordinate = LocationSwizzler.currentLocation
        currentCoordinate.latitude = currentCoordinate.latitude+0.0001 
        LocationSwizzler.currentLocation = currentCoordinate
        LocationSwizzler.retriggerTrackUserLocation()
    }
    
    func moveW(){
        var currentCoordinate = LocationSwizzler.currentLocation
        currentCoordinate.longitude = currentCoordinate.longitude-0.0001 
        LocationSwizzler.currentLocation = currentCoordinate
        LocationSwizzler.retriggerTrackUserLocation()
    }
    
    func moveS(){
        var currentCoordinate = LocationSwizzler.currentLocation
        currentCoordinate.latitude = currentCoordinate.latitude-0.0001 
        LocationSwizzler.currentLocation = currentCoordinate   
        LocationSwizzler.retriggerTrackUserLocation()
    }
    
    func moveE(){
        var currentCoordinate = LocationSwizzler.currentLocation
        currentCoordinate.longitude = currentCoordinate.longitude+0.0001 
        LocationSwizzler.currentLocation = currentCoordinate
        LocationSwizzler.retriggerTrackUserLocation()
    }
}

