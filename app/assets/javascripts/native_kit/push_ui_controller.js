import { Controller } from "@hotwired/stimulus"
import * as NK from "native_kit/native_kit"

// Connects to data-controller="push-ui"
export default class extends Controller {
  static values = {
    endpoints: { type: Array, default: [] },

    serviceWorkerPath: { type: String, default: "/service_worker.js" },
    subscriptionsPath: { type: String, default: "/native_kit/subscriptions" },
    vapidKeyName: { type: String, default: "web_push_public_key" },
  }

  connect() {
    this.updateDisplay()
  }

  updateDisplay() {
    switch (window.Notification?.permission) {
      case null:
        this.hideUI()
        // not supported, NOOP
        return
      case "granted":
        this.hideUI()
        this.postSubscription()
        return
      case "denied":
        this.hideUI()
        return
      default:
        this.showUI()
    }
  }

  showUI() {
    this.element.classList.remove("hidden")
  }

  hideUI() {
    this.element.classList.add("hidden")
  }

  async prompt() {
    const permitted = await NK.requestNotifications()
    this.hideUI()

    if (!permitted) {
      console.info("Notifications declined")
      return
    }

    await NK.registerServiceWorker(this.serviceWorkerPathValue)
    await NK.setupSubscription(this.vapidKeyNameValue)
    await NK.saveSubscription(this.subscriptionsPathValue)
  }

  async postSubscription() {
    await NK.registerServiceWorker(this.serviceWorkerPathValue)
    const subscription = await NK.getSubscription()

    if (subscription && !this.endpointsValue.includes(subscription.endpoint)) {
      NK.saveSubscription(this.subscriptionsPathValue)
    }
  }
}
