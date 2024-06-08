import SwiftUI
import WebKit

struct AuthorizationWebView: UIViewRepresentable {
    let url: URL
    @Binding var showWebView: Bool
    @Binding var responseUrl: URL?
    @State private var cookies = [HTTPCookie]()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AuthorizationWebView
        
        init(_ parent: AuthorizationWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, url.scheme == "spoti-friends" {
                // Handle the redirect URL
                parent.responseUrl = url
                parent.showWebView = false
                
                // Fetch cookies
                webView.configuration.websiteDataStore.httpCookieStore.fetchAllCookies { cookies in
                    self.parent.cookies = cookies
                    print(cookies)
                }
                
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
    }
}

extension WKHTTPCookieStore {
    func fetchAllCookies(completion: @escaping ([HTTPCookie]) -> Void) {
        var cookies = [HTTPCookie]()
        self.getAllCookies { fetchedCookies in
            cookies.append(contentsOf: fetchedCookies)
            completion(cookies)
        }
    }
}




//struct AuthorizationWebView: UIViewRepresentable {
//    let url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        webView.load(request)
//    }
//
//    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
//            print("into new method")
//            if(navigationAction.navigationType == .other) {
//                if let redirectedUrl = navigationAction.request.url {
//                    print("Into IF statement")
//                    print(redirectedUrl)
//                    //do what you need with url
//                    //self.delegate?.openURL(url: redirectedUrl)
//                }
//                decisionHandler(.cancel)
//                return
//            }
//            decisionHandler(.allow)
//        }
//}

//#Preview {
//    AuthorizationWebView()
//}
