import UIKit

class ImageGridView: UIView {
    @IBOutlet private var pictures: [UIView]!

    public func setLayout(_ nbLayout: Int) {
        resetGrid()

        switch nbLayout {
        case 1:
            pictures.first!.isHidden = true
        case 2:
            pictures.last!.isHidden = true
        default:
            break
        }
    }

    private func resetGrid() {
        pictures.forEach { picture in
            picture.isHidden = false
        }
    }
}
