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

export { initSortable };
