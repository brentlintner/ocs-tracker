import React, { Component } from "react"
import { BackHandler, Platform, StatusBar, Linking } from "react-native"
import { WebView } from "react-native-webview"

type Props = {}

const APP_DOMAIN = "ocs-tracker.app"
const APP_URI = "https://" + APP_DOMAIN
const APP_URI_REGEXP = new RegExp(APP_DOMAIN)

export default class App extends Component<Props> {
  webView = {
    canGoBack: false,
    ref: null
  }

  // TODO: exit app when canGoBack is false
  //       web app uses turbolinks which doesn't trigger NavigationStateChange?
  onAndroidBackPress() {
    this.webView.ref.goBack()
  }

  openExternalURLInBrowser(event) {
    if (!APP_URI_REGEXP.test(event.url)) {
      Linking.openURL(event.url)
      return false
    }
    return true
  }

  componentWillMount() {
    if (Platform.OS == "android") {
      BackHandler.addEventListener(
        "hardwareBackPress",
        this.onAndroidBackPress)
    }
  }

  componentWillUnmount() {
    if (Platform.OS == "android") {
      BackHandler.removeEventListener("hardwareBackPress")
    }
  }

  render() {
    return (
      <React.Fragment>
        <StatusBar backgroundColor="#2196F3" barStyle="default" />
        <WebView
          source={{ uri: APP_URI }}
          ref={(webView) => { this.webView.ref = webView }}
          onShouldStartLoadWithRequest={(event) => {
            this.openExternalURLInBrowser(event)
          }}
        />
      </React.Fragment>
    )
  }
}
