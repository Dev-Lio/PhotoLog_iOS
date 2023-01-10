
import UIKit

class AddLogViewController: UIViewController, UINavigationControllerDelegate {
 
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageTouchEvent()
        setKeyboardNotification()
        setTextviewPlaceholder()
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addImageLog(_ sender: Any) {
        let alert = UIAlertController(title: "새 기록 작성", message: "새로운 기록이 저장되었습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        self.present(alert, animated: true)
    }
   
    // Hide Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        contentTextView.resignFirstResponder()
    }
}

// MARK : AddImageView touch event
extension AddLogViewController: UIImagePickerControllerDelegate {
    
    // 이미지 선택 터치 이벤트 세팅
    func setImageTouchEvent(){
        let imagePickGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        addImageView.addGestureRecognizer(imagePickGesture)
        addImageView.isUserInteractionEnabled = true
    }
    
    // 이미지 피커 컨트롤러 생성
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true // 이미지 편집 기능 On
        picker.delegate = self // 델리게이트 지정
        present(picker, animated: true)
    }
        
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.addImageView.image = selectedImage
        dismiss(animated: true)
        showInputBox()
    }
    
    func showInputBox() {
        scrollView.isScrollEnabled = true
        scrollView.scrollToBottom(animated: true)
        titleLabel.isHidden = false
        titleTextField.isHidden = false
        contentLabel.isHidden = false
        contentTextView.isHidden = false
    }
}

// MARK : ScrollView Move Bottom
extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}

// MARK : Textview Placeholder
extension AddLogViewController: UITextViewDelegate {
    
    func setTextviewPlaceholder() {
        //textview에 delegate 상속
        contentTextView.delegate = self
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        contentTextView.text = "오늘의 기록을 남겨주세요\n\n\n"
        contentTextView.textColor = UIColor.lightGray
        //텍스트뷰가 구분되게끔 테두리를 주도록 하겠습니다.
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.borderColor = UIColor.white.cgColor
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text.isEmpty {
            contentTextView.text = "오늘의 기록을 남겨주세요\n\n\n"
            contentTextView.textColor = UIColor.lightGray
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextView.textColor == UIColor.lightGray {
            contentTextView.text = nil
            contentTextView.textColor = UIColor.white
        }
    }
}

// MARK : Keyboard Setting
extension AddLogViewController {
    
    private func setKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              var keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
