
import UIKit

protocol Rotatable {

    func rotateAnimationFrom(_ fromItem: UIView, toItem: UIView, duration: Double)
}

extension Rotatable {

    func rotateAnimationFrom(_ fromItem: UIView, toItem: UIView, duration: Double) {

        let fromRotate = animationFrom(0, to: Double.pi, key: "transform.rotation", duration: duration)
        let fromOpacity = animationFrom(1, to: 0, key: "opacity", duration: duration)

        let toRotate = animationFrom(-Double.pi, to: 0, key: "transform.rotation", duration: duration)
        let toOpacity = animationFrom(0, to: 1, key: "opacity", duration: duration)

        fromItem.layer.add(fromRotate, forKey: nil)
        fromItem.layer.add(fromOpacity, forKey: nil)

        toItem.layer.add(toRotate, forKey: nil)
        toItem.layer.add(toOpacity, forKey: nil)
    }

    fileprivate func animationFrom(_ from: Double, to: Double, key: String, duration: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key)
        animation.duration = duration
        animation.fromValue = from
        animation.toValue = to
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}
