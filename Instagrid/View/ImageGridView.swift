import UIKit

class ImageGridView: UIView {
    @IBOutlet private var pictureViews: [UIView]!

    public var imageTarget: Int = 1

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.8
    }

    public func setLayout(_ nbLayout: Int) {
        resetGrid()

        switch nbLayout {
        case 1:
            pictureViews.first!.isHidden = true
        case 2:
            pictureViews.last!.isHidden = true
        default:
            break
        }
    }

    private func resetGrid() {
        pictureViews.forEach { picture in
            picture.isHidden = false
        }
    }
}
