//
//  TopCellView.swift
//  iosexist
//


import UIKit

class TopCellView: UIView{

    let offsetMax:CGFloat = 180
    let offsetMin:CGFloat = 40

    override init(frame: CGRect) {
        super.init(frame: frame)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panleft))
        pan.delegate = self
        pan.maximumNumberOfTouches = 1
        addGestureRecognizer(pan)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func panleft(pan: UIPanGestureRecognizer) {
        
        let initX:CGFloat = superview!.center.x
        let vdirect = pan.velocity(in: nil)
        let point = pan.translation(in: self.superview)
        let currentCenter = self.center
        let updateX = currentCenter.x + point.x
        
//        print("velocity: ", vdirect)
//        print("point: ", point)

//        if initX - updateX > 120 || initX < updateX {
//            
//            return
//        }
        
       // let startPoint = CGPoint(x: point.x, y: point.y)
        
        switch pan.state{
        case .began:
            print("initX: ",initX," - updateX: ",updateX, "=", initX - updateX)
            print("pointX: ", fabs(point.x), " pointY: ", fabs(point.y))
            
        case .changed:
            if fabs(vdirect.y) < fabs(vdirect.x) && !(initX - updateX > offsetMax || initX <= updateX){
                center = CGPoint(x: updateX, y: currentCenter.y )
                pan.setTranslation(CGPoint.zero, in: nil)
            }
            
        case .ended:
            if fabs(vdirect.y) < fabs(vdirect.x){
                backposition( vdirect, initX, y: currentCenter.y, updateX)
                pan.setTranslation(CGPoint.zero, in: nil)

            }
        default:
            break
        }
        
    }
    private func backposition (_ vdirect: CGPoint,_ initX: CGFloat, y: CGFloat,_ updateX: CGFloat) {
        if vdirect.x <= 0 {
            
            if initX - updateX < offsetMin {
                animateTopView( CGPoint(x: initX, y: y ))
            }else{
                animateTopView(CGPoint(x: initX - offsetMax, y: y ))
            }
        }else{
            if initX - updateX > offsetMax - offsetMin {
                animateTopView(CGPoint(x: initX - offsetMax, y: y ))
            }else{
                animateTopView( CGPoint(x: initX, y: y ))
            }
        }
    }
    private func animateTopView(_ point: CGPoint) {
        print("finally: ", point.x)
        UIView.animate(withDuration: 0.15, animations: {
            self.center = point
        }, completion: nil)
    }

   
}

extension TopCellView: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer{
            let point = pan.translation(in: nil)
            if fabs(point.y) < fabs(point.x){
                return false
            }
            
        }
        return true
    }
}
