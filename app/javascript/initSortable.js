import Sortable from 'sortablejs';

const initSortable = (elements) => {
  elements.forEach((ul) => {
    new Sortable(ul, {
        group: 'shared', // set both lists to same group
        animation: 300,
        onEnd: function (evt) {
          var jobId = evt.item.dataset.id; // assumes each job item has a data-id attribute with the job's id
          var newStatus = evt.to.id;

          console.log(jobId, newStatus)
          fetch(`/jobs/${jobId}`, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({ status: newStatus }),
          })
          .catch((error) => {
            console.error('Error:', error);
          });
        },
      });
  });
};
export { initSortable };
