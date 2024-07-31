import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["source", "button"]
    static values = { successContent: String }

    connect() {
        console.log("Clipboard controller connected")
    }

    copy(event) {
        event.preventDefault()

        const text = this.sourceTarget.value
        const decodedText = this.decodeHtmlEntities(text)

        navigator.clipboard.writeText(decodedText).then(
            () => this.copiedSuccessfully(),
            () => this.copyFailed()
        )
    }

    decodeHtmlEntities(text) {
        const textArea = document.createElement('textarea')
        textArea.innerHTML = text
        return textArea.value
    }

    copiedSuccessfully() {
        const originalText = this.buttonTarget.textContent
        this.buttonTarget.textContent = this.successContentValue

        setTimeout(() => {
            this.buttonTarget.textContent = originalText
        }, 2000)
    }

    copyFailed() {
        console.error("Failed to copy text to clipboard")
        // Optionally, you can update the button text here as well
        this.buttonTarget.textContent = "Copy failed"
    }
}