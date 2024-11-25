import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['navbar'];
  static values = {
    // Scroll Threshold - Classes to when till how far the page has been scrolled.
    threshold: { type: Number, default: 20 },
    // Classes to apply when the page is not scrolled.
    topClasses: { type: Array },
    // Classes to apply when the page has been scrolled
    scrollClasses: { type: Array },
  };

  initialize() {
    this.switchClasses();
  }

  switchClasses() {
    if (window.scrollY > this.thresholdValue) {
      this.navbarTarget.classList.remove(...this.topClassesValue);
      this.navbarTarget.classList.add(...this.scrollClassesValue);
    } else {
      this.navbarTarget.classList.remove(...this.scrollClassesValue);
      this.navbarTarget.classList.add(...this.topClassesValue);
    }
  }
}
