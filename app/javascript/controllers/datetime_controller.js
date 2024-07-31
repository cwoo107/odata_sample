// app/javascript/controllers/datetime_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "formattedInput"]

    connect() {
        this.updateFormattedInput()
    }

    updateFormattedInput() {
        const inputDate = new Date(this.inputTarget.value)
        const formattedDate = this.formatDate(inputDate)
        this.formattedInputTarget.value = formattedDate
    }

    formatDate(date) {
        if (isNaN(date.getTime())) {
            return ""
        }
        const isoString = date.toISOString()
        return isoString.slice(0, -1) + "000Z"
    }
}