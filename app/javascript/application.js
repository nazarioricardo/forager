// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { initSortable } from "./initSortable";

console.log("hello?")
document.addEventListener('turbo:load', () => {
  console.log('hello')
  const statusUls = document.querySelectorAll(".job-status");
  console.log('uls', statusUls)
  if (statusUls) {
    initSortable(statusUls);
  }
});
