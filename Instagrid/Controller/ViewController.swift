import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet var gridImageViews: [UIImageView]!
    @IBOutlet weak var imageGridView: ImageGridView!

    @IBAction func didLongPressLayoutButton(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else {
            return
        }

        resetImageViews()
    }

    @IBAction func didTapUploadButton(_ sender: UIButton) {
        let imageView = gridImageViews[sender.tag - 1]

        if imageView.contentMode == .scaleToFill {
            removeImageFromImageView(imageView)

            return
        }

        imageGridView.imageTarget = sender.tag - 1

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false

        self.present(imagePicker, animated: true)
    }

    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        guard sender.isSelected == false else { return }

        resetLayoutButtons()
        selectLayoutButton(sender)

        resetImageViews()
        
        imageGridView.setLayout(sender.tag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func resetImageViews() {
        gridImageViews.forEach { imageView in
            removeImageFromImageView(imageView)
        }
    }

    private func removeImageFromImageView(_ imageView: UIImageView) {
        imageView.contentMode = .center
        imageView.image = UIImage.init(named: "Plus")
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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            gridImageViews[imageGridView.imageTarget].image = image
            gridImageViews[imageGridView.imageTarget].contentMode = .scaleAspectFill
        }

        self.dismiss(animated: true, completion: nil)
    }
}
