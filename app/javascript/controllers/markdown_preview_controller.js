import { Controller } from "@hotwired/stimulus"
import { marked } from "marked"

export default class extends Controller {
  static targets = ["input", "preview"]
  
  connect() {
    this.updatePreview();
  }
  
  updatePreview() {
    const markdown = this.inputTarget.value;
    const html = marked.parse(markdown);
    this.previewTarget.innerHTML = html;
  }
}