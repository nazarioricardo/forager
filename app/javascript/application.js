// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import Sortable from "sortablejs";
import { initSortable } from "./sortable";

const initializeStatusSorting = () => {
  const statusUls = document.querySelectorAll(".job-list");
  if (statusUls) {
    initSortable(statusUls);
  }
};

document.addEventListener("turbo:load", initializeStatusSorting);
