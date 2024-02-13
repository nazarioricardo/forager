// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import { initSortable } from "./initSortable";

document.addEventListener("turbo:load", () => {
  const statusUls = document.querySelectorAll(".job-list");
  if (statusUls) {
    initSortable(statusUls);
  }
});
