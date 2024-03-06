// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
// import { initSortable } from "./sortable";
import Sortable from "sortablejs";

const initSortable = (elements) => {
  elements.forEach((ul) => {
    new Sortable(ul, {
      group: "shared", // set both lists to same group
      animation: 300,
      forceFallback: true,
      onEnd: function (evt) {
        const jobId = evt.item.dataset.id; // assumes each job item has a data-id attribute with the job's id
        const newStatus = evt.to.id;
        const newIndex = evt.newIndex;

        console.log(newIndex);
        fetch(`/jobs/${jobId}/update_status`, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
              .content,
          },
          body: JSON.stringify({ status: newStatus }),
        }).catch((error) => {
          console.error("Error:", error);
        });
      },
    });
  });
};

const initializeStatusSorting = () => {
  const statusUls = document.querySelectorAll(".job-list");
  if (statusUls) {
    initSortable(statusUls);
  }
};

document.addEventListener("turbo:load", initializeStatusSorting);
