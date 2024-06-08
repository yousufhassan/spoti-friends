import SwiftUI
import WebKit

/// A SwiftUI view that wraps a WKWebView to handle Spotify authorization.
struct AuthorizationWebView: UIViewRepresentable {
    let url: URL
    @Binding var showWebView: Bool
    @Binding var responseUrl: URL?
    @State private var cookies = [HTTPCookie]()
    
    /// Creates a coordinator to act as the navigation delegate.
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    /// Creates the WKWebView instance.
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    /// Updates the WKWebView with the provided URL.
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    /// Coordinator class to handle navigation actions and fetch cookies.
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AuthorizationWebView
        
        init(_ parent: AuthorizationWebView) {
            self.parent = parent
        }
        
        /// Decides how to handle navigation actions.
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let appUrlScheme: String = "spoti-friends"
            if let url = navigationAction.request.url, url.scheme == appUrlScheme {
                // Handle the redirect URL
                parent.responseUrl = url
                parent.showWebView = false
                
                // Fetch cookies from the web view
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
    /// Fetches all cookies from the cookie store.
    func fetchAllCookies(completion: @escaping ([HTTPCookie]) -> Void) {
        var cookies = [HTTPCookie]()
        self.getAllCookies { fetchedCookies in
            cookies.append(contentsOf: fetchedCookies)
            completion(cookies)
        }
    }
}


//#Preview {
//    AuthorizationWebView(url: spotifyAuthUrl, showWebView: true, responseUrl: "")
//}
