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
    }

    private func resetLayoutButtons() {
        layoutButtons.forEach { layoutButton in
            layoutButton.setImage(nil, for: .normal)
            layoutButton.isSelected = false
        }
    }

    private func selectLayoutButton(_ layoutButton: UIButton) {
        layoutButton.isSelected = true
        layoutButton.setImage(UIImage.init(named: "Selected"), for: .selected)
    }
}
