
import UIKit

class AddLogViewController: UIViewController, UINavigationControllerDelegate {
 
    @IBOutlet var addImageView: UIImageView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageTouchEvent()
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addImageLog(_ sender: Any) {
        let alert = UIAlertController(title: "게시글 작성", message: "새 글이 작성되었습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        self.present(alert, animated: true)
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
        // 이미지 선택 취소 알림 창 호출
//        self.dismiss(animated: true) { () in
//            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
//            self.present(alert, animated: true)
//        }
    }
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.addImageView.image = img
        
        dismiss(animated: true)
        // 아래 방식 사용 시 이미지 선택 창이 닫히고 이미지 세팅되서 UI상으로 안이쁘다
//        picker.dismiss(animated: true) { () in
//            // 이미지를 이미지 뷰에 표시
//            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
//            self.addImageView.image = img
//        }
    }
    
    func showInputBox() {
        titleStackView.isHidden = false
        contentLabel.isHidden = false
        contentTextField.isHidden = false
    }
}
