//
//  KakaoPostCodeViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/30/24.
//

import UIKit
import WebKit
import SnapKit

class KakaoPostCodeViewController: UIViewController {

    // MARK: - Properties
    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    var zipCode = ""
    
    weak var userInfoVC: UserInfoViewController?


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView?.navigationDelegate = self

        guard let url = URL(string: "https://30isdead.github.io/Kakao-Postcode/"),
            let webView = webView
            else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
        
    }

    private func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false

        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false

        webView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        indicator.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func dismissKakaoZipCode() {
        dismiss(animated: true, completion: nil)
    }
}

extension KakaoPostCodeViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
            zipCode = data["zonecode"] as? String ?? ""
        }
        
        userInfoVC?.addressField.text = address
        userInfoVC?.zipCodeField.text = zipCode
        
        dismiss(animated: true, completion: nil)
    }
}

extension KakaoPostCodeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}

