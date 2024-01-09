import Sortable from "sortablejs";

document.addEventListener("turbolinks:load", function () {
  ['created', 'applied', 'interviewing', 'done'].forEach(function (status) {
    var el = document.getElementById(status);
    if (el) {
      Sortable.create(el, {
        group: 'shared', // allows items to be dragged between lists
        animation: 150,
        onEnd: function (evt) {
          var jobId = evt.item.dataset.id; // assumes each job item has a data-id attribute with the job's id
          var newStatus = evt.to.id;
          // TODO: make an AJAX request to update the job's status
        },
      });
    }
  });
});