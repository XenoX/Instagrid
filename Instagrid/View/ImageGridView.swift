import UIKit

class ImageGridView: UIView {

    @IBOutlet private var gridViews: [UIView]!
    @IBOutlet private var imageViews: [UIImageView]!

    private var imageTarget: Int = 1

    var layoutNumber: Int = 2 {
        didSet {
            setLayout(layoutNumber)
        }
    }

    private let imageNumbersByLayout = [
        [1, 2, 3],
        [0, 1, 2],
        [0, 1, 2, 3]
    ]

    // MARK: - Public functions
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.8
    }

    public func setImage(_ image: UIImage) {
        imageViews[imageTarget].image = image
        imageViews[imageTarget].contentMode = .scaleAspectFill
    }

    public func canUploadImage(button: UIButton) -> Bool {
        imageTarget = button.tag
        let imageView = imageViews[imageTarget]

        if imageView.contentMode == .scaleAspectFill {
            resetImageView(imageView)

            return false
        }

        return true
    }

    public func isAllRequiredImageSet() -> Bool {
        for imageNumber in imageNumbersByLayout[layoutNumber]
            where imageViews[imageNumber].contentMode != .scaleAspectFill {
            return false
        }

        return true
    }

    public func resetImageViews() {
        imageViews.forEach({ resetImageView($0) })
    }

    // MARK: - Private functions
    private func resetImageView(_ imageView: UIImageView) {
        imageView.contentMode = .center
        imageView.image = UIImage.init(named: "Plus")
    }

    private func setLayout(_ number: Int) {
        gridViews.forEach({ $0.isHidden = false })

        switch number {
        case 0:
            gridViews.first!.isHidden = true
        case 1:
            gridViews.last!.isHidden = true
        default:
            break
        }
    }
}
