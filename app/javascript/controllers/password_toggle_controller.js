import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['passwordField', 'showButton', 'hideButton'];

  static values = {
    hidden: { type: Boolean, default: true }
  };

  hiddenValueChanged(newHiddenValue) {
    if(newHiddenValue) {
      this.passwordFieldTarget.type = 'password';
      this.showButtonTarget.classList.remove('hidden');
      this.hideButtonTarget.classList.add('hidden');
    } else {
      this.passwordFieldTarget.type = 'text';
      this.showButtonTarget.classList.add('hidden');
      this.hideButtonTarget.classList.remove('hidden');
    }
  }

  togglePasswordDisplay() {
    this.hiddenValue = !this.hiddenValue;
  }
}
