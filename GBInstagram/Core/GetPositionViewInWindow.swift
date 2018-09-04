// Для добавления метода получения позиции фрейма
// относительно Window

import CoreGraphics
import UIKit

extension UIView {
    
    
    // рекурсивно складываются х координаты с супервью
    private func getPositionX(view: UIView) -> CGFloat {
        
        guard let superV = view.superview else { return 0 }
        
        return view.frame.origin.x + getPositionX(view: superV)
    }
    
    
    // рекурсивно складываются y координаты с супервью
    private func getPositionY(view: UIView) -> CGFloat {
        
        guard let superV = view.superview else { return 0 }
        
        return view.frame.origin.y + getPositionY(view: superV)
    }
    
    
    // доступная для View функция получения координат в Window
    func getPositionInWindow() -> CGPoint {
        
        //swiftlint:disable identifier_name
        let x = getPositionX(view: self)
        let y = getPositionY(view: self)
        
        return CGPoint(x: x, y: y)
    }
    
}
