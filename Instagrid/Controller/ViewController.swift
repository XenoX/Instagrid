import UIKit

class ViewController: UIViewController {

    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet weak var imageGridView: ImageGridView!

    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        resetLayoutButtons()
        selectLayoutButton(sender)
        
        imageGridView.setLayout(sender.tag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }

    private func resetLayoutButtons() {
        layoutButtons.forEach { layoutButton in
            layoutButton.isSelected = false
            layoutButton.setImage(nil, for: .normal)
        }
    }

    private func selectLayoutButton(_ layoutButton: UIButton) {
        layoutButton.isSelected = true
        layoutButton.setImage(UIImage.init(named: "Selected"), for: .selected)
    }

    private func setStyle() {
        imageGridView.layer.shadowColor = UIColor.black.cgColor
        imageGridView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageGridView.layer.shadowOpacity = 0.8
    }
}
