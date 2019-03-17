import UIKit

class ImageGridView: UIView {
    @IBOutlet private var gridViews: [UIView]!
    @IBOutlet private var imageViews: [UIImageView]!

    private var imageTarget: Int = 1
    private var layoutNumber: Int = 2

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

    public func setLayout(_ number: Int) {
        resetGrid()
        layoutNumber = number

        switch number {
        case 0:
            gridViews.first!.isHidden = true
        case 1:
            gridViews.last!.isHidden = true
        default:
            break
        }
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
        for imageNumber in imageNumbersByLayout[layoutNumber] where imageViews[imageNumber].contentMode != .scaleAspectFill {
            return false
        }

        return true
    }

    public func resetImageViews() {
        imageViews.forEach { imageView in
            resetImageView(imageView)
        }
    }

    public func changeColor() {
        backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }

    @objc public func test() {
        print("COUCOU")
    }

    // MARK: - Private functions
    private func resetGrid() {
        gridViews.forEach { view in
            view.isHidden = false
        }
    }

    private func resetImageView(_ imageView: UIImageView) {
        imageView.contentMode = .center
        imageView.image = UIImage.init(named: "Plus")
    }
}
