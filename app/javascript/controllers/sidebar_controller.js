import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ['sidebar', 'backdrop'];
  static values = {
    isOpen: { type: Boolean, default: false },
    closeClasses: { type: Array, default: ['w-0'] },
    openClasses: { type: Array, default: ['w-60'] },
    closeBackdropClasses: { type: Array, default: ['w-0', 'bg-opacity-0'] },
    openBackdropClasses: { type: Array, default: ['w-screen', 'bg-opacity-50'] },
  }

  isOpenValueChanged(newIsOpen) {
    if (newIsOpen === true) {
      this.backdropTarget.classList.add(...this.openBackdropClassesValue);
      this.backdropTarget.classList.remove(...this.closeBackdropClassesValue);
      this.sidebarTarget.classList.add(...this.openClassesValue);
      this.sidebarTarget.classList.remove(...this.closeClassesValue);
    } else {
      this.backdropTarget.classList.remove(...this.openBackdropClassesValue);
      this.backdropTarget.classList.add(...this.closeBackdropClassesValue);
      this.sidebarTarget.classList.add(...this.closeClassesValue);
      this.sidebarTarget.classList.remove(...this.openClassesValue);
    }
  }

  close() {
    this.isOpenValue = false;
  }

  open() {
    this.isOpenValue = true;
  }
}
