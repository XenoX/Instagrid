import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet weak var imageGridView: ImageGridView!
    @IBOutlet var swipeStackViews: [UIStackView]!

    let imagePicker = UIImagePickerController()

    // MARK: - Interface Builder Actions
    @IBAction func swipeForShare(_ sender: UISwipeGestureRecognizer) {
        if (UIDevice.current.orientation.isLandscape && sender.direction != .left) ||
            (UIDevice.current.orientation.isPortrait && sender.direction != .up) {
            return
        }

        guard imageGridView.isAllRequiredImageSet() else {
            let shareAlert = UIAlertController(title: "You need to set all image before share!", message: "", preferredStyle: .alert)
            shareAlert.addAction(UIAlertAction(title: "Ok 👍", style: .default, handler: nil))
            present(shareAlert, animated: true)

            return
        }

        let shareActivity = UIActivityViewController(activityItems: [imageGridView.image! as Any], applicationActivities: nil)
        present(shareActivity, animated: true)
    }

    @IBAction func didLongPressLayoutButton(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else {
            return
        }

        imageGridView.resetImageViews()
    }

    @IBAction func didTapUploadButton(_ sender: UIButton) {
        guard imageGridView.canUploadImage(button: sender) else {
            return
        }

        self.present(imagePicker, animated: true)
    }

    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        guard sender.isSelected == false else { return }

        resetLayoutButtons()

        sender.isSelected = true
        sender.setImage(UIImage.init(named: "Selected"), for: .selected)

        imageGridView.layoutNumber = sender.tag
    }

    @IBAction func didDoubleTapForChangeColor(_ sender: UITapGestureRecognizer) {
        imageGridView.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }

    // MARK: - Public functions
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageGridView.setImage(image)
        }

        updateSwipeLabel()

        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Private functions
    private func resetLayoutButtons() {
        layoutButtons.forEach { layoutButton in
            layoutButton.isSelected = false
            layoutButton.setImage(nil, for: .normal)
        }
    }

    private func updateSwipeLabel() {
        if imageGridView.isAllRequiredImageSet() {
            swipeStackViews.forEach { swipeStackView in
                swipeStackView.isHidden = false
            }

            return
        }

        swipeStackViews.forEach { swipeStackView in
            swipeStackView.isHidden = true
        }
    }
}
