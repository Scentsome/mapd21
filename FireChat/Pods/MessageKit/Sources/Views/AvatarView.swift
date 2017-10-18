/*
 MIT License

 Copyright (c) 2017 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation

open class AvatarView: UIView {

    // MARK: - Properties

    open var avatar: Avatar = Avatar()

    open var imageView = UIImageView()

    public var image: UIImage? {
        return imageView.image
    }

    open var placeholderFont: UIFont = UIFont.preferredFont(forTextStyle: .caption1) {
        didSet {
            set(avatar: avatar)
        }
    }

    open var placeholderTextColor: UIColor = .white {
        didSet {
            set(avatar: avatar)
        }
    }

    open var fontMinimumScaleFactor: CGFloat = 0.5

    open var adjustsFontSizeToFitWidth = true

    private var minimumFontSize: CGFloat {
        return placeholderFont.pointSize * fontMinimumScaleFactor
    }

    private var radius: CGFloat?

    // MARK: - Overridden Properties
    open override var frame: CGRect {
        didSet {
            imageView.frame = bounds
            setCorner(radius: self.radius)
        }
    }

    open override var bounds: CGRect {
        didSet {
            imageView.frame = bounds
            setCorner(radius: self.radius)
        }
    }

    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }

    convenience public init() {
        self.init(frame: .zero)
    }

    private func getImageFrom(initals: String) -> UIImage {
        let width = frame.width
        let height = frame.height
        if width == 0 || height == 0 {return UIImage()}
        var font = placeholderFont

        _ = UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        let context = UIGraphicsGetCurrentContext()!

        //// Text Drawing
        let textRect = calculateTextRect(outerViewWidth: width, outerViewHeight: height)
        if adjustsFontSizeToFitWidth,
            initals.width(considering: textRect.height, and: font) > textRect.width {
            let newFontSize = calculateFontSize(text: initals, font: font, width: textRect.width, height: textRect.height)
            font = placeholderFont.withSize(newFontSize)
        }

        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
      let textFontAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: placeholderTextColor, NSAttributedStringKey.paragraphStyle: textStyle]

        let textTextHeight: CGFloat = initals.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        initals.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
        guard let renderedImage = UIGraphicsGetImageFromCurrentImageContext() else { assertionFailure("Could not create image from context"); return UIImage()}
        return renderedImage
    }

    /**
     Recursively find the biggest size to fit the text with a given width and height
     */
    private func calculateFontSize(text: String, font: UIFont, width: CGFloat, height: CGFloat) -> CGFloat {
        if text.width(considering: height, and: font) > width {
            let newFont = font.withSize(font.pointSize - 1)
            if newFont.pointSize > minimumFontSize {
                return font.pointSize
            } else {
                return calculateFontSize(text: text, font: newFont, width: width, height: height)
            }
        }
        return font.pointSize
    }

    /**
     Calculates the inner circle's width.
     Note: Assumes corner radius cannot be more than width/2 (this creates circle).
     */
    private func calculateTextRect(outerViewWidth: CGFloat, outerViewHeight: CGFloat) -> CGRect {
        guard outerViewWidth > 0 else {
            return CGRect.zero
        }
        let shortEdge = min(outerViewHeight, outerViewWidth)
        // Converts degree to radian degree and calculate the
        // Assumes, it is a perfect circle based on the shorter part of ellipsoid
        // calculate a rectangle
        let w = shortEdge * sin(CGFloat(45).degreesToRadians) * 2
        let h = shortEdge * cos(CGFloat(45).degreesToRadians) * 2
        let startX = (outerViewWidth - w)/2
        let startY = (outerViewHeight - h)/2
        // In case the font exactly fits to the region, put 2 pixel both left and right
        return CGRect(x: startX+2, y: startY, width: w-4, height: h)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    internal func prepareView() {
        backgroundColor = .gray
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.frame = frame
        addSubview(imageView)
        imageView.image = avatar.image ?? getImageFrom(initals: avatar.initals)
        setCorner(radius: nil)
    }

    // MARK: - Open setters

    open func set(avatar: Avatar) {
        imageView.image = avatar.image ?? getImageFrom(initals: avatar.initals)
    }

    open func setCorner(radius: CGFloat?) {
        guard let radius = radius else {
            //if corner radius not set default to Circle
            let cornerRadius = min(frame.width, frame.height)
            layer.cornerRadius = cornerRadius/2
            return
        }
        self.radius = radius
        layer.cornerRadius = radius
    }

}

fileprivate extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
