
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private var scrollView: UIScrollView!


    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("SKIP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        button.setTitleColor(#colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1), for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.8990607262, green: 0.8990607262, blue: 0.8990607262, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
       return line
    }()
    
//
    var nextButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        
        config.title = "다음"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-SemiBold", size: 17)
            outgoing.foregroundColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            return outgoing
        }

        var button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.isEnabled = false
        
        return button
    }()
    
    
    private let numberOfPages = 7
    private let pageWidth: CGFloat = UIScreen.main.bounds.width
    
    private let pageColors: [UIColor] = [.systemRed, .systemGreen, .systemBlue , .white , .blue , .brown , .cyan]
    
    
    
    
    //MARK: - main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupScrollView()
        setUI()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        setupBackButton()
        
        skipButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        updateButtonState(for: 0)
    }
    
    
    func setUI() {
        view.addSubview(nextButton)
        view.addSubview(line)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -13.5),
            nextButton.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: 10.6),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            skipButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33.2),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55.1),
            
            
            line.widthAnchor.constraint(equalToConstant: 2),
            line.heightAnchor.constraint(equalToConstant: 20),
            line.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62.1),
            line.leadingAnchor.constraint(equalTo: skipButton.trailingAnchor, constant: 8.6),
            
           
        ])
    }
    
    
    
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: pageWidth * CGFloat(numberOfPages), height: scrollView.frame.height)
        view.addSubview(scrollView)
        
        for i in 0..<numberOfPages {
            let page = UIView(frame: CGRect(x: pageWidth * CGFloat(i), y: 0, width: pageWidth, height: scrollView.frame.height))
            page.backgroundColor = pageColors[i]
//            page.backgroundColor = .white
            // 페이지별로 다른 컴포넌트 추가
            switch i {
            case 0:
                addLabelToPage(page, text: "Welcome to Page 1")
            case 1:
                addButtonToPage(page)
            case 2:
                addImageToPage(page)
            default:
                break
            }
            
            scrollView.addSubview(page)
        }
    }
    
    private func addLabelToPage(_ page: UIView, text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: pageWidth, height: 50))
        label.center = CGPoint(x: pageWidth / 2, y: page.frame.height / 2)
        label.textAlignment = .center
        label.text = text
        label.textColor = .white
        page.addSubview(label)
    }
    
    private func addButtonToPage(_ page: UIView) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center = CGPoint(x: pageWidth / 2, y: page.frame.height / 2)
        button.setTitle("Tap me!", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
//        button.addTarget(self, action: #selector(pageButtonTapped), for: .touchUpInside)
        page.addSubview(button)
    }
    
    func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 37),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    
    private func addImageToPage(_ page: UIView) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.center = CGPoint(x: pageWidth / 2, y: page.frame.height / 2)
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        page.addSubview(imageView)
    }
    
    
    
  
        @objc private func nextButtonTapped() {
            print("다음 버튼이 탭되었습니다.")
            let currentPage = Int(scrollView.contentOffset.x / pageWidth)
            let nextPage = min(currentPage + 1, numberOfPages - 1)
            let xOffset = CGFloat(nextPage) * pageWidth
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
        }
    
    
    
    private func updateButtonState(for page: Int) {
        nextButton.isEnabled = page < numberOfPages - 1
        skipButton.isHidden = page == numberOfPages - 1
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        updateButtonState(for: currentPage)
    }
        
    @objc private func goBack() {
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        let previousPage = max(currentPage - 1, 0)
        let xOffset = CGFloat(previousPage) * pageWidth
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
        updateButtonState(for: previousPage)
    }
    
    
}

    


