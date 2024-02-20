export async function registerServiceWorker(path) {
    if (!navigator.serviceWorker) return

    try {
        const registration = navigator.serviceWorker.register(path)
        console.log("Service worker registered", registration)
        return registration
    } catch (error) {
        console.error("Error installing service worker", error)
    }
}

export async function requestNotifications() {
    const result = await Notification.requestPermission()
    return result === "granted"
}

export async function setupSubscription() {
    if (window.Notification?.permission !== "granted") return
    if (!navigator.serviceWorker) return

    let key_bytes = document.querySelector("meta[name=web_push_public]")?.content
    let vapid = new Uint8Array(JSON.parse(key_bytes))

    const registration = await navigator.serviceWorker.ready
    return await registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: vapid
    })
}

export async function saveSubscription(subscriptionsPath) {
    if (window.Notification?.permission !== "granted") return
    if (!navigator.serviceWorker) return

    const registration = await navigator.serviceWorker.ready
    const subscription = await getSubscription()
    if (!subscription) return

    return await fetch(subscriptionsPath, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(subscription)
    })
}

export async function getSubscription() {
    if (window.Notification?.permission !== "granted") return
    if (!navigator.serviceWorker) return

    const registration = await navigator.serviceWorker.ready
    return await registration.pushManager.getSubscription()
}